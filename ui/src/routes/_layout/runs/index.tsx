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

import { createFileRoute, Link, redirect } from '@tanstack/react-router';
import {
  ColumnDef,
  getCoreRowModel,
  useReactTable,
} from '@tanstack/react-table';
import { View } from 'lucide-react';

import {
  useOrganizationsServiceGetOrganizationById,
  useProductsServiceGetProductById,
  useRepositoriesServiceGetRepositoryById,
} from '@/api/queries';
import { prefetchUseRunsServiceGetOrtRuns } from '@/api/queries/prefetch';
import { useRunsServiceGetOrtRunsSuspense } from '@/api/queries/suspense';
import { OrtRunSummary } from '@/api/requests';
import { DataTable } from '@/components/data-table/data-table';
import { DataTableToolbar } from '@/components/data-table/data-table-toolbar';
import { FilterMultiSelect } from '@/components/data-table/filter-multi-select';
import { OrtRunJobStatus } from '@/components/ort-run-job-status';
import { RunDuration } from '@/components/run-duration';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from '@/components/ui/tooltip';
import { config } from '@/config';
import { getStatusBackgroundColor } from '@/helpers/get-status-class';
import { ortRunStatusValues, paginationSchema, statusSchema } from '@/schemas';

const defaultPageSize = 10;
const pollInterval = config.pollInterval;

const Repository = ({
  orgId,
  prodId,
  repoId,
}: {
  orgId: number;
  prodId: number;
  repoId: number;
}) => {
  const { data: repo } = useRepositoriesServiceGetRepositoryById({
    repositoryId: repoId,
  });

  const { data: org } = useOrganizationsServiceGetOrganizationById({
    organizationId: orgId,
  });

  const { data: prod } = useProductsServiceGetProductById({
    productId: prodId,
  });

  return (
    <div>
      <Link
        className='block font-semibold text-blue-400 hover:underline'
        to={'/organizations/$orgId/products/$productId/repositories/$repoId'}
        params={{
          orgId: orgId.toString(),
          productId: prodId.toString(),
          repoId: repoId.toString(),
        }}
      >
        {repo?.url}
      </Link>
      <div className='text-xs italic text-slate-500'>
        in{' '}
        <Link
          className='hover:underline'
          to={'/organizations/$orgId'}
          params={{ orgId: orgId.toString() }}
        >
          {org?.name}
        </Link>
        /
        <Link
          className='hover:underline'
          to={'/organizations/$orgId/products/$productId'}
          params={{ orgId: orgId.toString(), productId: prodId.toString() }}
        >
          {prod?.name}
        </Link>
      </div>
    </div>
  );
};

const columns: ColumnDef<OrtRunSummary>[] = [
  {
    accessorKey: 'repoUrl',
    header: 'Repository',
    cell: ({ row }) => (
      <Repository
        orgId={row.original.organizationId}
        prodId={row.original.productId}
        repoId={row.original.repositoryId}
      />
    ),
  },
  {
    accessorKey: 'createdAt',
    header: 'Created At',
    cell: ({ row }) => (
      <div>
        {new Date(row.original.createdAt).toLocaleString(navigator.language)}
      </div>
    ),
    size: 100,
  },
  {
    accessorKey: 'finishedAt',
    header: 'Finished At',
    cell: ({ row }) =>
      row.original.finishedAt ? (
        <div>
          {new Date(row.original.finishedAt).toLocaleString(navigator.language)}
        </div>
      ) : (
        <div className='italic'>Not finished yet</div>
      ),
    size: 100,
  },
  {
    accessorKey: 'runStatus',
    header: () => <div>Run Status</div>,
    cell: ({ row }) => (
      <Badge
        className={`border ${getStatusBackgroundColor(row.original.status)}`}
      >
        {row.original.status}
      </Badge>
    ),
  },
  {
    accessorKey: 'jobStatuses',
    header: () => <div>Job Status</div>,
    cell: ({ row }) => (
      <OrtRunJobStatus
        jobs={row.original.jobs}
        pollInterval={pollInterval}
        orgId={row.original.organizationId.toString()}
        productId={row.original.productId.toString()}
        repoId={row.original.repositoryId.toString()}
        runIndex={row.original.index.toString()}
      />
    ),
    size: 100,
  },
  {
    accessorKey: 'duration',
    header: () => <div>Duration</div>,
    cell: ({ row }) => (
      <RunDuration
        createdAt={row.original.createdAt}
        finishedAt={row.original.finishedAt}
        pollInterval={pollInterval}
      />
    ),
    size: 100,
  },
  {
    accessorKey: 'actions',
    header: () => <div>Actions</div>,
    cell: ({ row }) => (
      <div className='flex gap-2'>
        <TooltipProvider>
          <Tooltip>
            <TooltipTrigger asChild>
              <Button variant='outline' asChild size='sm'>
                <Link
                  to={
                    '/organizations/$orgId/products/$productId/repositories/$repoId/runs/$runIndex'
                  }
                  params={{
                    orgId: row.original.organizationId.toString(),
                    productId: row.original.productId.toString(),
                    repoId: row.original.repositoryId.toString(),
                    runIndex: row.original.index.toString(),
                  }}
                >
                  View
                  <View className='ml-1 h-4 w-4' />
                </Link>
              </Button>
            </TooltipTrigger>
            <TooltipContent>View the details of this run</TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>
    ),
  },
];

