/*
 * Copyright (C) 2023 The ORT Project Authors (See <https://github.com/oss-review-toolkit/ort-server/blob/main/NOTICE>)
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

package org.ossreviewtoolkit.server.dao.test.repositories

import io.kotest.core.spec.style.StringSpec
import io.kotest.matchers.nulls.shouldBeNull
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe

import kotlinx.datetime.Clock

import org.ossreviewtoolkit.server.dao.repositories.DaoEvaluatorRunRepository
import org.ossreviewtoolkit.server.dao.test.DatabaseTestExtension
import org.ossreviewtoolkit.server.dao.test.Fixtures
import org.ossreviewtoolkit.server.model.runs.EvaluatorRun

class DaoEvaluatorRunRepositoryTest : StringSpec() {
    private val evaluatorRunRepository = DaoEvaluatorRunRepository()

    private lateinit var fixtures: Fixtures
    private var evaluatorJobId = -1L

    init {
        extension(
            DatabaseTestExtension {
                fixtures = Fixtures()
                evaluatorJobId = fixtures.evaluatorJob.id
            }
        )

        "create should create an entry in the database" {
            val createdEvaluatorRun = evaluatorRunRepository.create(
                evaluatorJobId = evaluatorJobId,
                startTime = Clock.System.now(),
                endTime = Clock.System.now(),
                violations = listOf(fixtures.ruleViolation)
            )

            val dbEntry = evaluatorRunRepository.get(createdEvaluatorRun.id)

            dbEntry.shouldNotBeNull()
            dbEntry shouldBe EvaluatorRun(
                id = createdEvaluatorRun.id,
                evaluatorJobId = evaluatorJobId,
                startTime = createdEvaluatorRun.startTime,
                endTime = createdEvaluatorRun.endTime,
                violations = listOf(fixtures.ruleViolation)
            )
        }

        "get should return null if evaluator run was not found" {
            evaluatorRunRepository.get(1L).shouldBeNull()
        }

        "get should find an evaluator run by evaluator job id" {
            val createdEvaluatorRun = evaluatorRunRepository.create(
                evaluatorJobId = evaluatorJobId,
                startTime = Clock.System.now(),
                endTime = Clock.System.now(),
                violations = listOf(fixtures.ruleViolation)
            )

            evaluatorRunRepository.getByJobId(evaluatorJobId) shouldBe EvaluatorRun(
                id = createdEvaluatorRun.id,
                evaluatorJobId = evaluatorJobId,
                startTime = createdEvaluatorRun.startTime,
                endTime = createdEvaluatorRun.endTime,
                violations = listOf(fixtures.ruleViolation)
            )
        }

        "get should not find an evaluator run by non-existing evaluator job id" {
            evaluatorRunRepository.getByJobId(1L).shouldBeNull()
        }
    }
}
