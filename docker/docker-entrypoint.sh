#!/bin/sh
set -e

#cycle.io networking quirk: wait a bit before initial connection
#sleep 3

# Construct the BACKEND_URL
# Use the variables passed from the ConfigMap or as env variables
BACKEND_URL="${BACKEND_URL:-http://no-backend-url-set:80}"
API_URL="${API_URL:-https://no-api-url-set/backend}"

# Replace environment variables in the Nginx config template
envsubst '$BACKEND_URL $API_URL' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

# Execute the CMD (which is "nginx -g 'daemon off;'")
exec "$@"
