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

val disableDos = context.ortRun.jobConfigs.parameters["disableDos"].toBoolean()

val defaultJobConfigs = context.ortRun.jobConfigs.copy(
    analyzer = context.ortRun.jobConfigs.analyzer.copy(
        packageCurationProviders = listOf(
            ProviderPluginConfiguration(
                type = "OrtConfig"
            )
        )
    )
)

val jobConfigs = defaultJobConfigs.takeIf { disableDos } ?: defaultJobConfigs.copy(
    scanner = context.ortRun.jobConfigs.scanner?.copy(
        scanners = listOf("DOS"),
        config = mapOf(
            "DOS" to PluginConfig(
                options = mapOf(
                    "readFromStorage" to "false",
                    "writeToStorage" to "true",
                    "url" to "http://api:3001/api/",
                    "frontendUrl" to "http://localhost:3000/packages/",
                    "pollInterval" to "5",
                    "timeout" to "300",
                ),
                secrets = mapOf(
                    "token" to "dosToken",
                )
            )
        )
    ),
    evaluator = context.ortRun.jobConfigs.evaluator?.copy(
        packageConfigurationProviders = listOf(
            ProviderPluginConfiguration(
                type = "DOS",
                options = mapOf(
                    "url" to "http://api:3001/api/",
                    "timeout" to "300",
                ),
                secrets = mapOf(
                    "token" to "dosToken",
                )
            )
        )
    )
)

validationResult = ConfigValidationResultSuccess(resolvedConfigurations = jobConfigs)
