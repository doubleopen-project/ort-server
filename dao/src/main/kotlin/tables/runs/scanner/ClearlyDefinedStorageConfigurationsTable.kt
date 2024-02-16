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

package org.ossreviewtoolkit.server.dao.tables.runs.scanner

import org.jetbrains.exposed.dao.LongEntity
import org.jetbrains.exposed.dao.LongEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.LongIdTable

import org.ossreviewtoolkit.server.model.runs.scanner.ClearlyDefinedStorageConfiguration

/**
 * A table to represent a configuration of a ClearlyDefined storage.
 */
object ClearlyDefinedStorageConfigurationsTable : LongIdTable("clearly_defined_storage_configurations") {
    val serverUrl = text("server_url")
}

class ClearlyDefinedStorageConfigurationDao(id: EntityID<Long>) : LongEntity(id) {
    companion object :
        LongEntityClass<ClearlyDefinedStorageConfigurationDao>(ClearlyDefinedStorageConfigurationsTable) {
        fun findByClearlyDefinedStorageConfiguration(
            clearlyDefinedStorageConfiguration: ClearlyDefinedStorageConfiguration
        ): ClearlyDefinedStorageConfigurationDao? =
            find {
                ClearlyDefinedStorageConfigurationsTable.serverUrl eq clearlyDefinedStorageConfiguration.serverUrl
            }.singleOrNull()

        fun getOrPut(
            clearlyDefinedStorageConfiguration: ClearlyDefinedStorageConfiguration
        ): ClearlyDefinedStorageConfigurationDao =
            findByClearlyDefinedStorageConfiguration(clearlyDefinedStorageConfiguration) ?: new {
                this.serverUrl = clearlyDefinedStorageConfiguration.serverUrl
            }
    }

    var serverUrl by ClearlyDefinedStorageConfigurationsTable.serverUrl

    fun mapToModel() = ClearlyDefinedStorageConfiguration(serverUrl)
}
