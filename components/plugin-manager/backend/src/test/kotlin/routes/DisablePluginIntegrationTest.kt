/*
 * Copyright (C) 2025 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
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

package org.eclipse.apoapsis.ortserver.components.pluginmanager.routes

import io.kotest.assertions.ktor.client.shouldHaveStatus

import io.ktor.client.request.post
import io.ktor.http.HttpStatusCode

import org.eclipse.apoapsis.ortserver.components.pluginmanager.PluginManagerIntegrationTest
import org.eclipse.apoapsis.ortserver.components.pluginmanager.PluginType

import org.ossreviewtoolkit.plugins.advisors.vulnerablecode.VulnerableCodeFactory

class DisablePluginIntegrationTest : PluginManagerIntegrationTest({
    "DisablePlugin" should {
        "return Accepted if the plugin was disabled" {
            pluginManagerTestApplication { client ->
                val pluginType = PluginType.ADVISOR
                val pluginId = VulnerableCodeFactory.descriptor.id

                // Disable the plugin first because it is enabled by default.
                client.post("/admin/plugins/$pluginType/$pluginId/disable") shouldHaveStatus HttpStatusCode.Accepted

                // Verify again that the plugin can be disabled after it was enabled.
                client.post("/admin/plugins/$pluginType/$pluginId/enable")
                client.post("/admin/plugins/$pluginType/$pluginId/disable") shouldHaveStatus HttpStatusCode.Accepted
            }
        }

        "return NotFound if the plugin is not installed" {
            pluginManagerTestApplication { client ->
                val pluginType = PluginType.ADVISOR

                client.post("/admin/plugins/$pluginType/unknown/disable") shouldHaveStatus HttpStatusCode.NotFound
            }
        }

        "return NotModified if the plugin was already disabled" {
            pluginManagerTestApplication { client ->
                val pluginType = PluginType.ADVISOR
                val pluginId = VulnerableCodeFactory.descriptor.id

                // Disable the plugin first because it is enabled by default.
                client.post("/admin/plugins/$pluginType/$pluginId/disable")
                client.post("/admin/plugins/$pluginType/$pluginId/disable") shouldHaveStatus HttpStatusCode.NotModified
            }
        }
    }
})
