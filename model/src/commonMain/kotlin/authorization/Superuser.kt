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

package org.ossreviewtoolkit.server.model.authorization

/**
 * Constants related to the superuser role that grants all permissions.
 */
object Superuser {
    /**
     * The name of the superuser Keycloak role which grants all permissions.
     */
    const val ROLE_NAME = "superuser"

    /**
     * The name of the superuser Keycloak group which grants the [ROLE_NAME].
     */
    const val GROUP_NAME = "SUPERUSERS"
}
