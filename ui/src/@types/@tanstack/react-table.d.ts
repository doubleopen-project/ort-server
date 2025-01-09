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

/* eslint-disable @typescript-eslint/no-unused-vars */

import { ColumnMeta, RowData } from '@tanstack/react-table';

declare module '@tanstack/react-table' {
  // Extend the ColumnMeta interface to include properties needed for filtering
  interface ColumnMeta<TData extends RowData, TValue> {
    /*
     * The filterVariant property is used to determine the type of filter to render.
     * More options can be added as needed. Defaults to 'text'.
     */
    filterVariant?: 'text' | 'select';
    /*
     * The options property is used to provide the options for a select filter.
     * This property is required when filterVariant is 'select'.
     */
    options?: {
      label: string;
      value: T;
      icon?: React.ComponentType<{ className?: string }>;
    }[];
    /*
     * The setSelected property is used to set the selected filter value.
     * This property is required when filterVariant is 'select'.
     */
    setSelected?: (selected: T[]) => void;
    /*
     *
     */
    //setFilterValue?: ((value: T[]) => void) | ((value: string) => void);
    setFilterValue?: (value: string) => void;
  }
}
