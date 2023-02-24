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

@Suppress("DSL_SCOPE_VIOLATION") // See https://youtrack.jetbrains.com/issue/KTIJ-19369.
plugins {
    application

    alias(libs.plugins.jib)
    alias(libs.plugins.kotlinJvm)
}

group = "org.ossreviewtoolkit.server.workers"
version = "0.0.1"

tasks.withType<Test>().configureEach {
    useJUnitPlatform()
}

dependencies {
    implementation(libs.logback)
}

jib {
    from.image = "eclipse-temurin:17"
    to.image = "ort-server-evaluator-worker:latest"

    container {
        mainClass = "org.ossreviewtoolkit.server.workers.evaluator.EntrypointKt"
        creationTime.set("USE_CURRENT_TIMESTAMP")
    }
}
