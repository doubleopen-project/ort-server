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

// Status types

// Statuses reported either by ORT Runs or the individual jobs within them
type Status =
  | 'CREATED'
  | 'SCHEDULED'
  | 'RUNNING'
  | 'ACTIVE'
  | 'FAILED'
  | 'FINISHED'
  | 'FINISHED_WITH_ISSUES'
  | undefined;

export type VulnerabilityRating =
  | 'CRITICAL'
  | 'HIGH'
  | 'MEDIUM'
  | 'LOW'
  | 'NONE';

type RuleViolationSeverity = 'ERROR' | 'WARNING' | 'HINT';

// TailwindCSS classes matching to statuses
//
// Note: all color classes need to be defined as they are here, as they
// are formed in compilation time and cannot be interpolated in runtimet.

const STATUS_BACKGROUND_COLOR: {
  [K in Exclude<Status, undefined>]: string;
} = {
  CREATED: 'bg-gray-500',
  SCHEDULED: 'bg-blue-300',
  RUNNING: 'bg-blue-500',
  ACTIVE: 'bg-blue-500',
  FAILED: 'bg-red-500',
  FINISHED: 'bg-green-500',
  FINISHED_WITH_ISSUES: 'bg-yellow-500',
} as const;

const STATUS_FONT_COLOR: { [K in Exclude<Status, undefined>]: string } = {
  CREATED: 'text-gray-500',
  SCHEDULED: 'text-blue-300',
  RUNNING: 'text-blue-500',
  ACTIVE: 'text-blue-500',
  FAILED: 'text-red-500',
  FINISHED: 'text-green-500',
  FINISHED_WITH_ISSUES: 'text-yellow-500',
} as const;

const STATUS_CLASS: {
  [K in Exclude<Status, undefined>]: string;
} = {
  CREATED: 'w-3 h-3 rounded-full',
  SCHEDULED: 'w-3 h-3 rounded-full',
  RUNNING: 'w-4 h-4 rounded-full animate-pulse border border-black',
  ACTIVE: 'w-4 h-4 rounded-full animate-pulse border border-black',
  FAILED: 'w-3 h-3 rounded-full',
  FINISHED: 'w-3 h-3 rounded-full',
  FINISHED_WITH_ISSUES: 'w-3 h-3 rounded-full',
} as const;

const VULNERABILITY_RATING_BG_COLOR: {
  [K in VulnerabilityRating]: string;
} = {
  CRITICAL: 'bg-red-600',
  HIGH: 'bg-orange-600',
  MEDIUM: 'bg-amber-500',
  LOW: 'bg-yellow-400',
  NONE: 'bg-neutral-300',
} as const;

const RULE_VIOLATION_SEVERITY_BG_COLOR: {
  [K in RuleViolationSeverity]: string;
} = {
  ERROR: 'bg-red-600',
  WARNING: 'bg-orange-600',
  HINT: 'bg-neutral-300',
} as const;

// TailwindCSS class accessor functions
//
// As some TailwindCSS classes need to be returned with an
// accessor function which handles an undefined status specifically,
// access all classes through functions for the sake of consistency
// in code which uses these classes.

// Get the color class for coloring the background of elements
export function getStatusBackgroundColor(status: Status): string {
  if (status === undefined) {
    return 'bg-gray-300';
  }
  return STATUS_BACKGROUND_COLOR[status];
}

// Get the color class for font coloring
export function getStatusFontColor(status: Status): string {
  if (status === undefined) {
    return 'text-gray-300';
  }
  return STATUS_FONT_COLOR[status];
}

// Get the general class for the elements
export function getStatusClass(status: Status): string {
  if (status === undefined) {
    return 'w-3 h-3 rounded-full';
  }
  return STATUS_CLASS[status];
}

// Get the color class for coloring the background of vulnerability ratings
export function getVulnerabilityRatingBackgroundColor(
  rating: VulnerabilityRating
): string {
  return VULNERABILITY_RATING_BG_COLOR[rating];
}

// Get the color class for coloring the background of rule violation severities
export function getRuleViolationSeverityBackgroundColor(
  rating: RuleViolationSeverity
): string {
  return RULE_VIOLATION_SEVERITY_BG_COLOR[rating];
}
