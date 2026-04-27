#!/bin/sh
set -eu

echo "runner user before drop: $(whoami)"
exec su -s /bin/sh app -c "python3 /srv/app/api.py"