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

package org.eclipse.apoapsis.ortserver.dao.repositories.infrastructureservice

import org.eclipse.apoapsis.ortserver.dao.repositories.ortrun.OrtRunsTable

import org.jetbrains.exposed.sql.Table

/**
 * An intermediate table to store references from [InfrastructureServicesTable] to [OrtRunsTable].
 */
object InfrastructureServicesRunsTable : Table("infrastructure_services_ort_runs") {
    val infrastructureServiceId = reference("infrastructure_service_id", InfrastructureServicesTable)
    val ortRunId = reference("ort_run_id", OrtRunsTable)

    override val primaryKey: PrimaryKey
        get() = PrimaryKey(infrastructureServiceId, ortRunId, name = "${tableName}_pkey")
}
