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

package org.ossreviewtoolkit.server.workers.common.env

import io.kotest.core.spec.style.WordSpec
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain

import io.mockk.coEvery

import org.ossreviewtoolkit.server.workers.common.env.definition.NpmAuthMode
import org.ossreviewtoolkit.server.workers.common.env.definition.NpmDefinition

class NpmRcGeneratorTest : WordSpec({
    "environmentDefinitionType" should {
        "return the correct definition class" {
            val definitionType = NpmRcGenerator().environmentDefinitionType

            definitionType shouldBe NpmDefinition::class.java
        }
    }

    "generate" should {
        "generate the file at the correct location" {
            val definition = NpmDefinition(MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI))

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            mockBuilder.homeFileName shouldBe ".npmrc"
        }

        "generate a block for a registry with password authentication" {
            val usernameSecret = MockConfigFileBuilder.createSecret("registryUser")
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, usernameSecret, passwordSecret)
            )

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val expectedLines = listOf(
                "$REGISTRY_URI_FRAGMENT:username=${MockConfigFileBuilder.testSecretRef(usernameSecret)}",
                "$REGISTRY_URI_FRAGMENT:_password=${MockConfigFileBuilder.testSecretRef(passwordSecret)}",
                "$REGISTRY_URI_FRAGMENT:always-auth=true"
            )
            val lines = mockBuilder.generatedLines()
            lines shouldContainExactly expectedLines
        }

        "generate blocks for multiple registries" {
            val otherRegistryFragment = REGISTRY_URI_FRAGMENT + "other/"
            val usernameSecret = MockConfigFileBuilder.createSecret("registryUser")
            val passwordSecret1 = MockConfigFileBuilder.createSecret("registryPass")
            val passwordSecret2 = MockConfigFileBuilder.createSecret("otherRegistryPass")

            val definitions = listOf(
                NpmDefinition(
                    MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, usernameSecret, passwordSecret1)
                ),
                NpmDefinition(
                    MockConfigFileBuilder.createInfrastructureService(
                        "$REGISTRY_PROTOCOL$otherRegistryFragment",
                        usernameSecret,
                        passwordSecret2
                    )
                )
            )

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, definitions)

            val expectedLines = listOf(
                "$REGISTRY_URI_FRAGMENT:username=${MockConfigFileBuilder.testSecretRef(usernameSecret)}",
                "$REGISTRY_URI_FRAGMENT:_password=${MockConfigFileBuilder.testSecretRef(passwordSecret1)}",
                "$REGISTRY_URI_FRAGMENT:always-auth=true",
                "",
                "$otherRegistryFragment:username=${MockConfigFileBuilder.testSecretRef(usernameSecret)}",
                "$otherRegistryFragment:_password=${MockConfigFileBuilder.testSecretRef(passwordSecret2)}",
                "$otherRegistryFragment:always-auth=true"
            )
            val lines = mockBuilder.generatedLines()
            lines shouldContainExactly expectedLines
        }

        "generate a block for a registry with a base64 encoded password" {
            val usernameSecret = MockConfigFileBuilder.createSecret("registryUser")
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, usernameSecret, passwordSecret),
                authMode = NpmAuthMode.PASSWORD_BASE64
            )

            val password = "theRegistry'sSecretPwd"
            val passwordBase64 = "dGhlUmVnaXN0cnknc1NlY3JldFB3ZA=="
            val mockBuilder = MockConfigFileBuilder()
            coEvery {
                mockBuilder.contextMock.resolveSecret(passwordSecret)
            } returns password

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val generated = mockBuilder.generatedText()
            generated shouldContain "$REGISTRY_URI_FRAGMENT:_password=$passwordBase64"
        }

        "generate a block for a registry with PASSWORD_AUTH mode" {
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, passwordSecret = passwordSecret),
                authMode = NpmAuthMode.PASSWORD_AUTH
            )

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val expectedLines = listOf(
                "$REGISTRY_URI_FRAGMENT:_auth=${MockConfigFileBuilder.testSecretRef(passwordSecret)}",
                "$REGISTRY_URI_FRAGMENT:always-auth=true"
            )
            val lines = mockBuilder.generatedLines()
            lines shouldContainExactly expectedLines
        }

        "generate a block for a registry with PASSWORD_AUTH_TOKEN mode" {
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, passwordSecret = passwordSecret),
                authMode = NpmAuthMode.PASSWORD_AUTH_TOKEN
            )

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val expectedLines = listOf(
                "$REGISTRY_URI_FRAGMENT:_authToken=${MockConfigFileBuilder.testSecretRef(passwordSecret)}",
                "$REGISTRY_URI_FRAGMENT:always-auth=true"
            )
            val lines = mockBuilder.generatedLines()
            lines shouldContainExactly expectedLines
        }

        "generate a block for a registry with USERNAME_PASSWORD_AUTH mode" {
            val usernameSecret = MockConfigFileBuilder.createSecret("registryUser")
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, usernameSecret, passwordSecret),
                authMode = NpmAuthMode.USERNAME_PASSWORD_AUTH
            )

            val username = "scott"
            val password = "tiger"
            val authBase64 = "c2NvdHQ6dGlnZXI="
            val mockBuilder = MockConfigFileBuilder()
            coEvery {
                mockBuilder.contextMock.resolveSecrets(usernameSecret, passwordSecret)
            } returns mapOf(usernameSecret to username, passwordSecret to password)

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val expectedLines = listOf(
                "$REGISTRY_URI_FRAGMENT:_auth=$authBase64",
                "$REGISTRY_URI_FRAGMENT:always-auth=true"
            )
            val lines = mockBuilder.generatedLines()
            lines shouldContainExactly expectedLines
        }

        "skip the always-auth line if the flag is false" {
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, passwordSecret = passwordSecret),
                authMode = NpmAuthMode.PASSWORD_AUTH,
                alwaysAuth = false
            )

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val generated = mockBuilder.generatedText().trim()

            generated shouldBe "$REGISTRY_URI_FRAGMENT:_auth=${MockConfigFileBuilder.testSecretRef(passwordSecret)}"
        }

        "print the email if it is present" {
            val email = "scott@example.org"
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, passwordSecret = passwordSecret),
                authMode = NpmAuthMode.PASSWORD_AUTH,
                email = email
            )

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val expectedLines = listOf(
                "$REGISTRY_URI_FRAGMENT:_auth=${MockConfigFileBuilder.testSecretRef(passwordSecret)}",
                "$REGISTRY_URI_FRAGMENT:email=$email",
                "$REGISTRY_URI_FRAGMENT:always-auth=true"
            )
            val lines = mockBuilder.generatedLines()
            lines shouldContainExactly expectedLines
        }

        "print the scope for the registry if it is present" {
            val scope = "foo"
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(REGISTRY_URI, passwordSecret = passwordSecret),
                authMode = NpmAuthMode.PASSWORD_AUTH,
                scope = scope
            )

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val expectedLines = listOf(
                "@$scope:registry=$REGISTRY_URI",
                "$REGISTRY_URI_FRAGMENT:_auth=${MockConfigFileBuilder.testSecretRef(passwordSecret)}",
                "$REGISTRY_URI_FRAGMENT:always-auth=true"
            )
            val lines = mockBuilder.generatedLines()
            lines shouldContainExactly expectedLines
        }

        "add a trailing slash to the service URL if it is missing" {
            val scope = "foo"
            val passwordSecret = MockConfigFileBuilder.createSecret("registryPass")
            val definition = NpmDefinition(
                MockConfigFileBuilder.createInfrastructureService(
                    REGISTRY_URI.dropLast(1),
                    passwordSecret = passwordSecret
                ),
                authMode = NpmAuthMode.PASSWORD_AUTH,
                scope = scope
            )

            val mockBuilder = MockConfigFileBuilder()

            NpmRcGenerator().generate(mockBuilder.builder, listOf(definition))

            val expectedLines = listOf(
                "@$scope:registry=$REGISTRY_URI",
                "$REGISTRY_URI_FRAGMENT:_auth=${MockConfigFileBuilder.testSecretRef(passwordSecret)}",
                "$REGISTRY_URI_FRAGMENT:always-auth=true"
            )
            val lines = mockBuilder.generatedLines()
            lines shouldContainExactly expectedLines
        }
    }
})

private const val REGISTRY_PROTOCOL = "https:"
private const val REGISTRY_URI_FRAGMENT = "//registry.example.org/_packaging/test/npm/registry/"
private const val REGISTRY_URI = "$REGISTRY_PROTOCOL$REGISTRY_URI_FRAGMENT"
