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

import { z } from 'zod';

import { AnalyzerJobConfiguration, CreateOrtRun, OrtRun } from '@/api/requests';

//import { packageManagers } from './-types';

const keyValueSchema = z.object({
  key: z.string().min(1),
  value: z.string(), // Allow empty values for now
});

const packageManagerOptionsSchema = z.object({
  enabled: z.boolean(),
  options: z.array(keyValueSchema).optional(),
});

export const createRunFormSchema = z.object({
  revision: z.string(),
  path: z.string(),
  jobConfigs: z.object({
    analyzer: z.object({
      enabled: z.boolean(),
      repositoryConfigPath: z.string().optional(),
      allowDynamicVersions: z.boolean(),
      skipExcluded: z.boolean(),
      packageManagers: z.object({
        Bazel: packageManagerOptionsSchema,
        Bundler: packageManagerOptionsSchema,
        Cargo: packageManagerOptionsSchema,
        Composer: packageManagerOptionsSchema,
        GoMod: packageManagerOptionsSchema,
        GradleInspector: packageManagerOptionsSchema,
        Maven: packageManagerOptionsSchema,
        NPM: packageManagerOptionsSchema,
        NuGet: packageManagerOptionsSchema,
        PIP: packageManagerOptionsSchema,
        Pipenv: packageManagerOptionsSchema,
        PNPM: packageManagerOptionsSchema,
        Poetry: packageManagerOptionsSchema,
        Yarn: packageManagerOptionsSchema,
        Yarn2: packageManagerOptionsSchema,
      }),
    }),
    advisor: z.object({
      enabled: z.boolean(),
      skipExcluded: z.boolean(),
      advisors: z.array(z.string()),
    }),
    scanner: z.object({
      enabled: z.boolean(),
      skipConcluded: z.boolean(),
      skipExcluded: z.boolean(),
    }),
    evaluator: z.object({
      enabled: z.boolean(),
      ruleSet: z.string().optional(),
      licenseClassificationsFile: z.string().optional(),
      copyrightGarbageFile: z.string().optional(),
      resolutionsFile: z.string().optional(),
    }),
    reporter: z.object({
      enabled: z.boolean(),
      formats: z.array(z.string()),
    }),
    notifier: z.object({
      enabled: z.boolean(),
      notifierRules: z.string().optional(),
      resolutionsFile: z.string().optional(),
      mail: z.object({
        recipientAddresses: z.array(z.object({ email: z.string() })).optional(),
        mailServerConfiguration: z.object({
          hostName: z.string(),
          port: z.coerce.number().int(),
          username: z.string(),
          password: z.string(),
          useSsl: z.boolean(),
          fromAddress: z.string(),
        }),
      }),
      jira: z.object({
        jiraRestClientConfiguration: z.object({
          serverUrl: z.string(),
          username: z.string(),
          password: z.string(),
        }),
      }),
    }),
    parameters: z.array(keyValueSchema).optional(),
  }),
  labels: z.array(keyValueSchema).optional(),
  jobConfigContext: z.string().optional(),
});

export type CreateRunFormValues = z.infer<typeof createRunFormSchema>;

/**
 * Converts an object map coming from the back-end to an array of key-value pairs.
 * This is useful for form handling where an array of objects is required.
 *
 * @param objectMap - The object map from the back-end.
 * @returns An array of key-value pairs.
 */
const convertMapToArray = (objectMap: {
  [key: string]: string;
}): { key: string; value: string }[] => {
  return Object.entries(objectMap).map(([key, value]) => ({
    key,
    value,
  }));
};

/**
 * Converts an array of key-value pairs to an object map.
 * This is useful for converting form data back to the format expected by the back-end.
 *
 * @param keyValueArray - An array of key-value pairs.
 * @returns The object map.
 */
const convertArrayToMap = (
  keyValueArray: { key: string; value: string }[]
): { [key: string]: string } => {
  return keyValueArray.reduce(
    (acc, { key, value }) => {
      acc[key] = value;
      return acc;
    },
    {} as { [key: string]: string }
  );
};

