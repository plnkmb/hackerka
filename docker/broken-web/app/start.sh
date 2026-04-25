#!/bin/sh
set -eu

ENV_FILE="${APP_ENV_FILE:-/opt/app/.env}"

if [ -f "$ENV_FILE" ]; then
  . "$ENV_FILE"
fi

echo "starter user: $(whoami)"
exec su -s /bin/sh app -c "python3 /opt/app/server.py"