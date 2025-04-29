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

import java.net.URLEncoder
import java.nio.charset.StandardCharsets

/**
 * Set of matchers to help keep policy rules easy to understand
 */

fun PackageRule.LicenseRule.isCategory(category: String) =
    object : RuleMatcher {
        override val description = "isCategory($license)"

        override fun matches() = license in licenseClassifications.licensesByCategory[category].orEmpty()
    }

fun PackageRule.LicenseRule.isHandled() =
    object : RuleMatcher {
        override val description = "isHandled($license)"

        override fun matches() = licenseClassifications.isCategorized(license)
    }

fun PackageRule.LicenseRule.isNoAssertion() =
    object : RuleMatcher {
        override val description = "isNoAssertion($license)"

        override fun matches() = license.toString().contains("NOASSERTION")
    }

val productDistributionLabels = ortResult.getLabelValues("distribution-type")

fun productIsPackaged() =
    object : RuleMatcher {
        override val description = "productIsPackaged()"

        // If no distribution label is set, assume the distribution model is packaged.
        override fun matches() = productDistributionLabels.isEmpty() || "packaged" in productDistributionLabels
    }

fun productIsOpenSourceDistributed() =
    object : RuleMatcher {
        override val description = "productIsOpenSourceDistributed()"

        override fun matches() = "open-source" in productDistributionLabels
    }

fun productIsSaas() =
    object : RuleMatcher {
        override val description = "productIsSaaS()"

        override fun matches() = "saas" in productDistributionLabels
    }

fun productIsInternal() =
    object : RuleMatcher {
        override val description = "productIsInternal()"

        override fun matches() = "internal" in productDistributionLabels
    }

/**
 * Function to modify the howToFixMessage: add the curation front-end URL, if DOS scanner used for scanning.
 */
fun addCurationUrl(howToFixMessage: String, pkg: CuratedPackage, license: String): String {
    val frontendUrl = ortResult.scanner?.config?.config?.get("DOS")?.options?.get("frontendUrl")?.removeSuffix("/")
            ?: return "$howToFixMessage\n\n**Error:** The DOS front-end URL is not available. Please check your ORT configuration."

    // Only support a single scanner (DOS) per package for now.
    val scanResults = ortResult.getScanResultsForId(pkg.metadata.id)
    val scanResult = scanResults.firstOrNull()
            ?: return "$howToFixMessage\n\n**Error:** The ORT result contains ${scanResults.size} scan results."

    val purl = pkg.metadata.id.toPurl(scanResult.provenance.toPurlExtras())

    // Note that the qualifier values of the PURL might already be percent-encoded, so this is actually doing
    // double-encoding of those.
    val encodedPurl = URLEncoder.encode(purl, StandardCharsets.UTF_8)

    val encodedLicense = URLEncoder.encode(license, StandardCharsets.UTF_8)
    val curationUrl = "$frontendUrl/$encodedPurl?licenseFilter=$encodedLicense"

    // Use the "clean" PURL without qualifiers / provenance information for user presentation to keep things short.
    val curationMessage = if (ortResult.isProject(pkg.metadata.id)) {
        """
            |
            |---
            |
            |**NOTE**: Curating projects is currently not supported via Double Open Server. Instead, put any project-specific curations into an `.ort.yml` file committed to the root of the project's repository.
            |
            |You can still inspect (but not curate) this package with [Double Open Server]($curationUrl).
        """.trimMargin()
    } else {
        """
            |
            |---
            |
            |Curate this package with [Double Open Server]($curationUrl).
        """.trimMargin()
    }

    return howToFixMessage + curationMessage
}

/**
 * Policy rules
 */

