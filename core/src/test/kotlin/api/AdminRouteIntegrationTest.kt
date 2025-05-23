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

package org.eclipse.apoapsis.ortserver.core.api

import io.kotest.assertions.ktor.client.shouldHaveStatus
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain

import io.ktor.client.call.body
import io.ktor.client.request.delete
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.client.request.patch
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.client.statement.bodyAsText
import io.ktor.http.HttpStatusCode

import kotlinx.serialization.json.Json

import org.eclipse.apoapsis.ortserver.api.v1.model.ContentManagementSection
import org.eclipse.apoapsis.ortserver.api.v1.model.CreateUser
import org.eclipse.apoapsis.ortserver.api.v1.model.UpdateContentManagementSection
import org.eclipse.apoapsis.ortserver.api.v1.model.User
import org.eclipse.apoapsis.ortserver.components.authorization.roles.Superuser
import org.eclipse.apoapsis.ortserver.core.SUPERUSER
import org.eclipse.apoapsis.ortserver.core.TEST_USER
import org.eclipse.apoapsis.ortserver.utils.test.Integration

class AdminRouteIntegrationTest : AbstractIntegrationTest({
    tags(Integration)

    val testUsername = "test123"
    val testFirstName = "FirstName"
    val testLastName = "LastName"
    val testEmail = "test@test.com"
    val testPassword = "password123"
    val testTemporary = true

    "GET /admin/sync-roles" should {
        "start sync process for permissions and roles" {
            integrationTestApplication {
                val response = superuserClient.get("/api/v1/admin/sync-roles")
                response shouldHaveStatus HttpStatusCode.Accepted
            }
        }

        "require superuser role" {
            requestShouldRequireRole(Superuser.ROLE_NAME, HttpStatusCode.Accepted) {
                get("/api/v1/admin/sync-roles")
            }
        }
    }

    "GET /admin/users" should {
        "return a list of users" {
            integrationTestApplication {
                val response = superuserClient.get("/api/v1/admin/users")

                response shouldHaveStatus HttpStatusCode.OK
                val users = Json.decodeFromString<Set<User>>(response.bodyAsText())
                users.shouldNotBeNull()
                users shouldContain User(
                    username = SUPERUSER.username.value,
                    firstName = SUPERUSER.firstName,
                    lastName = SUPERUSER.lastName,
                    email = SUPERUSER.email
                )
            }
        }

        "require superuser role" {
            requestShouldRequireRole(Superuser.ROLE_NAME, HttpStatusCode.OK) {
                get("/api/v1/admin/users")
            }
        }
    }

    "POST /admin/users" should {
        "create a new user" {
            integrationTestApplication {
                val user = CreateUser(
                    username = testUsername,
                    firstName = testFirstName,
                    lastName = testLastName,
                    email = testEmail,
                    password = testPassword,
                    temporary = testTemporary
                )

                val response = superuserClient.post("/api/v1/admin/users") {
                    setBody(user)
                }

                response shouldHaveStatus HttpStatusCode.Created
            }
        }

        "respond with an internal error if the user already exists" {
            integrationTestApplication {
                val user = CreateUser(
                    username = testUsername,
                    firstName = testFirstName,
                    lastName = testLastName,
                    email = testEmail,
                    password = testPassword,
                    temporary = testTemporary
                )

                superuserClient.post("/api/v1/admin/users") {
                    setBody(user)
                }
                val response = superuserClient.post("/api/v1/admin/users") {
                    setBody(user)
                }

                response shouldHaveStatus HttpStatusCode.InternalServerError
            }
        }

        "require superuser role" {
            requestShouldRequireRole(Superuser.ROLE_NAME, HttpStatusCode.Created) {
                post("/api/v1/admin/users") {
                    setBody(
                        CreateUser(
                            username = testUsername,
                            firstName = testFirstName,
                            lastName = testLastName,
                            email = testEmail,
                            password = testPassword,
                            temporary = testTemporary
                        )
                    )
                }
            }
        }
    }

    "DELETE /admin/users" should {
        "delete a user" {
            integrationTestApplication {
                val response = superuserClient.delete("/api/v1/admin/users") {
                    parameter("username", TEST_USER.username.value)
                }

                response shouldHaveStatus HttpStatusCode.NoContent
            }
        }

        "respond with an internal error if the user doesn't exist" {
            integrationTestApplication {
                superuserClient.delete("/api/v1/admin/users") {
                    parameter("username", TEST_USER.username.value)
                }
                val response = superuserClient.delete("/api/v1/admin/users") {
                    parameter("username", TEST_USER.username.value)
                }

                response shouldHaveStatus HttpStatusCode.InternalServerError
            }
        }

        "require superuser role" {
            requestShouldRequireRole(Superuser.ROLE_NAME, HttpStatusCode.NoContent) {
                delete("/api/v1/admin/users") {
                    parameter("username", TEST_USER.username.value)
                }
            }
        }
    }

    "GET /admin/content-management/sections/footer" should {
        "return the footer section" {
            integrationTestApplication {
                val response = testUserClient.get("/api/v1/admin/content-management/sections/footer")

                response shouldHaveStatus HttpStatusCode.OK
                val section = response.body<ContentManagementSection>()

                with(section) {
                    id shouldBe "footer"
                    isEnabled shouldBe false
                    markdown shouldContain "footer"
                }
            }
        }

        "return 404 NotFound for non-existing section" {
            integrationTestApplication {
                val response = testUserClient.get("/api/v1/admin/content-management/sections/non-existing")

                response shouldHaveStatus HttpStatusCode.NotFound
            }
        }

        "return 401 Unauthorized if not authenticated" {
            integrationTestApplication {
                val response = unauthenticatedClient.get("/api/v1/admin/content-management/sections/footer")

                response shouldHaveStatus HttpStatusCode.Unauthorized
            }
        }
    }

    "PATCH /admin/content-management/sections/footer" should {
        "return 403 Forbidden for non-superuser" {
            integrationTestApplication {
                val updateSectionRequest = UpdateContentManagementSection(
                    isEnabled = true,
                    markdown = "This is a changed footer."
                )

                val response = testUserClient.patch("/api/v1/admin/content-management/sections/footer") {
                    setBody(updateSectionRequest)
                }

                response shouldHaveStatus HttpStatusCode.Forbidden
            }
        }

        "update the footer section" {
            integrationTestApplication {
                val updateSectionRequest = UpdateContentManagementSection(
                    isEnabled = true,
                    markdown = "empty"
                )

                val response = superuserClient.patch("/api/v1/admin/content-management/sections/footer") {
                    setBody(updateSectionRequest)
                }

                response shouldHaveStatus HttpStatusCode.OK
                val section = response.body<ContentManagementSection>()

                with(section) {
                    id shouldBe "footer"
                    isEnabled shouldBe true
                    markdown shouldBe "empty"
                }
            }
        }

        "return 404 NotFound for non-existing section" {
            integrationTestApplication {
                val updateSectionRequest = UpdateContentManagementSection(
                    isEnabled = true,
                    markdown = "empty"
                )

                val response = superuserClient.patch("/api/v1/admin/content-management/sections/non-existing") {
                    setBody(updateSectionRequest)
                }

                response shouldHaveStatus HttpStatusCode.NotFound
            }
        }
    }
})
