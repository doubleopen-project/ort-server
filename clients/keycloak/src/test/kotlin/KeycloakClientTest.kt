/*
 * Copyright (C) 2022 The ORT Project Authors (See <https://github.com/oss-review-toolkit/ort-server/blob/main/NOTICE>)
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

package org.ossreviewtoolkit.server.clients.keycloak

import dasniko.testcontainers.keycloak.KeycloakContainer

import io.kotest.assertions.throwables.shouldThrow
import io.kotest.core.extensions.install
import io.kotest.core.spec.Spec
import io.kotest.core.spec.style.WordSpec
import io.kotest.extensions.testcontainers.TestContainerExtension
import io.kotest.extensions.testcontainers.perSpec
import io.kotest.matchers.collections.shouldContainExactlyInAnyOrder
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith

import io.ktor.http.HttpStatusCode

import kotlinx.serialization.json.Json

class KeycloakClientTest : WordSpec() {
    private val keycloak = install(
        TestContainerExtension(
            KeycloakContainer()
                .withRealmImportFile("test-realm.json")
        )
    )

    override suspend fun beforeSpec(spec: Spec) {
        // For performance reasons the test container must be started once per spec. Therefore, all tests that modify
        // data must not modify the predefined test data and clean up after themselves to ensure that tests are
        // isolated.
        listeners(keycloak.perSpec())
    }

    init {
        val client = keycloak.createTestClient()

        "create" should {
            "not throw any instantiation exception" {
                val incorrectConfig = keycloak.createConfig("falseSecret")

                val invalidClient = KeycloakClient.create(incorrectConfig, createJson())

                val exception = shouldThrow<KeycloakClientException> {
                    invalidClient.getRoles()
                }

                exception.message shouldStartWith "Failed to load roles"
            }
        }

        "getGroups" should {
            "return the correct realm groups" {
                val groups = client.getGroups()

                groups shouldContainExactlyInAnyOrder setOf(groupOrgA, groupOrgB, groupOrgC)
            }
        }

        "getGroup" should {
            "return the correct realm group" {
                val group = client.getGroup(groupOrgA.id)

                group shouldBe groupOrgA
            }

            "throw an exception if the group does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.getGroup("1")
                }
            }
        }

        "getGroupByName" should {
            "return the correct realm group" {
                client.getGroupByName(groupOrgA.name) shouldBe groupOrgA
                client.getGroupByName(subGroupOrgB1.name) shouldBe subGroupOrgB1
            }

            "throw an exception if the group does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.getGroupByName("1")
                }
            }
        }

        "createGroup" should {
            "successfully add a new realm group" {
                val response = client.createGroup("TEST_GROUP")
                val group = client.getGroupByName("TEST_GROUP")

                response.status shouldBe HttpStatusCode.Created
                group.name shouldBe "TEST_GROUP"

                client.deleteGroup(group.id)
            }

            "throw an exception if a group with the name already exists" {
                shouldThrow<KeycloakClientException> {
                    client.createGroup(groupOrgA.name)
                }
            }
        }

        "updateGroup" should {
            "successfully update the given realm group" {
                client.createGroup("TEST_GROUP")
                val group = client.getGroupByName("TEST_GROUP")
                val updatedGroup = group.copy(name = "UPDATED_TEST_GROUP")

                val response = client.updateGroup(group.id, updatedGroup.name)
                val updatedKeycloakGroup = client.getGroupByName("UPDATED_TEST_GROUP")

                response.status shouldBe HttpStatusCode.NoContent
                updatedKeycloakGroup shouldBe updatedGroup

                client.deleteGroup(updatedGroup.id)
            }

            "throw an exception if the group does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.updateGroup("1", "New-Organization")
                }
            }

            "throw an exception if a group with the name already exists" {
                shouldThrow<KeycloakClientException> {
                    client.updateGroup(groupOrgA.id, groupOrgB.name)
                }
            }
        }

        "deleteGroup" should {
            "successfully delete the given realm group" {
                client.createGroup("TEST_GROUP")
                val group = client.getGroupByName("TEST_GROUP")

                val response = client.deleteGroup(group.id)

                response.status shouldBe HttpStatusCode.NoContent

                shouldThrow<KeycloakClientException> {
                    client.getGroupByName("TEST_GROUP")
                }
            }

            "throw an exception if the group does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.deleteGroup("1")
                }
            }
        }

        "getRoles" should {
            "return the correct client roles" {
                val roles = client.getRoles()

                roles shouldContainExactlyInAnyOrder listOf(adminRole, visitorRole)
            }
        }

        "getRole by name" should {
            "return the correct client role" {
                val role = client.getRole(adminRole.name)

                role shouldBe adminRole
            }

            "throw an exception if the role does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.getRole("UNKNOWN_ROLE")
                }
            }
        }

        "createRole" should {
            "successfully add a new client role" {
                val response = client.createRole("TEST_ROLE", "DESCRIPTION")
                val role = client.getRole("TEST_ROLE")

                response.status shouldBe HttpStatusCode.Created
                with(role) {
                    name shouldBe "TEST_ROLE"
                    description shouldBe "DESCRIPTION"
                }

                client.deleteRole("TEST_ROLE")
            }

            "throw an exception if a role with the name already exists" {
                shouldThrow<KeycloakClientException> {
                    client.createRole("ADMIN")
                }
            }
        }

        "updateRole" should {
            "update only the name of the given client role" {
                client.createRole("TEST_ROLE", "DESCRIPTION")
                val role = client.getRole("TEST_ROLE")

                val updatedRole = role.copy(name = "UPDATED_ROLE")
                val response = client.updateRole(role.name, updatedRole.name, updatedRole.description)
                val updatedKeycloakRole = client.getRole(updatedRole.name)

                response.status shouldBe HttpStatusCode.NoContent
                updatedKeycloakRole shouldBe updatedRole

                client.deleteRole("UPDATED_ROLE")
            }

            "update only the description of the given client role" {
                client.createRole("TEST_ROLE", "DESCRIPTION")
                val role = client.getRole("TEST_ROLE")

                val updatedRole = role.copy(description = "UPDATED_DESCRIPTION")
                val response = client.updateRole(role.name, updatedRole.name, updatedRole.description)
                val updatedKeycloakRole = client.getRole(updatedRole.name)

                response.status shouldBe HttpStatusCode.NoContent
                updatedKeycloakRole shouldBe updatedRole

                client.deleteRole("TEST_ROLE")
            }

            "successfully update the given client role" {
                client.createRole("TEST_ROLE", "DESCRIPTION")
                val role = client.getRole("TEST_ROLE")

                val updatedRole = role.copy(name = "UPDATED_ROLE", description = "UPDATED_DESCRIPTION")
                val response = client.updateRole(role.name, updatedRole.name, updatedRole.description)
                val updatedKeycloakRole = client.getRole(updatedRole.name)

                response.status shouldBe HttpStatusCode.NoContent
                updatedKeycloakRole shouldBe updatedRole

                client.deleteRole("UPDATED_ROLE")
            }

            "throw an exception if a role cannot be updated" {
                shouldThrow<KeycloakClientException> {
                    client.updateRole("UNKNOWN_ROLE", "UPDATED_UNKNOWN_ROLE", null)
                }
            }
        }

        "deleteRole" should {
            "successfully delete the given client role" {
                client.createRole("TEST_ROLE", "DESCRIPTION")
                val role = client.getRole("TEST_ROLE")

                val response = client.deleteRole(role.name)

                response.status shouldBe HttpStatusCode.NoContent

                shouldThrow<KeycloakClientException> {
                    client.getRole("TEST_ROLE")
                }
            }

            "throw an exception if the role does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.deleteRole("UNKNOWN_ROLE")
                }
            }
        }

        "getUsers" should {
            "return the correct realm users" {
                val users = client.getUsers()

                users shouldContainExactlyInAnyOrder setOf(adminUser, ortAdminUser, visitorUser)
            }
        }

        "getUser" should {
            "return the correct realm user" {
                val user = client.getUser(adminUser.id)

                user shouldBe adminUser
            }

            "throw an exception if the user does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.getUser("1")
                }
            }
        }

        "getUserByName" should {
            "return the correct realm user" {
                client.getUserByName(adminUser.username) shouldBe adminUser
            }

            "throw an exception if the user does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.getUserByName("1")
                }
            }
        }

        "createUser" should {
            "successfully add a new realm user" {
                val response = client.createUser("test_user")
                val user = client.getUserByName("test_user")

                response.status shouldBe HttpStatusCode.Created

                user.username shouldBe "test_user"

                client.deleteUser(user.id)
            }

            "throw an exception if a user with the username already exists" {
                shouldThrow<KeycloakClientException> {
                    client.createUser(adminUser.username)
                }
            }
        }

        "updateUser" should {
            "update only the firstname of the user" {
                client.createUser("test_user", firstName = "firstName")
                val user = client.getUserByName("test_user")

                val updatedUser = user.copy(firstName = "updatedFirstName")
                val response = client.updateUser(id = user.id, firstName = updatedUser.firstName)
                val updatedKeycloakUser = client.getUser(user.id)

                response.status shouldBe HttpStatusCode.NoContent
                updatedKeycloakUser shouldBe updatedUser

                client.deleteUser(user.id)
            }

            "successfully update the given realm user" {
                client.createUser(
                    "test_user",
                    firstName = "firstName",
                    lastName = "lastName",
                    email = "email@example.com"
                )
                val user = client.getUserByName("test_user")

                val updatedUser = user.copy(
                    firstName = "updatedFirstName",
                    lastName = "updatedLastName",
                    email = "updated_email@example.com"
                )
                val response = client.updateUser(
                    user.id,
                    updatedUser.username,
                    updatedUser.firstName,
                    updatedUser.lastName,
                    updatedUser.email
                )

                val updatedKeycloakUser = client.getUser(user.id)

                response.status shouldBe HttpStatusCode.NoContent
                updatedKeycloakUser shouldBe updatedUser

                client.deleteUser(user.id)
            }

            "throw an exception if a user cannot be updated" {
                shouldThrow<KeycloakClientException> {
                    client.updateUser(visitorUser.id, email = adminUser.email)
                }
            }
        }

        "deleteUser" should {
            "successfully delete the given realm user" {
                client.createUser("test_user")
                val user = client.getUserByName("test_user")

                val response = client.deleteUser(user.id)

                response.status shouldBe HttpStatusCode.NoContent

                shouldThrow<KeycloakClientException> {
                    client.getUser(user.id)
                }
            }

            "throw an exception if the user does not exist" {
                shouldThrow<KeycloakClientException> {
                    client.deleteUser("1")
                }
            }
        }
    }
}

/**
 * Create a test client instance that is configured to access the Keycloak instance managed by this container.
 */
private fun KeycloakContainer.createTestClient(): KeycloakClient =
    KeycloakClient.create(createConfig(), createJson())

/**
 * Generate a configuration with test properties based on this container to be consumed by a test client instance.
 */
private fun KeycloakContainer.createConfig(secret: String = API_SECRET) =
    KeycloakClientConfiguration(
        apiUrl = "${authServerUrl}admin/realms/$REALM",
        clientId = CLIENT_ID,
        accessTokenUrl = "${authServerUrl}realms/$REALM/protocol/openid-connect/token",
        apiUser = API_USER,
        apiSecret = secret
    )

/**
 * Create the [Json] instance required by the test client.
 */
private fun createJson(): Json = Json {
    ignoreUnknownKeys = true
}