/**
 * Get the default values for the create run form. The form can be provided with a previously run
 * ORT run, in which case the values from it are used as defaults. Otherwise uses base defaults.
 */
export function defaultValues(
  ortRun: OrtRun | null
): z.infer<typeof createRunFormSchema> {
  // Default values for the form: edit only these, not the defaultValues object.
  const baseDefaults = {
    revision: 'main',
    path: '',
    jobConfigs: {
      analyzer: {
        enabled: true,
        repositoryConfigPath: '',
        allowDynamicVersions: true,
        skipExcluded: true,
        packageManagers: {
          Bazel: { enabled: true, options: [{ key: '', value: '' }] },
          Bundler: { enabled: true, options: [{ key: '', value: '' }] },
          Cargo: { enabled: true, options: [{ key: '', value: '' }] },
          Composer: { enabled: true, options: [{ key: '', value: '' }] },
          GoMod: { enabled: true, options: [{ key: '', value: '' }] },
          GradleInspector: { enabled: true, options: [{ key: '', value: '' }] },
          Maven: { enabled: true, options: [{ key: '', value: '' }] },
          NPM: { enabled: true, options: [{ key: '', value: '' }] },
          NuGet: { enabled: true, options: [{ key: '', value: '' }] },
          PIP: { enabled: true, options: [{ key: '', value: '' }] },
          Pipenv: { enabled: true, options: [{ key: '', value: '' }] },
          PNPM: { enabled: true, options: [{ key: '', value: '' }] },
          Poetry: { enabled: true, options: [{ key: '', value: '' }] },
          Yarn: { enabled: true, options: [{ key: '', value: '' }] },
          Yarn2: { enabled: true, options: [{ key: '', value: '' }] },
        },
      },
      advisor: {
        enabled: true,
        skipExcluded: true,
        advisors: ['OSV', 'VulnerableCode'],
      },
      scanner: {
        enabled: true,
        skipConcluded: true,
        skipExcluded: true,
      },
      evaluator: {
        enabled: true,
        ruleSet: '',
        licenseClassificationsFile: '',
        copyrightGarbageFile: '',
        resolutionsFile: '',
      },
      reporter: {
        enabled: true,
        formats: ['CycloneDx', 'SpdxDocument', 'WebApp'],
      },
      notifier: {
        enabled: false,
        notifierRules: '',
        resolutionsFile: '',
        mail: {
          recipientAddresses: [],
          mailServerConfiguration: {
            hostName: 'localhost',
            port: 587,
            username: '',
            password: '',
            useSsl: true,
            fromAddress: '',
          },
        },
        jira: {
          jiraRestClientConfiguration: {
            serverUrl: '',
            username: '',
            password: '',
          },
        },
      },
    },
    jobConfigContext: '',
  };

  // Default values for the form are either taken from "baseDefaults" or,
  // when a rerun action has been taken, fetched from the ORT Run that is
  // being rerun. Whenever a rerun job config parameter is missing, use the
  // default value.
  const defaultValues = ortRun
    ? {
        revision: ortRun.revision || baseDefaults.revision,
        path: ortRun.path || baseDefaults.path,
        jobConfigs: {
          analyzer: {
            enabled: baseDefaults.jobConfigs.analyzer.enabled,
            repositoryConfigPath:
              ortRun.jobConfigs.analyzer?.repositoryConfigPath ||
              baseDefaults.jobConfigs.analyzer.repositoryConfigPath,
            allowDynamicVersions:
              ortRun.jobConfigs.analyzer?.allowDynamicVersions ||
              baseDefaults.jobConfigs.analyzer.allowDynamicVersions,
            skipExcluded:
              ortRun.jobConfigs.analyzer?.skipExcluded ||
              baseDefaults.jobConfigs.analyzer.skipExcluded,
            packageManagers: {
              Bazel: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Bazel'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Bazel
                    ?.options || {}
                ),
              },
              Bundler: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Bundler'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Bundler
                    ?.options || {}
                ),
              },
              Cargo: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Cargo'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Cargo
                    ?.options || {}
                ),
              },
              Composer: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Composer'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Composer
                    ?.options || {}
                ),
              },
              GoMod: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'GoMod'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.GoMod
                    ?.options || {}
                ),
              },
              GradleInspector: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'GradleInspector'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions
                    ?.GradleInspector?.options || {}
                ),
              },
              Maven: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Maven'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Maven
                    ?.options || {}
                ),
              },
              NPM: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'NPM'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.NPM
                    ?.options || {}
                ),
              },
              NuGet: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'NuGet'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.NuGet
                    ?.options || {}
                ),
              },
              PIP: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'PIP'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.PIP
                    ?.options || {}
                ),
              },
              Pipenv: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Pipenv'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Pipenv
                    ?.options || {}
                ),
              },
              PNPM: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'PNPM'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.PNPM
                    ?.options || {}
                ),
              },
              Poetry: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Poetry'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Poetry
                    ?.options || {}
                ),
              },
              Yarn: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Yarn'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Yarn
                    ?.options || {}
                ),
              },
              Yarn2: {
                enabled:
                  ortRun.jobConfigs.analyzer?.enabledPackageManagers?.includes(
                    'Yarn2'
                  ) || true,
                options: convertMapToArray(
                  ortRun.jobConfigs.analyzer?.packageManagerOptions?.Yarn2
                    ?.options || {}
                ),
              },
            },
          },
          advisor: {
            enabled:
              ortRun.jobConfigs.advisor !== undefined &&
              ortRun.jobConfigs.advisor !== null,
            skipExcluded:
              ortRun.jobConfigs.advisor?.skipExcluded ||
              baseDefaults.jobConfigs.advisor.skipExcluded,
            advisors:
              ortRun.jobConfigs.advisor?.advisors ||
              baseDefaults.jobConfigs.advisor.advisors,
          },
          scanner: {
            enabled:
              ortRun.jobConfigs.scanner !== undefined &&
              ortRun.jobConfigs.scanner !== null,
            skipConcluded:
              ortRun.jobConfigs.scanner?.skipConcluded ||
              baseDefaults.jobConfigs.scanner.skipConcluded,
            skipExcluded:
              ortRun.jobConfigs.scanner?.skipExcluded ||
              baseDefaults.jobConfigs.scanner.skipExcluded,
          },
          evaluator: {
            enabled:
              ortRun.jobConfigs.evaluator !== undefined &&
              ortRun.jobConfigs.evaluator !== null,
            ruleSet:
              ortRun.jobConfigs.evaluator?.ruleSet ||
              baseDefaults.jobConfigs.evaluator.ruleSet,
            licenseClassificationsFile:
              ortRun.jobConfigs.evaluator?.licenseClassificationsFile ||
              baseDefaults.jobConfigs.evaluator.licenseClassificationsFile,
            copyrightGarbageFile:
              ortRun.jobConfigs.evaluator?.copyrightGarbageFile ||
              baseDefaults.jobConfigs.evaluator.copyrightGarbageFile,
            resolutionsFile:
              ortRun.jobConfigs.evaluator?.resolutionsFile ||
              baseDefaults.jobConfigs.evaluator.resolutionsFile,
          },
          reporter: {
            enabled:
              ortRun.jobConfigs.reporter !== undefined &&
              ortRun.jobConfigs.reporter !== null,
            formats:
              ortRun.jobConfigs.reporter?.formats ||
              baseDefaults.jobConfigs.reporter.formats,
          },
          notifier: {
            enabled:
              ortRun.jobConfigs.notifier !== undefined &&
              ortRun.jobConfigs.notifier !== null,
            notifierRules:
              ortRun.jobConfigs.notifier?.notifierRules ||
              baseDefaults.jobConfigs.notifier.notifierRules,
            resolutionsFile:
              ortRun.jobConfigs.notifier?.resolutionsFile ||
              baseDefaults.jobConfigs.notifier.resolutionsFile,
            mail: {
              // Convert the recipient addresses string array coming from the back-end to an array of objects.
              // This needs to be done because the useFieldArray hook requires an array of objects.
              recipientAddresses:
                ortRun.jobConfigs.notifier?.mail?.recipientAddresses?.map(
                  (email) => ({ email })
                ) || baseDefaults.jobConfigs.notifier.mail.recipientAddresses,
              mailServerConfiguration: {
                hostName:
                  ortRun.jobConfigs.notifier?.mail?.mailServerConfiguration
                    ?.hostName ||
                  baseDefaults.jobConfigs.notifier.mail.mailServerConfiguration
                    .hostName,
                port:
                  ortRun.jobConfigs.notifier?.mail?.mailServerConfiguration
                    ?.port ||
                  baseDefaults.jobConfigs.notifier.mail.mailServerConfiguration
                    .port,
                username:
                  ortRun.jobConfigs.notifier?.mail?.mailServerConfiguration
                    ?.username ||
                  baseDefaults.jobConfigs.notifier.mail.mailServerConfiguration
                    .username,
                password:
                  ortRun.jobConfigs.notifier?.mail?.mailServerConfiguration
                    ?.password ||
                  baseDefaults.jobConfigs.notifier.mail.mailServerConfiguration
                    .password,
                useSsl:
                  ortRun.jobConfigs.notifier?.mail?.mailServerConfiguration
                    ?.useSsl ||
                  baseDefaults.jobConfigs.notifier.mail.mailServerConfiguration
                    .useSsl,
                fromAddress:
                  ortRun.jobConfigs.notifier?.mail?.mailServerConfiguration
                    ?.fromAddress ||
                  baseDefaults.jobConfigs.notifier.mail.mailServerConfiguration
                    .fromAddress,
              },
            },
            jira: {
              jiraRestClientConfiguration: {
                serverUrl:
                  ortRun.jobConfigs.notifier?.jira?.jiraRestClientConfiguration
                    ?.serverUrl ||
                  baseDefaults.jobConfigs.notifier.jira
                    .jiraRestClientConfiguration.serverUrl,
                username:
                  ortRun.jobConfigs.notifier?.jira?.jiraRestClientConfiguration
                    ?.username ||
                  baseDefaults.jobConfigs.notifier.jira
                    .jiraRestClientConfiguration.username,
                password:
                  ortRun.jobConfigs.notifier?.jira?.jiraRestClientConfiguration
                    ?.password ||
                  baseDefaults.jobConfigs.notifier.jira
                    .jiraRestClientConfiguration.password,
              },
            },
          },
          // Convert the parameters object map coming from the back-end to an array of key-value pairs.
          // This needs to be done because the useFieldArray hook requires an array of objects.
          parameters: convertMapToArray(ortRun.jobConfigs.parameters || {}),
        },
        // Convert the labels object map coming from the back-end to an array of key-value pairs.
        labels: convertMapToArray(ortRun.labels || {}),
        jobConfigContext:
          ortRun.jobConfigContext || baseDefaults.jobConfigContext,
      }
    : baseDefaults;

  return defaultValues;
}

