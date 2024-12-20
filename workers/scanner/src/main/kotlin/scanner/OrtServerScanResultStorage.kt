/*
 * Copyright (C) 2023 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 * License-Filename: LICENSE
 */

package org.eclipse.apoapsis.ortserver.workers.scanner

import kotlinx.datetime.toKotlinInstant
import kotlinx.serialization.json.Json

import org.eclipse.apoapsis.ortserver.dao.blockingQuery
import org.eclipse.apoapsis.ortserver.dao.repositories.scannerrun.ScannerRunsScanResultsTable
import org.eclipse.apoapsis.ortserver.dao.tables.AdditionalScanResultData
import org.eclipse.apoapsis.ortserver.dao.tables.CopyrightFindingDao
import org.eclipse.apoapsis.ortserver.dao.tables.LicenseFindingDao
import org.eclipse.apoapsis.ortserver.dao.tables.ScanResultDao
import org.eclipse.apoapsis.ortserver.dao.tables.ScanResultDao.Companion.matchesRemoteArtifact
import org.eclipse.apoapsis.ortserver.dao.tables.ScanResultDao.Companion.matchesVcsInfo
import org.eclipse.apoapsis.ortserver.dao.tables.ScanResultsTable
import org.eclipse.apoapsis.ortserver.dao.tables.ScanSummariesIssuesDao
import org.eclipse.apoapsis.ortserver.dao.tables.ScanSummariesTable
import org.eclipse.apoapsis.ortserver.dao.tables.ScanSummaryDao
import org.eclipse.apoapsis.ortserver.dao.tables.SnippetDao
import org.eclipse.apoapsis.ortserver.dao.tables.SnippetFindingDao
import org.eclipse.apoapsis.ortserver.dao.utils.toDatabasePrecision
import org.eclipse.apoapsis.ortserver.dao.utils.utils.JsonHashFunction
import org.eclipse.apoapsis.ortserver.workers.common.mapToModel
import org.eclipse.apoapsis.ortserver.workers.common.mapToOrt

import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.Expression
import org.jetbrains.exposed.sql.ISqlExpressionBuilder
import org.jetbrains.exposed.sql.SizedCollection
import org.jetbrains.exposed.sql.and
import org.jetbrains.exposed.sql.stringLiteral

import org.ossreviewtoolkit.model.ArtifactProvenance
import org.ossreviewtoolkit.model.KnownProvenance
import org.ossreviewtoolkit.model.RepositoryProvenance
import org.ossreviewtoolkit.model.ScanResult
import org.ossreviewtoolkit.model.ScanSummary
import org.ossreviewtoolkit.model.ScannerDetails
import org.ossreviewtoolkit.scanner.ProvenanceBasedScanStorage
import org.ossreviewtoolkit.scanner.ScanStorageException
import org.ossreviewtoolkit.scanner.ScannerMatcher

/**
 * A class providing access to scan results.
 *
 * [ScanResult] are searched by details of a [KnownProvenance] which it is associated with. If the [KnownProvenance] is
 * an [ArtifactProvenance], the URL and the hash value must match. If the [KnownProvenance] is a [RepositoryProvenance],
 * the VCS type, URL and the resolved revision must match.
 *
 * Read and written scan results are associated to the scanner run with the provided [scannerRunId].
 *
 * Throws a [ScanStorageException] if an error occurs while reading from the storage.
 */
