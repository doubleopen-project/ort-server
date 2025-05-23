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

package org.eclipse.apoapsis.ortserver.dao.repositories.resolvedconfiguration

import org.eclipse.apoapsis.ortserver.dao.repositories.repositoryconfiguration.PackageCurationDao
import org.eclipse.apoapsis.ortserver.dao.repositories.repositoryconfiguration.PackageCurationsTable

import org.jetbrains.exposed.dao.LongEntity
import org.jetbrains.exposed.dao.LongEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.LongIdTable

/**
 * A table to represent a package curation provider.
 */
object ResolvedPackageCurationsTable : LongIdTable("resolved_package_curations") {
    val resolvedPackageCurationProviderId =
        reference("resolved_package_curation_provider_id", ResolvedPackageCurationProvidersTable)
    val packageCurationId = reference("package_curation_id", PackageCurationsTable)

    val rank = integer("rank")
}

class ResolvedPackageCurationDao(id: EntityID<Long>) : LongEntity(id) {
    companion object : LongEntityClass<ResolvedPackageCurationDao>(ResolvedPackageCurationsTable)

    var resolvedPackageCurationProvider by ResolvedPackageCurationProviderDao referencedOn
            ResolvedPackageCurationsTable.resolvedPackageCurationProviderId
    var packageCuration by PackageCurationDao referencedOn ResolvedPackageCurationsTable.packageCurationId

    var rank by ResolvedPackageCurationsTable.rank
}
