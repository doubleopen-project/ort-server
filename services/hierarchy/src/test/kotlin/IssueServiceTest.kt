/*
 * Copyright (C) 2024 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
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

package org.eclipse.apoapsis.ortserver.services

import io.kotest.core.spec.style.WordSpec
import io.kotest.matchers.shouldBe

import kotlinx.datetime.Clock

import org.eclipse.apoapsis.ortserver.dao.test.DatabaseTestExtension
import org.eclipse.apoapsis.ortserver.dao.test.Fixtures
import org.eclipse.apoapsis.ortserver.model.AdvisorJobConfiguration
import org.eclipse.apoapsis.ortserver.model.AnalyzerJobConfiguration
import org.eclipse.apoapsis.ortserver.model.JobConfigurations
import org.eclipse.apoapsis.ortserver.model.OrtRun
import org.eclipse.apoapsis.ortserver.model.PluginConfiguration
import org.eclipse.apoapsis.ortserver.model.RepositoryType
import org.eclipse.apoapsis.ortserver.model.Severity
import org.eclipse.apoapsis.ortserver.model.runs.AnalyzerConfiguration
import org.eclipse.apoapsis.ortserver.model.runs.Environment
import org.eclipse.apoapsis.ortserver.model.runs.Identifier
import org.eclipse.apoapsis.ortserver.model.runs.Issue
import org.eclipse.apoapsis.ortserver.model.runs.Package
import org.eclipse.apoapsis.ortserver.model.runs.ProcessedDeclaredLicense
import org.eclipse.apoapsis.ortserver.model.runs.RemoteArtifact
import org.eclipse.apoapsis.ortserver.model.runs.VcsInfo
import org.eclipse.apoapsis.ortserver.model.runs.advisor.AdvisorConfiguration
import org.eclipse.apoapsis.ortserver.model.runs.advisor.AdvisorResult
import org.eclipse.apoapsis.ortserver.model.util.OrderDirection

import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SortOrder

class IssueServiceTest : WordSpec() {
    private val dbExtension = extension(DatabaseTestExtension())

    private lateinit var db: Database
    private lateinit var fixtures: Fixtures

    init {
        beforeEach {
            db = dbExtension.db
            fixtures = dbExtension.fixtures
        }

        "OrderDirection.toSortOrder" should {
            "return SortOrder.ASC when OrderDirection is ASCENDING" {
                OrderDirection.ASCENDING.toSortOrder() shouldBe SortOrder.ASC
            }

            "return SortOrder.DESC when OrderDirection is DESCENDING" {
                OrderDirection.DESCENDING.toSortOrder() shouldBe SortOrder.DESC
            }
        }

        "countForOrtRunIds" should {
            "return issue count for ORT run" {
                val service = IssueService(db)
                val repositoryId = fixtures.createRepository().id

                val ortRun = createOrtRunWithIssues(
                    repositoryId,
                    analyzerIssues = listOf(
                        Issue(
                            timestamp = Clock.System.now(),
                            source = "Analyzer",
                            message = "Issue 1",
                            severity = Severity.ERROR,
                            affectedPath = "path"
                        ),
                    ),
                    advisorIssues = listOf(
                        Issue(
                            timestamp = Clock.System.now(),
                            source = "Advisor",
                            message = "Issue 1",
                            severity = Severity.ERROR,
                            affectedPath = "path"
                        ),
                        Issue(
                            timestamp = Clock.System.now(),
                            source = "Advisor",
                            message = "Issue 2",
                            severity = Severity.WARNING,
                            affectedPath = "path"
                        )
                    )
                )

                service.countForOrtRunIds(listOf(ortRun.id)) shouldBe 3
            }

            "return count of unique issues found in ORT runs" {
                val service = IssueService(db)
                val repositoryId = fixtures.createRepository().id

                val commonIssue1 = Issue(
                    timestamp = Clock.System.now(),
                    source = "Analyzer",
                    message = "Issue 1",
                    severity = Severity.ERROR,
                    affectedPath = "path"
                )

                val commonIssue2 = Issue(
                    timestamp = Clock.System.now(),
                    source = "Advisor",
                    message = "Issue 1",
                    severity = Severity.ERROR,
                    affectedPath = "path"
                )

                val ortRun1Id = createOrtRunWithIssues(
                    repositoryId,
                    analyzerIssues = listOf(
                        commonIssue1
                    ),
                    advisorIssues = listOf(
                        commonIssue2,
                        Issue(
                            timestamp = Clock.System.now(),
                            source = "Advisor",
                            message = "Issue 2",
                            severity = Severity.WARNING,
                            affectedPath = "path"
                        )
                    )
                ).id

                val ortRun2Id = createOrtRunWithIssues(
                    repositoryId,
                    analyzerIssues = listOf(
                        commonIssue1,
                        Issue(
                            timestamp = Clock.System.now(),
                            source = "Analyzer",
                            message = "Issue 2",
                            severity = Severity.HINT,
                            affectedPath = "path"
                        )
                    ),
                    advisorIssues = listOf(
                        commonIssue2,
                    )
                ).id

                service.countForOrtRunIds(listOf(ortRun1Id, ortRun2Id)) shouldBe 4
            }
        }
    }

    private fun createOrtRunWithIssues(
        repositoryId: Long,
        analyzerIssues: List<Issue>,
        advisorIssues: List<Issue>
    ): OrtRun {
        val ortRun = fixtures.createOrtRun(
            repositoryId = repositoryId,
            revision = "revision",
            jobConfigurations = JobConfigurations()
        )

        val analyzerJob = fixtures.createAnalyzerJob(
            ortRunId = ortRun.id,
            configuration = AnalyzerJobConfiguration(),
        )

        fixtures.analyzerRunRepository.create(
            analyzerJobId = analyzerJob.id,
            startTime = Clock.System.now(),
            endTime = Clock.System.now(),
            environment = Environment(
                ortVersion = "1.0",
                javaVersion = "11.0.16",
                os = "Linux",
                processors = 8,
                maxMemory = 8321499136,
                variables = emptyMap(),
                toolVersions = emptyMap()
            ),
            config = AnalyzerConfiguration(
                allowDynamicVersions = true,
                enabledPackageManagers = emptyList(),
                disabledPackageManagers = emptyList(),
                packageManagers = emptyMap(),
                skipExcluded = true
            ),
            projects = emptySet(),
            packages = setOf(
                Package(
                    Identifier("Maven", "com.example", "example", "1.0"),
                    purl = "pkg:maven/com.example/example@1.0",
                    cpe = null,
                    authors = emptySet(),
                    declaredLicenses = emptySet(),
                    ProcessedDeclaredLicense(
                        spdxExpression = null,
                        mappedLicenses = emptyMap(),
                        unmappedLicenses = emptySet()
                    ),
                    description = "An example package",
                    homepageUrl = "https://example.com",
                    binaryArtifact = RemoteArtifact(
                        "https://example.com/example-1.0.jar",
                        "sha1:value",
                        "SHA-1"
                    ),
                    sourceArtifact = RemoteArtifact(
                        "https://example.com/example-1.0-sources.jar",
                        "sha1:value",
                        "SHA-1"
                    ),
                    vcs = VcsInfo(
                        RepositoryType("GIT"),
                        "https://example.com/git",
                        "revision",
                        "path"
                    ),
                    vcsProcessed = VcsInfo(
                        RepositoryType("GIT"),
                        "https://example.com/git",
                        "revision",
                        "path"
                    ),
                    isMetadataOnly = false,
                    isModified = false
                ),
            ),
            issues = analyzerIssues,
            dependencyGraphs = emptyMap()
        )

        val advisorJob = fixtures.createAdvisorJob(
            ortRunId = ortRun.id,
            configuration = AdvisorJobConfiguration()
        )

        fixtures.advisorRunRepository.create(
            advisorJobId = advisorJob.id,
            startTime = Clock.System.now(),
            endTime = Clock.System.now(),
            environment = Environment(
                ortVersion = "1.0",
                javaVersion = "11.0.16",
                os = "Linux",
                processors = 8,
                maxMemory = 8321499136,
                variables = emptyMap(),
                toolVersions = emptyMap()
            ),
            config = AdvisorConfiguration(
                config = mapOf(
                    "VulnerableCode" to PluginConfiguration(
                        options = mapOf("serverUrl" to "https://public.vulnerablecode.io"),
                        secrets = mapOf("apiKey" to "key")
                    )
                )
            ),
            results = mapOf(
                Identifier("Maven", "com.example", "example2", "1.0") to listOf(
                    AdvisorResult(
                        advisorName = "Advisor",
                        capabilities = listOf("vulnerabilities"),
                        startTime = Clock.System.now(),
                        endTime = Clock.System.now(),
                        issues = advisorIssues,
                        defects = emptyList(),
                        vulnerabilities = emptyList(),
                    )
                )
            )
        )

        return ortRun
    }
}
