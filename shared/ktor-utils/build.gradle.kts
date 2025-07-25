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

plugins {
    // Apply core plugins.
    `java-test-fixtures`

    // Apply precompiled plugins.
    id("ort-server-kotlin-jvm-conventions")
    id("ort-server-publication-conventions")
}

group = "org.eclipse.apoapsis.ortserver.shared"

dependencies {
    api(projects.shared.apiModel)

    api(ktorLibs.server.core)
    api(ktorLibs.server.requestValidation)
    api(libs.konform)
    api(libs.ktorOpenApi)

    implementation(projects.model)

    testImplementation(ktorLibs.server.testHost)
    testImplementation(libs.kotestAssertionsCore)
    testImplementation(libs.kotestAssertionsKtor)

    testFixturesApi(projects.components.authorization.backend)
    testFixturesApi(projects.services.authorizationService)
    testFixturesApi(projects.utils.test)
    testFixturesApi(testFixtures(projects.dao))

    testFixturesImplementation(testFixtures(projects.clients.keycloak))

    testFixturesImplementation(ktorLibs.client.contentNegotiation)
    testFixturesImplementation(ktorLibs.serialization.kotlinx.json)
    testFixturesImplementation(ktorLibs.server.auth)
    testFixturesImplementation(ktorLibs.server.auth.jwt)
    testFixturesImplementation(ktorLibs.server.contentNegotiation)
    testFixturesImplementation(ktorLibs.server.core)
    testFixturesImplementation(ktorLibs.server.statusPages)
    testFixturesImplementation(ktorLibs.server.testHost)
    testFixturesImplementation(libs.kotestAssertionsKtor)
    testFixturesImplementation(libs.kotestFrameworkApi)
    testFixturesImplementation(libs.kotlinxSerializationJson)
    testFixturesImplementation(libs.mockk)
}