class OrtServerScanResultStorage(
    private val db: Database,
    private val scannerRunId: Long
) : ProvenanceBasedScanStorage {
    override fun read(provenance: KnownProvenance, scannerMatcher: ScannerMatcher?): List<ScanResult> =
        db.blockingQuery {
            val scanResultDaos = when (provenance) {
                is ArtifactProvenance -> {
                    ScanResultDao.find { matchesRemoteArtifact(provenance.sourceArtifact.mapToModel()) }
                }

                is RepositoryProvenance -> {
                    ScanResultDao.find {
                        matchesVcsInfo(provenance.vcsInfo.copy(revision = provenance.resolvedRevision).mapToModel())
                    }
                }
            }

            val matchingScanResults = scanResultDaos.associateWith {
                ScanResult(
                    provenance = provenance,
                    scanner = ScannerDetails(
                        name = it.scannerName,
                        version = it.scannerVersion,
                        configuration = it.scannerConfiguration
                    ),
                    summary = it.scanSummary.mapToModel().mapToOrt(),
                    additionalData = it.additionalScanResultData?.data.orEmpty()
                )
            }.filterValues { scannerMatcher?.matches(it.scanner) != false }

            matchingScanResults.forEach { (dao, _) ->
                associateScanResultWithScannerRun(dao)
            }

            matchingScanResults.values.toList()
        }

    override fun write(scanResult: ScanResult) {
        val provenance = scanResult.provenance

        if (provenance !is KnownProvenance) {
            throw ScanStorageException("Scan result must have a known provenance, but it is $provenance.")
        }

        if (provenance is RepositoryProvenance && provenance.vcsInfo.path.isNotEmpty()) {
            throw ScanStorageException("Repository provenances with a non-empty VCS path are not supported.")
        }

        db.blockingQuery {
            val resultDao = findExistingScanResult(scanResult) ?: createNewScanResult(scanResult, provenance)

            associateScanResultWithScannerRun(resultDao)
        }
    }

    /**
     * Create a new database entry for the given [scanResult] for the given [provenance].
     */
    private fun createNewScanResult(scanResult: ScanResult, provenance: KnownProvenance): ScanResultDao {
        val summaryDao = getOrCreateScanSummaryDao(scanResult.summary)

        return ScanResultDao.new {
            when (provenance) {
                is ArtifactProvenance -> {
                    this.artifactUrl = provenance.sourceArtifact.url
                    this.artifactHash = provenance.sourceArtifact.hash.value
                    this.artifactHashAlgorithm = provenance.sourceArtifact.hash.algorithm.toString()
                }

                is RepositoryProvenance -> {
                    this.vcsType = provenance.vcsInfo.type.mapToModel().name
                    this.vcsUrl = provenance.vcsInfo.url
                    this.vcsRevision = provenance.resolvedRevision
                }
            }

            this.scannerName = scanResult.scanner.name
            this.scannerVersion = scanResult.scanner.version
            this.scannerConfiguration = scanResult.scanner.configuration
            this.additionalScanResultData = AdditionalScanResultData(scanResult.additionalData)
            this.scanSummary = summaryDao
        }
    }

    /**
     * Obtain the [ScanSummaryDao] for the given [summary]. Check whether there is already an entity in the database
     * that matches the given [summary]. Create a new instance if necessary.
     */
    private fun getOrCreateScanSummaryDao(summary: ScanSummary): ScanSummaryDao {
        val summaries = ScanSummaryDao.find {
            (ScanSummariesTable.startTime eq summary.startTime.toKotlinInstant().toDatabasePrecision()) and
                    (ScanSummariesTable.endTime eq summary.endTime.toKotlinInstant().toDatabasePrecision())
        }.toList()

        return summaries.takeUnless { it.isEmpty() }?.let { existingSummaries ->
            existingSummaries.firstOrNull { compareScanSummaries(summary, it.mapToModel()) }
        } ?: createScanSummaryDao(summary)
    }

    /**
     * Create a new [ScanSummaryDao] for the given [summary].
     */
    private fun createScanSummaryDao(summary: ScanSummary): ScanSummaryDao {
        val summaryDao = ScanSummaryDao.new {
            this.startTime = summary.startTime.toKotlinInstant()
            this.endTime = summary.endTime.toKotlinInstant()
        }

        summary.issues.forEach {
            ScanSummariesIssuesDao.createByIssue(summaryDao.id.value, it.mapToModel())
        }
        summary.licenseFindings.forEach {
            LicenseFindingDao.new {
                this.scanSummary = summaryDao
                this.license = it.license.toString()
                this.path = it.location.path
                this.startLine = it.location.startLine
                this.endLine = it.location.endLine
                this.score = it.score
            }
        }
        summary.copyrightFindings.forEach {
            CopyrightFindingDao.new {
                this.scanSummary = summaryDao
                this.statement = it.statement
                this.path = it.location.path
                this.startLine = it.location.startLine
                this.endLine = it.location.endLine
            }
        }
        summary.snippetFindings.forEach { snippetFinding ->
            SnippetFindingDao.new {
                this.scanSummary = summaryDao
                this.path = snippetFinding.sourceLocation.path
                this.startLine = snippetFinding.sourceLocation.startLine
                this.endLine = snippetFinding.sourceLocation.endLine
                this.snippets = SizedCollection(
                    snippetFinding.snippets.map { snippet ->
                        SnippetDao.put(snippet.mapToModel())
                    }
                )
            }
        }

        return summaryDao
    }

    private fun associateScanResultWithScannerRun(scanResultDao: ScanResultDao) {
        ScannerRunsScanResultsTable.insertIfNotExists(
            scannerRunId = scannerRunId,
            scanResultId = scanResultDao.id.value
        )
    }
}

/**
 * Check whether there is already an entry in the database matching the given [scanResult]. If so, return it. This is
 * used to prevent duplicate scan result entries. Note that results with additional data are not deduplicated;
 * therefore, this function always returns *null* in this case.
 */
private fun findExistingScanResult(scanResult: ScanResult): ScanResultDao? =
    (scanResult.provenance as? KnownProvenance?)?.let { knownProvenance ->
        ScanResultDao.find {
            when (val provenance = knownProvenance) {
                is ArtifactProvenance ->
                    matchesRemoteArtifact(provenance.sourceArtifact.mapToModel())

                is RepositoryProvenance ->
                    matchesVcsInfo(
                        provenance.vcsInfo.copy(revision = provenance.resolvedRevision).mapToModel()
                    )
            } and matchesBasicScanResultProperties(scanResult)
        }.firstOrNull()
    }

/**
 * Generate an [Expression] to match the properties of the given [scanResult] in the database that do not depend on
 * the provenance.
 */
private fun ISqlExpressionBuilder.matchesBasicScanResultProperties(scanResult: ScanResult): Expression<Boolean> =
    (ScanResultsTable.scannerName eq scanResult.scanner.name) and
            (ScanResultsTable.scannerVersion eq scanResult.scanner.version) and
            (ScanResultsTable.scannerConfiguration eq scanResult.scanner.configuration) and
            (
                    JsonHashFunction(ScanResultsTable.additionalScanResultData) eq
                    JsonHashFunction(
                        stringLiteral(
                            Json.encodeToString(
                                AdditionalScanResultData.serializer(),
                                AdditionalScanResultData(scanResult.additionalData)
                            )
                        )
                    )
            )
