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

package org.eclipse.apoapsis.ortserver.workers.reporter

import io.kotest.core.spec.style.WordSpec
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith

import io.mockk.every
import io.mockk.mockk

import kotlin.io.encoding.Base64
import kotlin.io.encoding.ExperimentalEncodingApi
import kotlin.time.Duration.Companion.days
import kotlin.time.Duration.Companion.minutes

import kotlinx.datetime.Clock
import kotlinx.datetime.Instant

@OptIn(ExperimentalEncodingApi::class)
class ReportDownloadLinkGeneratorTest : WordSpec({
    "generateLink" should {
        "generate unique links" {
            val tokenCount = 128
            val generator = ReportDownloadLinkGenerator(LINK_PREFIX, 32, 1.minutes)

            val links = (1..tokenCount).mapTo(mutableSetOf()) { generator.generateLink(RUN_ID).downloadLink }

            links shouldHaveSize tokenCount
        }

        "generate tokens with the correct length" {
            val tokenLength = 64
            val generator = ReportDownloadLinkGenerator(LINK_PREFIX, tokenLength, 1.minutes)

            val token = extractToken(generator.generateLink(RUN_ID).downloadLink)

            val tokenBytes = Base64.UrlSafe.decode(token)
            tokenBytes.size shouldBe tokenLength
        }

        "set the correct expiration time" {
            val referenceTime = Instant.parse("2024-03-22T08:17:00Z")
            val clock = mockk<Clock> {
                every { now() } returns referenceTime
            }

            val generator = ReportDownloadLinkGenerator(LINK_PREFIX, 32, 1.days, clock)
            val link = generator.generateLink(RUN_ID)

            link.expirationTime shouldBe referenceTime + 1.days
        }

        "generate a token if the mechanism is disabled" {
            val generator = ReportDownloadLinkGenerator(LINK_PREFIX, 0, 1.days)

            val link = generator.generateLink(RUN_ID)

            link.downloadLink shouldBe ""
            link.expirationTime shouldBe Instant.fromEpochMilliseconds(0)
        }
    }
})

/** The link prefix used by test instances. */
private const val LINK_PREFIX = "https://reports.example.org"

/** A test run ID used within tests. */
private const val RUN_ID = 20240327074125L

/** The expected prefix for links generated by test instances. */
private const val EXPECTED_LINK_PREFIX = "$LINK_PREFIX/api/v1/runs/$RUN_ID/downloads/report/"

/**
 * Check the format of the given [link] and extract the token.
 */
private fun extractToken(link: String): String {
    link shouldStartWith EXPECTED_LINK_PREFIX
    return link.removePrefix(EXPECTED_LINK_PREFIX)
}
