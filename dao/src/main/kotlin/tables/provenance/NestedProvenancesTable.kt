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

package org.ossreviewtoolkit.server.dao.tables.provenance

import org.jetbrains.exposed.dao.LongEntity
import org.jetbrains.exposed.dao.LongEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.LongIdTable

import org.ossreviewtoolkit.server.dao.tables.runs.shared.VcsInfoDao
import org.ossreviewtoolkit.server.dao.tables.runs.shared.VcsInfoTable

/**
 * A table to store nested provenances.
 */
object NestedProvenancesTable : LongIdTable("nested_provenances") {
    val rootVcsId = reference("root_vcs_id", VcsInfoTable)

    val rootResolvedRevision = text("root_resolved_revision")
    val hasOnlyFixedRevisions = bool("has_only_fixed_revisions")
}

class NestedProvenanceDao(id: EntityID<Long>) : LongEntity(id) {
    companion object : LongEntityClass<NestedProvenanceDao>(NestedProvenancesTable)

    var rootVcs by VcsInfoDao referencedOn NestedProvenancesTable.rootVcsId

    var rootResolvedRevision by NestedProvenancesTable.rootResolvedRevision
    var hasOnlyFixedRevisions by NestedProvenancesTable.hasOnlyFixedRevisions

    val packageProvenances by PackageProvenanceDao optionalReferrersOn PackageProvenancesTable.nestedProvenanceId
    val subRepositories by NestedProvenanceSubRepositoryDao referrersOn
            NestedProvenanceSubRepositoriesTable.nestedProvenanceId
}
