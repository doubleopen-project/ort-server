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
import io.kotest.matchers.collections.beEmpty
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNot

import io.ktor.client.call.body
import io.ktor.client.request.get
import io.ktor.client.request.post
import io.ktor.http.HttpStatusCode

import org.eclipse.apoapsis.ortserver.components.pluginmanager.PluginDescriptor
import org.eclipse.apoapsis.ortserver.components.pluginmanager.PluginManagerIntegrationTest
import org.eclipse.apoapsis.ortserver.components.pluginmanager.PluginType

import org.ossreviewtoolkit.plugins.advisors.vulnerablecode.VulnerableCodeFactory
import org.ossreviewtoolkit.plugins.packagemanagers.node.npm.NpmFactory

class GetInstalledPluginsIntegrationTest : PluginManagerIntegrationTest({
    "GetInstalledPlugins" should {
        "return all installed ORT plugins" {
            pluginManagerTestApplication { client ->
                val response = client.get("/admin/plugins")

                response shouldHaveStatus HttpStatusCode.OK
                val pluginDescriptors = response.body<List<PluginDescriptor>>()
                enumValues<PluginType>().forEach { pluginType ->
                    pluginDescriptors.filter { it.type == pluginType } shouldNot beEmpty()
                }
            }
        }

        "return if plugins are enabled or disabled" {
            pluginManagerTestApplication { client ->
                val npmType = PluginType.PACKAGE_MANAGER
                val npmId = NpmFactory.descriptor.id
                val vulnerableCodeType = PluginType.ADVISOR
                val vulnerableCodeId = VulnerableCodeFactory.descriptor.id

                client.post("/admin/plugins/$npmType/$npmId/disable") shouldHaveStatus HttpStatusCode.Accepted
                val response = client.get("/admin/plugins")

                response shouldHaveStatus HttpStatusCode.OK
                val descriptors = response.body<List<PluginDescriptor>>()

                descriptors.find { it.type == npmType && it.id == npmId }?.enabled shouldBe false
                descriptors.find { it.type == vulnerableCodeType && it.id == vulnerableCodeId }?.enabled shouldBe true
            }
        }
    }
})
