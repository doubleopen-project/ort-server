/*
 * Copyright (C) 2022 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
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

package org.eclipse.apoapsis.ortserver.dao.tables.runs.analyzer

import org.eclipse.apoapsis.ortserver.model.runs.PackageManagerConfiguration

import org.jetbrains.exposed.dao.LongEntity
import org.jetbrains.exposed.dao.LongEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.LongIdTable

/**
 * A table to represent a package manager configuration.
 */
object PackageManagerConfigurationsTable : LongIdTable("package_manager_configurations") {
    val name = text("name")
    val mustRunAfter = text("must_run_after").nullable()
    val hasOptions = bool("has_options")
}

class PackageManagerConfigurationDao(id: EntityID<Long>) : LongEntity(id) {
    companion object : LongEntityClass<PackageManagerConfigurationDao>(PackageManagerConfigurationsTable)

    var name by PackageManagerConfigurationsTable.name
    @Suppress("DEPRECATION") // See https://youtrack.jetbrains.com/issue/EXPOSED-483.
    var mustRunAfter: List<String>? by PackageManagerConfigurationsTable.mustRunAfter
        .transform({ it?.joinToString(",") }, { it?.split(",") })
    var hasOptions by PackageManagerConfigurationsTable.hasOptions

    val options by PackageManagerConfigurationOptionDao referrersOn
            PackageManagerConfigurationOptionsTable.packageManagerConfigurationId

    fun mapToModel() = PackageManagerConfiguration(
        mustRunAfter = mustRunAfter,
        options = if (hasOptions) options.associate { it.name to it.value } else null
    )
}
