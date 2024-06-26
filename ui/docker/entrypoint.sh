#!/bin/sh

# Copyright (C) 2024 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0
# License-Filename: LICENSE

# Set default value for UI_URL as the default value does not work for the Docker image which uses a different port.
: "${UI_URL:=http://localhost:8082/}"

# Set the default value for UI_CLIENT_ID to use the Keycloak client with matching root and home URLs.
: "${UI_CLIENT_ID:=ort-server-ui}"

# Set the default value for UI_BASEPATH.
: "${UI_BASEPATH:=/}"

# Replace placeholders with actual environment variables in JavaScript files.
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s#VITE_BASEPATH||\"/\"#VITE_BASEPATH||\"$UI_BASEPATH\"#g" {} +
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s#VITE_CLIENT_ID||\"ort-server-ui-dev\"#VITE_CLIENT_ID||\"$UI_CLIENT_ID\"#g" {} +
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s#VITE_UI_URL||\"http://localhost:5173/\"#VITE_UI_URL||\"$UI_URL\"#g" {} +

if [ -n "$UI_API_URL" ]; then
  find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s#VITE_API_URL||\"http://localhost:8080\"#VITE_API_URL||\"$UI_API_URL\"#g" {} +
fi

if [ -n "$UI_AUTHORITY" ]; then
  find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s#VITE_AUTHORITY||\"http://localhost:8081/realms/master\"#VITE_AUTHORITY||\"$UI_AUTHORITY\"#g" {} +
fi

# Replace placeholders with actual environment variables in the nginx configuration.
export UI_BASEPATH
envsubst '${UI_BASEPATH}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
rm /etc/nginx/conf.d/default.conf.template

# Add base path to assets references in index.html.
sed -i "s|/assets/|${UI_BASEPATH}assets/|g" /usr/share/nginx/html/index.html

# Start nginx.
exec nginx -g 'daemon off;'
