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

package org.ossreviewtoolkit.server.dao.tables.runs.analyzer

import org.jetbrains.exposed.dao.LongEntity
import org.jetbrains.exposed.dao.LongEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.LongIdTable

/**
 * A table to represent unmapped declared licenses that belong to a
 * [processed declared license][ProcessedDeclaredLicensesTable].
 */
object UnmappedDeclaredLicensesTable : LongIdTable("unmapped_declared_licenses") {
    val unmappedLicense = text("unmapped_license")
}

class UnmappedDeclaredLicenseDao(id: EntityID<Long>) : LongEntity(id) {
    companion object : LongEntityClass<UnmappedDeclaredLicenseDao>(UnmappedDeclaredLicensesTable) {
        fun findByLicense(unmappedLicense: String): UnmappedDeclaredLicenseDao? =
            find { UnmappedDeclaredLicensesTable.unmappedLicense eq unmappedLicense }.singleOrNull()

        fun getOrPut(unmappedLicense: String): UnmappedDeclaredLicenseDao =
            findByLicense(unmappedLicense) ?: new { this.unmappedLicense = unmappedLicense }
    }

    var unmappedLicense by UnmappedDeclaredLicensesTable.unmappedLicense

    val processedDeclaredLicenses by ProcessedDeclaredLicenseDao via
            ProcessedDeclaredLicensesUnmappedDeclaredLicensesTable
}
