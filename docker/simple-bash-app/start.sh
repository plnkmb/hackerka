#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/app"
DATA_DIR="/opt/app/data"
CONFIG_TEMPLATE="/opt/app/config.template"
CONFIG_FILE="/opt/app/data/config.env"
LOG_FILE="/opt/app/data/app.log"

mkdir -p "$DATA_DIR"

log() {
  echo "[$(date '+%F %T')] $1" | tee -a "$LOG_FILE"
}

if [ ! -f "$CONFIG_FILE" ]; then
  cp "$CONFIG_TEMPLATE" "$CONFIG_FILE"
  APP_MODE_VALUE="$(pwgen -s 64 1)"
  sed -i "s|^APP_MODE=$|APP_MODE=$APP_MODE_VALUE|" "$CONFIG_FILE"
  log "config.env created"
fi

source "$CONFIG_FILE"

log "APP_MODE=$APP_MODE"

tail -f /dev/null
