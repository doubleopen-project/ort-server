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

package org.eclipse.apoapsis.ortserver.workers.analyzer

import org.eclipse.apoapsis.ortserver.model.runs.Identifier
import org.eclipse.apoapsis.ortserver.model.runs.ShortestDependencyPath
import org.eclipse.apoapsis.ortserver.workers.common.mapToModel

import org.ossreviewtoolkit.model.Identifier as OrtIdentifier
import org.ossreviewtoolkit.model.Project as OrtProject

/**
 * Helper function to get the shortest of the shortest paths for a package identifier, along with the scope, and the
 * project for this particular path.
 */
fun getIdentifierToShortestPathMap(
    projectsToShortestPathsByScope: Map<OrtProject, Map<String, Map<OrtIdentifier, List<OrtIdentifier>>>>
): Map<Identifier, ShortestDependencyPath> {
    val map = mutableMapOf<Identifier, ShortestDependencyPath>()

    projectsToShortestPathsByScope.forEach { projectToShortestPathsByScope ->
        val project = projectToShortestPathsByScope.key
        val shortestPathsByScope = projectToShortestPathsByScope.value

        shortestPathsByScope.entries.forEach { scopeToShortestPath ->
            val scope = scopeToShortestPath.key
            val identifiersToPaths = scopeToShortestPath.value

            identifiersToPaths.entries.forEach { identifierToPath ->
                val identifier = identifierToPath.key.mapToModel()
                val path = identifierToPath.value
                val existingEntry = map[identifier]

                if (existingEntry == null || existingEntry.path.size > path.size) {
                    map[identifier] = ShortestDependencyPath(project.mapToModel(), scope, path.map { it.mapToModel() })
                }
            }
        }
    }

    return map
}