/**
 * Due to API schema and requirements for the form schema, the form values can't be directly passed
 * to the API. This function converts form values to correct payload to create an ORT run.
 */
export function formValuesToPayload(
  values: z.infer<typeof createRunFormSchema>
): CreateOrtRun {
  // In ORT Server, running or not running a job for and ORT Run is decided
  // based on the presence or absence of the corresponding job configuration
  // in the request body. If a job is disabled in the UI, we pass "undefined"
  // as the configuration for that job in the request body, in effect leaving
  // it empty, and thus disabling the job.
  const analyzerConfig: AnalyzerJobConfiguration = {
    allowDynamicVersions: values.jobConfigs.analyzer.allowDynamicVersions,
    repositoryConfigPath:
      values.jobConfigs.analyzer.repositoryConfigPath || undefined,
    skipExcluded: values.jobConfigs.analyzer.skipExcluded,
    // Convert the relevant part of form schema back to the format expected by the back-end.
    enabledPackageManagers: [
      ...Object.keys(values.jobConfigs.analyzer.packageManagers).filter(
        (pm) =>
          values.jobConfigs.analyzer.packageManagers[
            pm as keyof typeof values.jobConfigs.analyzer.packageManagers
          ].enabled
      ),
      'Unmanaged', // Add "Unmanaged" package manager to all runs
    ],
    packageManagerOptions: (() => {
      const options = Object.entries(values.jobConfigs.analyzer.packageManagers)
        .filter(
          ([_pmId, pm]) => pm.enabled && pm.options && pm.options.length > 0
        )
        .map(([pmId, pm]) => ({
          [pmId]: {
            options: convertArrayToMap(pm.options || []),
          },
        }))
        .reduce((acc, pm) => ({ ...acc, ...pm }), {});

      return Object.keys(options).length > 0 ? options : undefined;
    })(),
  };

  const advisorConfig = values.jobConfigs.advisor.enabled
    ? {
        skipExcluded: values.jobConfigs.advisor.skipExcluded,
        advisors: values.jobConfigs.advisor.advisors,
      }
    : undefined;

  const scannerConfig = values.jobConfigs.scanner.enabled
    ? {
        createMissingArchives: true,
        skipConcluded: values.jobConfigs.scanner.skipConcluded,
        skipExcluded: values.jobConfigs.scanner.skipExcluded,
      }
    : undefined;

  const evaluatorConfig = values.jobConfigs.evaluator.enabled
    ? {
        // Only include the config parameter structures if the corresponding form fields are not empty.
        // In case they are empty, the default path from the config file provider will be used to
        // resolve the corresponding files.
        ruleSet: values.jobConfigs.evaluator.ruleSet || undefined,
        licenseClassificationsFile:
          values.jobConfigs.evaluator.licenseClassificationsFile || undefined,
        copyrightGarbageFile:
          values.jobConfigs.evaluator.copyrightGarbageFile || undefined,
        resolutionsFile:
          values.jobConfigs.evaluator.resolutionsFile || undefined,
      }
    : undefined;

  const reporterConfig = values.jobConfigs.reporter.enabled
    ? {
        formats: values.jobConfigs.reporter.formats,
      }
    : undefined;

  // Convert the recipient addresses back to an array of strings, as expected by the back-end.
  const addresses = values.jobConfigs.notifier.mail.recipientAddresses
    ? values.jobConfigs.notifier.mail.recipientAddresses.map(
        (recipient) => recipient.email
      )
    : undefined;
  const notifierConfig = values.jobConfigs.notifier.enabled
    ? {
        notifierRules: values.jobConfigs.notifier.notifierRules || undefined,
        resolutionsFile:
          values.jobConfigs.notifier.resolutionsFile || undefined,
        mail: {
          recipientAddresses: addresses || undefined,
          mailServerConfiguration: {
            hostName:
              values.jobConfigs.notifier.mail.mailServerConfiguration.hostName,
            port: values.jobConfigs.notifier.mail.mailServerConfiguration.port,
            username:
              values.jobConfigs.notifier.mail.mailServerConfiguration.username,
            password:
              values.jobConfigs.notifier.mail.mailServerConfiguration.password,
            useSsl:
              values.jobConfigs.notifier.mail.mailServerConfiguration.useSsl,
            fromAddress:
              values.jobConfigs.notifier.mail.mailServerConfiguration
                .fromAddress,
          },
        },
        jira: {
          jiraRestClientConfiguration: {
            serverUrl:
              values.jobConfigs.notifier.jira.jiraRestClientConfiguration
                .serverUrl,
            username:
              values.jobConfigs.notifier.jira.jiraRestClientConfiguration
                .username,
            password:
              values.jobConfigs.notifier.jira.jiraRestClientConfiguration
                .password,
          },
        },
      }
    : undefined;

  // Convert the parameters and labels arrays back to objects, as expected by the back-end.
  const parameters = values.jobConfigs.parameters
    ? convertArrayToMap(values.jobConfigs.parameters)
    : undefined;
  const labels = values.labels ? convertArrayToMap(values.labels) : undefined;

  const requestBody = {
    revision: values.revision,
    path: values.path,
    jobConfigs: {
      analyzer: analyzerConfig,
      advisor: advisorConfig,
      scanner: scannerConfig,
      evaluator: evaluatorConfig,
      reporter: reporterConfig,
      notifier: notifierConfig,
      parameters: parameters,
    },
    labels: labels,
    jobConfigContext: values.jobConfigContext,
  };

  return requestBody;
}
