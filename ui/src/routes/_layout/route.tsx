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

import { createFileRoute, Outlet, useLocation } from '@tanstack/react-router';
import { Eye, ListVideo } from 'lucide-react';

import { Header } from '@/components/header';
import { PageLayout } from '@/components/page-layout';
import { useUser } from '@/hooks/use-user';

const Layout = () => {
  const location = useLocation();
  const user = useUser();

  const sections = [
    {
      items: [
        {
          title: 'Overview',
          to: '/',
          icon: () => <Eye className='h-4 w-4' />,
        },
      ],
    },
    {
      label: 'Status',
      items: [
        {
          title: 'Runs',
          to: '/runs',
          icon: () => <ListVideo className='h-4 w-4' />,
          visible: user.hasRole(['superuser']),
        },
      ],
      visible: user.hasRole(['superuser']),
    },
  ];

  return (
    <div className='flex min-h-screen w-full flex-col'>
      <Header />
      <main className='flex h-full flex-col gap-4 p-4 md:w-full md:items-center md:gap-8 md:p-8'>
        {location.pathname === '/' ||
        location.pathname === '/runs' ||
        location.pathname === '/create-organization' ? (
          <PageLayout sections={sections}>
            <Outlet />
          </PageLayout>
        ) : (
          <Outlet />
        )}
      </main>
    </div>
  );
};

export const Route = createFileRoute('/_layout')({
  component: Layout,
});
