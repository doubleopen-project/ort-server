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

import { PlusIcon, TrashIcon } from 'lucide-react';
import { useFieldArray, UseFormReturn } from 'react-hook-form';

import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/accordion';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { cn } from '@/lib/utils';
import { packageManagers } from '@/routes/_layout/organizations/$orgId/products/$productId/repositories/$repoId/-types';
import { CreateRunFormValues } from '../-create-run-utils';

type PackageManagerFieldProps = {
  form: UseFormReturn<CreateRunFormValues>;
  className?: string;
};

export const PackageManagerField = ({
  form,
  className,
}: PackageManagerFieldProps) => {
  return (
    <FormField
      control={form.control}
      name='jobConfigs.analyzer.packageManagers'
      render={({ field }) => (
        <FormItem
          className={cn(
            'mb-4 flex flex-col justify-between rounded-lg border p-4',
            className
          )}
        >
          <FormLabel>Enabled package managers</FormLabel>
          <FormDescription className='pb-4'>
            {
              <>
                Select the package managers enabled for this ORT Run. Note that
                the 'Unmanaged' package manager is always enabled.
              </>
            }
          </FormDescription>
          <div className='flex items-center space-x-3'>
            <Checkbox
              id='check-all-items'
              checked={
                Object.values(field.value || {}).every((pm) => pm.enabled)
                  ? true
                  : Object.values(field.value || {}).some((pm) => pm.enabled)
                    ? 'indeterminate'
                    : false
              }
              onCheckedChange={(checked) => {
                const enabledItems = checked
                  ? Object.keys(field.value || {}).reduce(
                      (acc, key) => {
                        acc[key as keyof typeof field.value] = {
                          ...field.value[key as keyof typeof field.value],
                          enabled: true,
                        };
                        return acc;
                      },
                      {} as typeof field.value
                    )
                  : Object.keys(field.value || {}).reduce(
                      (acc, key) => {
                        acc[key as keyof typeof field.value] = {
                          ...field.value[key as keyof typeof field.value],
                          enabled: false,
                        };
                        return acc;
                      },
                      {} as typeof field.value
                    );
                form.setValue(
                  'jobConfigs.analyzer.packageManagers',
                  enabledItems
                );
              }}
            />
            <Label htmlFor='check-all-items' className='font-bold'>
              Enable/disable all
            </Label>
          </div>
          <Separator />
          {packageManagers.map((pm, index) => {
            const enabled = field.value?.[pm.id]?.enabled;

            return (
              <FormItem
                key={pm.id}
                className='flex flex-row items-center space-x-3 space-y-0'
              >
                <FormControl>
                  <Checkbox
                    checked={enabled}
                    onCheckedChange={(checked) => {
                      return checked
                        ? field.onChange({
                            ...field.value,
                            [pm.id]: { ...field.value[pm.id], enabled: true },
                          })
                        : field.onChange({
                            ...field.value,
                            [pm.id]: { ...field.value[pm.id], enabled: false },
                          });
                    }}
                  />
                </FormControl>
                {enabled ? (
                  <FieldWithOptions
                    form={form}
                    pmIndex={index}
                    pmName={pm.id}
                  />
                ) : (
                  <FormLabel className='font-normal'>{pm.label}</FormLabel>
                )}
              </FormItem>
            );
          })}
          <FormMessage />
        </FormItem>
      )}
    />
  );
};

type FieldWithOptionsProps = {
  form: UseFormReturn<CreateRunFormValues>;
  pmIndex: number;
  pmName:
    | 'Bazel'
    | 'Bundler'
    | 'Cargo'
    | 'Composer'
    | 'GoMod'
    | 'GradleInspector'
    | 'Maven'
    | 'NPM'
    | 'NuGet'
    | 'PIP'
    | 'Pipenv'
    | 'PNPM'
    | 'Poetry'
    | 'Yarn'
    | 'Yarn2';
};

const FieldWithOptions = ({ form, pmIndex, pmName }: FieldWithOptionsProps) => {
  const {
    fields: optionsFields,
    append,
    remove,
  } = useFieldArray({
    name: `jobConfigs.analyzer.packageManagers.${pmName}.options`,
    control: form.control,
  });

  const pm = packageManagers[pmIndex];

  return (
    <Accordion type='single' collapsible className='w-full'>
      <AccordionItem value='item' className='border-none'>
        <AccordionTrigger className='py-0 hover:no-underline'>
          <FormLabel className='font-normal'>{pm.label}</FormLabel>
        </AccordionTrigger>
        <AccordionContent>
          <h4 className='mt-2'>Options:</h4>
          {optionsFields.map((field, index) => (
            <div
              key={field.id}
              className='my-2 flex flex-row items-end space-x-2'
            >
              <div className='flex-auto'>
                {index === 0 && <FormLabel>Key</FormLabel>}
                <FormField
                  control={form.control}
                  name={`jobConfigs.analyzer.packageManagers.${pmName}.options.${index}.key`}
                  render={({ field }) => (
                    <FormItem>
                      <FormControl>
                        <Input {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>
              <div className='flex-auto'>
                {index === 0 && <FormLabel>Value</FormLabel>}
                <FormField
                  control={form.control}
                  name={`jobConfigs.analyzer.packageManagers.${pmName}.options.${index}.value`}
                  render={({ field }) => (
                    <FormItem>
                      <FormControl>
                        <Input {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>
              <Button
                type='button'
                variant='outline'
                size='sm'
                onClick={() => {
                  remove(index);
                }}
              >
                <TrashIcon className='h-4 w-4' />
              </Button>
            </div>
          ))}
          <Button
            size='sm'
            className='mt-2'
            variant='outline'
            type='button'
            onClick={() => {
              append({ key: '', value: '' });
            }}
          >
            Add parameter
            <PlusIcon className='ml-1 h-4 w-4' />
          </Button>
        </AccordionContent>
      </AccordionItem>
    </Accordion>
  );
};
