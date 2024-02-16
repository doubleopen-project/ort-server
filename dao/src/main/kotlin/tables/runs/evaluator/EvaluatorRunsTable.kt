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

package org.ossreviewtoolkit.server.dao.tables.runs.evaluator

import org.jetbrains.exposed.dao.LongEntity
import org.jetbrains.exposed.dao.LongEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.LongIdTable
import org.jetbrains.exposed.sql.kotlin.datetime.timestamp

import org.ossreviewtoolkit.server.dao.tables.EvaluatorJobDao
import org.ossreviewtoolkit.server.dao.tables.EvaluatorJobsTable
import org.ossreviewtoolkit.server.dao.utils.toDatabasePrecision
import org.ossreviewtoolkit.server.model.runs.EvaluatorRun

/**
 * A table to represent a summary of an evaluator run.
 */
object EvaluatorRunsTable : LongIdTable("evaluator_runs") {
    val evaluatorJobId = reference("evaluator_job_id", EvaluatorJobsTable)
    val startTime = timestamp("start_time")
    val endTime = timestamp("end_time")
}

class EvaluatorRunDao(id: EntityID<Long>) : LongEntity(id) {
    companion object : LongEntityClass<EvaluatorRunDao>(EvaluatorRunsTable)

    var evaluatorJob by EvaluatorJobDao referencedOn EvaluatorRunsTable.evaluatorJobId
    var startTime by EvaluatorRunsTable.startTime.transform({ it.toDatabasePrecision() }, { it })
    var endTime by EvaluatorRunsTable.endTime.transform({ it.toDatabasePrecision() }, { it })
    var violations by RuleViolationDao via EvaluatorRunsRuleViolationsTable

    fun mapToModel() = EvaluatorRun(
        id = id.value,
        evaluatorJobId = evaluatorJob.id.value,
        startTime = startTime,
        endTime = endTime,
        violations = violations.map { it.mapToModel() }
    )
}
