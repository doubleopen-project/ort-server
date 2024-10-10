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

import z from 'zod';

import { OrtRunStatus } from '@/api/requests';

// Pagination schema that is used for search parameter validation
export const paginationSchema = z.object({
  page: z.number().optional(),
  pageSize: z.number().optional(),
});

// Enum schema for the groupId parameter of the Groups endpoints
export const groupsSchema = z.enum(['admins', 'writers', 'readers']);

/* Enum schema for the status parameter of the runs. Declared separately
 * to catch if the OrtRunStatus type changes in the future, as the zod
 * schema cannot be generated from the type directly.
 */
export const ortRunStatusValues: OrtRunStatus[] = [
  'CREATED',
  'ACTIVE',
  'FAILED',
  'FINISHED',
  'FINISHED_WITH_ISSUES',
];

// Status schema that is used for search parameter validation
export const statusSchema = z.object({
  status: z
    .string()
    .transform((value, ctx) => {
      const statuses = value.split(',');

      for (const status of statuses) {
        if (
          !ortRunStatusValues.includes(status.toUpperCase() as OrtRunStatus)
        ) {
          ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: `Invalid status: ${status}`,
          });
          return z.NEVER;
        }
        return value;
      }
    })
    .optional(),
  /*
    .transform((value) => value.split(','))
    .pipe(
      z.array(
        z.enum([
          'created',
          'active',
          'failed',
          'finished',
          'finished_with_issues',
        ])
      )
    )
    .optional(),*/
});
