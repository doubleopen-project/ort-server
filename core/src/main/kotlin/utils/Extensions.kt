/*
 * Copyright (C) 2022 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
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

package org.eclipse.apoapsis.ortserver.core.utils

import io.ktor.server.config.tryGetString

import org.eclipse.apoapsis.ortserver.clients.keycloak.KeycloakClientConfiguration
import org.eclipse.apoapsis.ortserver.config.ConfigManager
import org.eclipse.apoapsis.ortserver.config.Path

fun ConfigManager.createKeycloakClientConfiguration(): KeycloakClientConfiguration {
    val baseUrl = getString("keycloak.baseUrl")
    val realm = getString("keycloak.realm")

    val defaultApiUrl = "$baseUrl/admin/realms/$realm"
    val defaultAccessTokenUrl = "$baseUrl/realms/$realm/protocol/openid-connect/token"

    return KeycloakClientConfiguration(
        baseUrl = baseUrl,
        realm = realm,
        apiUrl = tryGetString("keycloak.apiUrl") ?: defaultApiUrl,
        clientId = getString("keycloak.clientId"),
        accessTokenUrl = tryGetString("keycloak.accessTokenUrl") ?: defaultAccessTokenUrl,
        apiUser = getString("keycloak.apiUser"),
        apiSecret = getSecret(Path("keycloak.apiSecret")),
        subjectClientId = getString("keycloak.subjectClientId")
    )
}
