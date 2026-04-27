#!/bin/sh
set -eu

ENV_FILE="${APP_ENV_FILE:-/run/app/runtime.env}"

if [ -f "$ENV_FILE" ]; then
  . "$ENV_FILE"
fi

echo "entrypoint user: $(whoami)"
exec /srv/app/bin/run-api.sh