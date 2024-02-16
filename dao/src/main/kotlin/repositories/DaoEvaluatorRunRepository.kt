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

package org.ossreviewtoolkit.server.dao.repositories

import kotlinx.datetime.Instant

import org.jetbrains.exposed.sql.Database

import org.ossreviewtoolkit.server.dao.blockingQuery
import org.ossreviewtoolkit.server.dao.entityQuery
import org.ossreviewtoolkit.server.dao.mapAndDeduplicate
import org.ossreviewtoolkit.server.dao.tables.EvaluatorJobDao
import org.ossreviewtoolkit.server.dao.tables.runs.evaluator.EvaluatorRunDao
import org.ossreviewtoolkit.server.dao.tables.runs.evaluator.EvaluatorRunsTable
import org.ossreviewtoolkit.server.dao.tables.runs.evaluator.RuleViolationDao
import org.ossreviewtoolkit.server.model.repositories.EvaluatorRunRepository
import org.ossreviewtoolkit.server.model.runs.EvaluatorRun
import org.ossreviewtoolkit.server.model.runs.OrtRuleViolation

/**
 * An implementation of [EvaluatorRunRepository] that stores evaluator runs in [EvaluatorRunsTable].
 */
class DaoEvaluatorRunRepository(private val db: Database) : EvaluatorRunRepository {
    override fun create(
        evaluatorJobId: Long,
        startTime: Instant,
        endTime: Instant,
        violations: List<OrtRuleViolation>
    ): EvaluatorRun = db.blockingQuery {
        val ruleViolations = mapAndDeduplicate(violations, RuleViolationDao::getOrPut)

        EvaluatorRunDao.new {
            this.evaluatorJob = EvaluatorJobDao[evaluatorJobId]
            this.startTime = startTime
            this.endTime = endTime
            this.violations = ruleViolations
        }.mapToModel()
    }

    override fun get(id: Long): EvaluatorRun? = db.entityQuery { EvaluatorRunDao[id].mapToModel() }

    override fun getByJobId(evaluatorJobId: Long): EvaluatorRun? = db.entityQuery {
        EvaluatorRunDao.find { EvaluatorRunsTable.evaluatorJobId eq evaluatorJobId }.firstOrNull()?.mapToModel()
    }
}