val ruleSet = ruleSet(ortResult, licenseInfoResolver) {
    packageRule("Packages") {
        require {
            -isExcluded()
        }

        /**
         * Create errors for all unhandled licenses.
         */
        licenseRule("Unhandled license", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                -isExcluded()
                -isHandled()
                -isNoAssertion()
            }

            val howToFixMessage = """
                |This is a finding for a license not yet covered by the license policy. Please contact
                |info@doubleopen.org.
            """.trimMargin()

            error(
                "Unhandled license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Create errors for all unchecked licenses.
         */
        licenseRule("Unchecked license", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("property:unchecked")
                -isExcluded()
            }

            val howToFixMessage = """
                |This license needs to be checked and classified. Please contact info@doubleopen.org.
            """.trimMargin()

            error(
                "Unchecked license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny strong copyleft licenses for all packages in distributed products and the project code in open source
         * distributed products.
         */
        licenseRule("Strong copyleft license", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("copyleft-strong")
                -isExcluded()
                +AnyOf(
                    productIsPackaged(),
                    AllOf(
                        productIsOpenSourceDistributed(),
                        isProject()
                    )
                )
            }

            val howToFixMessage = """
                |A copyleft license with a wide or harder-to-control scope of copyleft effect. The
                |license requires software interacting with the licensed software to some wide
                |extent to be licensed under the same copyleft license (copyleft effect). Further
                |fact-finding by the project will be necessary to determine the extent of the
                |copyleft effect in the present circumstances.
                |
                |- First check for false positives.
                |- If the issue is not a false positive, check whether it is an indirect dependency
                |  which was not automatically detected. If it is, create a resolution that clears
                |  the violation in ORT, using the resolution expression, “LICENSE_ACQUIRED” into
                |  your project’s .yml file, with comment: “indirect dependency, and thus compliant”.
                |- If the issue is not an indirect dependency, check whether the strong copyleft
                |  code is used without any linking, e.g. separate process or database, API or RPC
                |  interaction. If it is, create a resolution that clears the violation in ORT,
                |  using the resolution expression, “LICENSE_ACQUIRED” into the your project’s .yml
                |  file, with comment: “good architecture, and thus compliant”.
                |- If the issue is not solved with an architecture check, the alternatives are to
                |  (i) change the architecture to be good (see above), or (ii) contact the Open
                |  Source Officer. If this is not possible, the component needs to be switched out
                |  or another license or permission needs to be acquired.
                |
                |How to fix (by OSO):
                |
                |- If the issue is not solved with architecture check, (i) relicense under the
                |  copyleft license the code covered by the copyleft effect, (ii)  reanalyze dynamic
                |  linking options with legal/Double Open etc. If this is not possible, the component
                |  needs to be switched out or another license or permission needs to be acquired.
                |  - Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |    the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |    Fixed, will be fixed asap”.
                |  - If this requires a change to be made by a third party that is not responsive,
                |    consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |    project’s .yml file (if allowed as per project policy) with the comment “Not
                |    Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "copyleft-strong license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny file-level copyleft licenses in project code for distributed products and open source distributed
         * products.
         */
        licenseRule("Copyleft (file-level) in project code", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("copyleft-file-level")
                -isExcluded()
                +isProject()
                +AnyOf(
                    productIsPackaged(),
                    productIsOpenSourceDistributed()
                )
            }

            val howToFixMessage = """
                |If the file has a file level copyleft license, such as Mozilla Public License
                |(MPL-2.0) and an own copyright notice, check for false positives with the file
                |level copyleft license.
                |
                |- First check for false positives.
                |- If the issue is not a false positive, check whether it is an indirect dependency
                |  which was not automatically detected. If it is, create a resolution that clears
                |  the violation in ORT, using the resolution expression, “LICENSE_ACQUIRED” into
                |  the your project’s .yml file, with comment: “indirect dependency, and thus
                |  compliant”.
                |- Investigate if the copyleft code is in the same file as your own proprietary
                |  code. If it is not, the use case is acceptable as such. If it is in the same
                |  file, alternatives are to (i) change the interaction so that the own proprietary
                |  code no longer ends up in the same file, or (ii) contact open source officer for
                |  other alternatives
                |- If this is not possible, the component needs to be switched out or another
                |  license needs to be acquired.
                |
                |How to fix (by OSO):
                |
                |- If the issue is not solved with architecture check, relicense under the copyleft
                |  license the code covered by the copyleft effect.
                |  - Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |    the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment
                |    “Not Fixed, will be fixed asap”.
                |  - If this requires a change to be made by a third party that is not responsive,
                |    consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |    project’s .yml file (if allowed as per project policy) with the comment “Not
                |    Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "copyleft-file-level license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny LGPL-style copyleft licenses in project code for distributed products and open source distributed
         * products.
         */
        licenseRule("Copyleft (LGPL-style) in project code", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("copyleft-LGPL")
                -isExcluded()
                +isProject()
                +AnyOf(
                    productIsPackaged(),
                    productIsOpenSourceDistributed()
                )
            }

            val howToFixMessage = """
                |A LGPL copyleft license requires code statically linking the same copyleft code,
                |or being part of the same resulting binary, to follow the LGPL terms.
                |
                |- First check for false positives.
                |- If the issue is not a false positive, check whether it is a dependency which was
                |  not automatically detected. If it is, create a resolution that clears the
                |  violation in ORT, using the resolution expression, “LICENSE_ACQUIRED” into your
                |  project’s .yml file, with comment: “dependency, and thus compliant”.
                |- Check if your own proprietary code is part of the same binary as LGPL code. If it
                |  is not, then the use is acceptable as such. If it is, alternatives are (i) change
                |  the interaction so that the own proprietary code no longer ends up in the same
                |  binary or (ii) contact open source officer for other alternatives.
                |- If this is not possible, the component needs to be switched out or another
                |  license needs to be acquired.
                |
                |How to fix (by OSO):
                |
                |- If the issue is not solved with architecture check, (i) relicense under the
                |  copyleft license the code covered by the copyleft effect, (ii) create for users
                |  an opportunity to modify the LGPL licensed code and relink statically with the
                |  proprietary code. If this is not possible, the component needs to be switched out
                |  or another license or permission needs to be acquired.
                |  - Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |    the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment
                |    “Not Fixed, will be fixed asap”.
                |  - If this requires a change to be made by a third party that is not responsive,
                |    consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |    project’s .yml file (if allowed as per project policy) with the comment “Not
                |    Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "copyleft-LGPL license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny module-level copyleft licenses in project code for distributed products and open source distributed
         * products.
         */
        licenseRule("Copyleft (module level) in project code", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("copyleft-module-level")
                -isExcluded()
                +isProject()
                +AnyOf(
                    productIsPackaged(),
                    productIsOpenSourceDistributed()
                )
            }

            val howToFixMessage = """
                |A module level copyleft license requires code in the same module to be licensed
                |under the same copyleft terms, for example Eclipse Public License (EPL-1.0).

                |- First check for false positives.
                |- If the issue is not a false positive, check whether it is a direct dependency
                |  which was not automatically detected. If it is, create a resolution that clears
                |  the violation in ORT, using the resolution expression, “LICENSE_ACQUIRED” into
                |  your project’s .yml file, with comment: “indirect dependency, and thus compliant”.
                |- Investigate if the copyleft code is in the same module as your own proprietary
                |  code. If it is not, the use case is acceptable as such. If it is in the same
                |  module, alternatives are to (i) change the interaction so that the own
                |  proprietary code no longer ends up in the same module or (ii) contact open source
                |  officer for other alternatives.
                |- If this is not possible, the component needs to be switched out or another
                |  license needs to be acquired.
                |
                |How to fix (by OSO):
                |
                |- If the issue is not solved with architecture check, relicense under the copyleft
                |  license the code covered by the copyleft effect.
                |  - Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |    the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |    Fixed, will be fixed asap”.
                |  - If this requires a change to be made by a third party that is not responsive,
                |    consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |    project’s .yml file (if allowed as per project policy) with the comment “Not
                |    Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "copyleft-module-level license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny proprietary free licenses for all packages.
         */
        licenseRule("Proprietary free license", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("proprietary-free")
                -isExcluded()
            }

            val howToFixMessage = """
                |The license may not require a commercial/payable license but may have specific
                |terms and conditions which the project is obligated to follow. Investigate whether
                |those  terms and conditions are compatible with the objectives and practices of the
                |project.
                |
                |- Check for false positives
                |- If it is not a false positive,
                |- If found not acceptable, you should switch the component
                |- Another option is to discuss with OSO to understand better the licensing and options
                |- If the license is found to be acceptable, add a resolution to ORT into the your
                |  project’s .yml file “LICENSE_ACQUIRED” with  comment regarding the justification
                |  “license complied with” or similar.
                |
                |How to fix (by OSO):
                |
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”, or another justification.
                |- If this requires a change to be made by a third party that is not responsive,
                |  consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |  project’s .yml file (if allowed as per project policy) with the comment “Not
                |  Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "proprietary-free license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny free-restricted licenses for all packages.
         */
        licenseRule("Free-restricted license", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("free-restricted")
                -isExcluded()
            }

            val howToFixMessage = """
                |The license contains restrictions regarding the usage of the software making it not
                |open source in a strict sense.
                |
                |- First check for false positives.
                |- Investigate whether those restrictions are compatible with the objectives and
                |  practices of the project.
                |  - If the license is found to be acceptable, add a resolution to ORT using the
                |    resolution expression, “LICENSE_ACQUIRED” into the your project’s .yml file,
                |    with comment: “free restricted license complied with” or another justification
                |    for the resolution.
                |- If not possible, then the component needs to be switched out or another license
                |  needs to be acquired.
                |- If no options remain, contact the open source officer for additional steps, if any.
                |
                |How to fix (by OSO):
                |
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”, or another justification.
                |- If this requires a change to be made by a third party that is not responsive,
                |  consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |  project’s .yml file (if allowed as per project policy) with the comment “Not
                |  Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "free-restricted license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny commercial licenses for all packages.
         */
        licenseRule("Commercial license", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("commercial")
                -isExcluded()
            }

            val howToFixMessage = """
                |This may be third-party proprietary software offered under a direct commercial
                |license between supplier and customer. Further fact-finding by the project will be
                |necessary to determine the code's license status and function, if any.
                |
                |- First check whether the finding is a false positive.
                |- If it is not a false positive, check whether you already have the license.
                |- If it is an unknown commercial license, and you wish to investigate it more,
                |  please ask OSO/Double Open to check the license.
                |- Consider if you should acquire a license:
                |  - If a license is acquired, create an ORT resolution to the project's .yml file
                |    with the reason “LICENSE_ACQUIRED”  followed by a comment, if any.
                |- If the issue remains after further investigation, the component needs to be
                |  switched out.
                |- If no options remain, contact the open source officer for additional steps, if any.
                |
                |How to fix (by OSO):
                |
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”, or another justification.
                |- If this requires a change to be made by a third party that is not responsive,
                |  consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |  project’s .yml file (if allowed as per project policy) with the comment “Not
                |  Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "commercial license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny source-available licenses for all packages.
         */
        licenseRule("Source-available license", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("source-available")
                -isExcluded()
            }

            val howToFixMessage = """
                |This is typically proprietary software (or not open source) which may be released
                |through a source code distribution model that includes arrangements where the
                |source can be viewed, and in some cases modified, but without necessarily meeting
                |the criteria to be called open-source.
                |
                |- First check whether the finding is a false positive.
                |- If the issue is not a false positive, investigate whether the licensing model is
                |  compatible with the objectives and practices of the project.
                |  - If the license is found to be acceptable, add a resolution to ORT into the your
                |    project’s .yml file “LICENSE_ACQUIRED” with  comment regarding the
                |    justification “license complied with” or similar.
                |- If it's not compatible, the component needs to be switched out or another license
                |  needs to be acquired.
                |- If no options remain, contact the open source officer for additional steps, if any.
                |
                |How to fix (by OSO):
                |
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”.
                |- If this requires a change to be made by a third party that is not responsive,
                |  consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |  project’s .yml file (if allowed as per project policy) with the comment “Not
                |  Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "source-available license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny unstated licenses for all packages.
         */
        licenseRule("Unstated license", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("unstated")
                -isExcluded()
            }

            val howToFixMessage = """
                |Third-party software that has a copyright notice, but no stated license. The
                |absence of a license poses a risk that the copyright owner may assert license
                |obligations at some future time.
                |
                |- Check for false positives
                |- If the license cannot be determined by further research, the project may need to
                |  contact the copyright owner to determine the license obligations, if any. You can
                |  contact your OSO / Double Open/ Validos for checking this.
                |- If a license is found/established elsewhere, and it is generally applicable, add
                |  a license finding curation to ORT. In this case a license curation entered into a
                |  package configuration file is often the correct way to handle false positives:
                |  enter the correct license for the finding or NONE if no license is actually
                |  indicated. If necessary ask OSO or Double Open for help.
                |- If not found, then the component needs to be switched out or a license needs to
                |  be acquired.
                |- If no options remain, contact the open source officer for additional steps, if any.
                |
                |How to fix (by OSO):
                |
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”.
                |- If this requires a change to be made by a third party that is not responsive,
                |  consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |  project’s .yml file (if allowed as per project policy) with the comment “Not
                |  Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "unstated license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny network-clause for all packages but internal products.
         */
        licenseRule("Network clause", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("property:network-clause")
                -productIsInternal()
                -isExcluded()
            }

            val howToFixMessage = """
                |- Check if this is a false positive. If it is a false positive, correct the license
                |  finding.
                |  - A license curation entered into a package configuration file is often the correct
                |    way to handle false positives: enter the correct license for the finding or NONE
                |    if no license is actually indicated. You can use the orth CLI utility to generate
                |    the package config file. Depending on the case, creating a path exclusion in
                |    package config (e.g. for irrelevant test files) or a resolution into
                |    resolution.yml (e.g. for an irrelevant scanner issue) may be the correct solution.
                |- If the issue is not a false positive, investigate whether the aforementioned
                |  terms can be met by the project, considering also downstream users. If the terms
                |  are not compatible with the objectives and practices of the project, the
                |  component needs to be switched out or another license needs to be acquired.
                |- If you cannot resolve this, contact the OSO.
                |
                |How to fix (by OSO):
                |
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "property:network-clause license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny advertising clause for all but internal products.
         */
        licenseRule("Advertising clause", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("property:advertising-clause")
                -isExcluded()
                -productIsInternal()
            }

            val howToFixMessage = """
                |This may be a license that requires a notice in certain advertisements for the
                |product (typically those mentioning features of the licensed software) that the
                |licensed software is being used.
                |
                |- First check whether the finding is a false positive.
                |  - A license curation entered into a package configuration file is often the
                |    correct way to handle false positives: enter the correct license for the
                |    finding or NONE if no license is actually indicated. You can use the orth CLI
                |    utility to generate the package config file. Depending on the case, creating a
                |    path exclusion in package config (e.g. for irrelevant test files) or a
                |    resolution into resolution.yml (e.g. for an irrelevant scanner issue) may be
                |    the correct solution.
                |- If the issue is not a false positive, discuss with the product lead that the
                |  relevant feature may not be presented in marketing materials. If this is not
                |  possible, connect with OSO for complying with the advertising clause. If the
                |  obligation is not compatible with the objectives and practices of the project,
                |  the component needs to be switched out or another license needs to be acquired.
                |- If you meet the obligation is met - either by not mentioning the feature or,
                |  after discussing with the OSO, using the advertisement -, create  a resolution
                |  with the reason LICENSE_ACQUIRED.
                |- If no options remain, contact the open source officer for additional steps, if
                | any.
                |
                |How to fix (by OSO):
                |
                |- If you have many advertising clauses in your project, consider creating a rule
                |  applicable to your project.
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”.
                |- If this requires a change to be made by a third party that is not responsive,
                |  consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |  project’s .yml file (if allowed as per project policy) with the comment “Not
                |  Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "property:advertising-clause license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        licenseRule("Non-commercial", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("property:non-commercial")
                -isExcluded()
            }

            val howToFixMessage = """
                |- If the license hit is found to be a false positive, add a license finding curation
                |to ORT.
                |  - A license curation entered into a package configuration file is often the
                |    correct way to handle false positives: enter the correct license for the
                |    finding or NONE if no license is actually indicated. You can use the orth CLI
                |    utility to generate the package config file. Depending on the case, creating a
                |    path exclusion in package config (e.g. for irrelevant test files) or a
                |    resolution into resolution.yml (e.g. for an irrelevant scanner issue) may be
                |    the correct solution.
                |- If another license can be acquired that may be another option.
                |  - If a license is acquired, create a resolution to ORT with the reason
                |    LICENSE_ACQUIRED.
                |- If the license hit is correct, and no license can be acquired, this file cannot
                |  be used, and should therefore be removed.
                |- If you cannot resolve this, contact the open source officer.
                |
                |How to fix (by OSO):
                |
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”, or another justification.
                |- If this requires a change to be made by a third party that is not responsive,
                |  consider creating a resolution with the reason CANT_FIX_ISSUE (if allowed as per
                |  project policy).
            """.trimMargin()

            error(
                "property:non-commercial license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        licenseRule("Nuclear restriction", LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED) {
            require {
                +isCategory("property:nuclear-restriction")
                -isExcluded()
            }

            val howToFixMessage = """
                |This license denies usage in the stated field of activity.
                |
                |- First check whether the finding is a false positive.
                |- If the issue is not a false positive, the files should be removed.
                |- If you cannot resolve this, contact the open source officer.
                |
                |How to fix (by OSO):
                |
                |- Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |  the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |  Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "property:nuclear-restriction license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }
    }

    /**
     * Rules that require information about the dependency relation.
     */
    dependencyRule("Dependencies") {
        require {
            -isExcluded()
        }

        /**
         * Deny LGPL-style copyleft licenses in statically linked dependencies for distributed products and open source
         * distributed products.
         */
        licenseRule(
            "Copyleft (LGPL-style) in statically linked dependency",
            LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED
        ) {
            require {
                +isCategory("copyleft-LGPL")
                -isExcluded()
                +isStaticallyLinked()
                +AnyOf(
                    productIsPackaged(),
                    productIsOpenSourceDistributed()
                )
            }

            val howToFixMessage = """
                |A LGPL copyleft license requires code statically linking the same copyleft code,
                |or being part of the same resulting binary, to follow the LGPL terms.
                |
                |- First check for false positives.
                |- If the issue is not a false positive, check whether it is a dependency which was
                |  not automatically detected. If it is, create a resolution that clears the
                |  violation in ORT, using the resolution expression, “LICENSE_ACQUIRED” into your
                |  project’s .yml file, with comment: “dependency, and thus compliant”.
                |- Check if your own proprietary code is part of the same binary as LGPL code. If it
                |  is not, then the use is acceptable as such. If it is, alternatives are (i) change
                |  the interaction so that the own proprietary code no longer ends up in the same
                |  binary or (ii) contact open source officer for other alternatives.
                |- If this is not possible, the component needs to be switched out or another
                |  license needs to be acquired.
                |
                |How to fix (by OSO):
                |
                |- If the issue is not solved with architecture check, (i) relicense under the
                |  copyleft license the code covered by the copyleft effect, (ii) create for users
                |  an opportunity to modify the LGPL licensed code and relink statically with the
                |  proprietary code. If this is not possible, the component needs to be switched out
                |  or another license or permission needs to be acquired.
                |  - Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |    the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment
                |    “Not Fixed, will be fixed asap”.
                |  - If this requires a change to be made by a third party that is not responsive,
                |    consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |    project’s .yml file (if allowed as per project policy) with the comment “Not
                |    Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "copyleft-LGPL license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }

        /**
         * Deny strong copyleft licenses in direct dependencies for distributed products and open source distributed
         * products.
         */
        licenseRule(
            "Strong copyleft license in direct dependency",
            LicenseView.CONCLUDED_OR_DECLARED_AND_DETECTED
        ) {
            require {
                +isCategory("copyleft-strong")
                -isExcluded()
                +isAtTreeLevel(0)
                +AnyOf(
                    productIsPackaged(),
                    productIsOpenSourceDistributed()
                )
            }

            val howToFixMessage = """
                |A copyleft license with a wide or harder-to-control scope of copyleft effect. The
                |license requires software interacting with the licensed software to some wide
                |extent to be licensed under the same copyleft license (copyleft effect). Further
                |fact-finding by the project will be necessary to determine the extent of the
                |copyleft effect in the present circumstances.
                |
                |- First check for false positives.
                |- If the issue is not a false positive, check whether it is an indirect dependency
                |  which was not automatically detected. If it is, create a resolution that clears
                |  the violation in ORT, using the resolution expression, “LICENSE_ACQUIRED” into
                |  your project’s .yml file, with comment: “indirect dependency, and thus compliant”.
                |- If the issue is not an indirect dependency, check whether the strong copyleft
                |  code is used without any linking, e.g. separate process or database, API or RPC
                |  interaction. If it is, create a resolution that clears the violation in ORT,
                |  using the resolution expression, “LICENSE_ACQUIRED” into the your project’s .yml
                |  file, with comment: “good architecture, and thus compliant”.
                |- If the issue is not solved with an architecture check, the alternatives are to
                |  (i) change the architecture to be good (see above), or (ii) contact the Open
                |  Source Officer. If this is not possible, the component needs to be switched out
                |  or another license or permission needs to be acquired.
                |
                |How to fix (by OSO):
                |
                |- If the issue is not solved with architecture check, (i) relicense under the
                |  copyleft license the code covered by the copyleft effect, (ii)  reanalyze dynamic
                |  linking options with legal/Double Open etc. If this is not possible, the component
                |  needs to be switched out or another license or permission needs to be acquired.
                |  - Any deviations, if approved, need to be recorded to ORT, with a resolution with
                |    the reason “CANT_FIX_ISSUE” into your project’s .ort.yml file with comment “Not
                |    Fixed, will be fixed asap”.
                |  - If this requires a change to be made by a third party that is not responsive,
                |    consider creating a resolution with the reason CANT_FIX_ISSUE into your
                |    project’s .yml file (if allowed as per project policy) with the comment “Not
                |    Fixed, will be fixed asap”.
            """.trimMargin()

            error(
                "copyleft-strong license $license in ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, license.toString())
            )
        }
    }

    packageRule("Unmapped declared licenses") {
        require {
            -isExcluded()
        }

        val howToFixMessage = """
            |Investigate what the correct license for the package is and add a curation for the package's unmapped
            |license to curations.yml.
            |
            |Example:
            |
            |```yaml
            |- id: "Maven:antlr:antlr"
            |curations:
            |   comment: "The package has an unmappable declared license entry."
            |   declared_license_mapping:
            |   "BSD License": "BSD-3-Clause"
            |```
        """.trimMargin()

        resolvedLicenseInfo.licenseInfo.declaredLicenseInfo.processed.unmapped.forEach { unmappedLicense ->
            warning(
                "The declared license '$unmappedLicense' could not be mapped to a valid license or parsed as an SPDX " +
                    "expression. The license was found in package ${pkg.metadata.id.toCoordinates()}.",
                addCurationUrl(howToFixMessage, pkg, unmappedLicense)
            )
        }
    }
}

// Populate the list of policy rule violations to return.
ruleViolations += ruleSet.violations
