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

import org.ossreviewtoolkit.server.model.OrtRun
import org.ossreviewtoolkit.server.model.Repository

/**
 * This enum contains the available permissions for [repositories][Repository]. These permissions are used by the API to
 * control access to the [Repository] endpoints.
 */
enum class RepositoryPermission {
    /** Permission to read the [Repository] details. */
    READ,

    /** Permission to write the [Repository] details. */
    WRITE,

    /** Permission to write the [Repository] secrets. */
    WRITE_SECRETS,

    /** Permission to read the list of [OrtRun]s of the [Repository]. */
    READ_ORT_RUNS,

    /** Permission to trigger an [OrtRun] for the [Repository]. */
    TRIGGER_ORT_RUN,

    /** Permission to delete the [Repository]. */
    DELETE;

    companion object {
        /**
         * Get all [role names][roleName] for the provided [repositoryId].
         */
        fun getRolesForRepository(repositoryId: Long) =
            enumValues<RepositoryPermission>().map { it.roleName(repositoryId) }

        /**
         * A unique prefix for the roles for the provided [repositoryId].
         */
        fun rolePrefix(repositoryId: Long) = "permission_repository_${repositoryId}_"
    }

    /** A unique name for this permission to be used to represent the permission as a role in Keycloak. */
    fun roleName(repositoryId: Long): String = "${rolePrefix(repositoryId)}${name.lowercase()}"
}
