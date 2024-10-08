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

package org.eclipse.apoapsis.ortserver.workers.scanner

import org.eclipse.apoapsis.ortserver.utils.logging.withMdcContext
import org.eclipse.apoapsis.ortserver.workers.common.enableOrtStackTraces

import org.ossreviewtoolkit.utils.common.Os

import org.slf4j.LoggerFactory

private val logger = LoggerFactory.getLogger(ScannerComponent::class.java)

/**
 * This is the entry point of the Scanner worker. It calls the Scanner from ORT programmatically by
 * interfacing on its APIs.
 */
suspend fun main() {
    withMdcContext("component" to "scanner-worker") {
        logger.info("Starting ORT-Server Scanner endpoint.")

        enableOrtStackTraces()
        Os.fixupUserHomeProperty()
        ScannerComponent().start()
    }
}