const RunsComponent = () => {
  const search = Route.useSearch();
  const pageIndex = search.page ? search.page - 1 : 0;
  const pageSize = search.pageSize ? search.pageSize : defaultPageSize;
  const status = search.status;
  const navigate = Route.useNavigate();

  const statuses = ortRunStatusValues.map((status) => ({
    label: status,
    value: status.toLowerCase(),
  }));

  const { data } = useRunsServiceGetOrtRunsSuspense({
    limit: pageSize,
    offset: pageIndex * pageSize,
    status: status,
  });

  const table = useReactTable({
    data: data?.data || [],
    columns,
    pageCount: Math.ceil((data?.pagination.totalCount ?? 0) / pageSize),
    state: {
      pagination: {
        pageIndex,
        pageSize,
      },
    },
    getCoreRowModel: getCoreRowModel(),
    manualPagination: true,
  });

  return (
    <Card>
      <CardHeader>
        <CardTitle>Runs</CardTitle>
        <CardDescription className='sr-only'>
          A list of all runs.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <DataTableToolbar
          resetFilters={() => {
            navigate({
              search: { ...search, status: undefined },
            });
          }}
          resetBtnVisible={status !== undefined}
        >
          <FilterMultiSelect
            title='Status'
            options={statuses}
            selected={status?.split(',') || []}
            setSelected={(statuses) => {
              navigate({
                search: {
                  ...search,
                  status:
                    statuses.length === 0 ? undefined : statuses.join(','),
                },
              });
            }}
          />
        </DataTableToolbar>
        <DataTable
          table={table}
          setCurrentPageOptions={(currentPage) => {
            return {
              to: Route.to,
              search: { ...search, page: currentPage },
            };
          }}
          setPageSizeOptions={(size) => {
            return {
              to: Route.to,
              search: { ...search, pageSize: size },
            };
          }}
        />
      </CardContent>
    </Card>
  );
};

export const Route = createFileRoute('/_layout/runs/')({
  validateSearch: paginationSchema.merge(statusSchema),
  loaderDeps: ({ search: { page, pageSize, status } }) => ({
    page,
    pageSize,
    status,
  }),
  loader: async ({ context, deps: { page, pageSize, status } }) => {
    await Promise.allSettled([
      prefetchUseRunsServiceGetOrtRuns(context.queryClient, {
        limit: pageSize || defaultPageSize,
        offset: page ? (page - 1) * (pageSize || defaultPageSize) : 0,
        status: status,
      }),
    ]);
  },
  component: RunsComponent,
  beforeLoad: ({ context }) => {
    if (!context.auth.hasRole(['superuser'])) {
      throw redirect({
        to: '/403',
      });
    }
  },
});
