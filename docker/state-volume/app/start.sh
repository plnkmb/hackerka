#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/app"
DATA_DIR="$APP_DIR/data"
STATE_TEMPLATE="$APP_DIR/state.template"
STATE_FILE="$DATA_DIR/state.env"
STEPS_FILE="$APP_DIR/steps.list"
RUN_LOG="$DATA_DIR/run.log"

mkdir -p "$DATA_DIR"

update_env() {
  local key="$1"
  local value="$2"

  if grep -q "^${key}=" "$STATE_FILE"; then
    sed -i "s|^${key}=.*|${key}=${value}|" "$STATE_FILE"
  else
    echo "${key}=${value}" >> "$STATE_FILE"
  fi
}

if [[ ! -f "$STATE_FILE" ]]; then
  cp "$STATE_TEMPLATE" "$STATE_FILE"

  SESSION_ID="$(pwgen 16 1)"
  LAST_STEP="init"
  RECOVERED="no"

  update_env "SESSION_ID" "$SESSION_ID"
  update_env "LAST_STEP" "$LAST_STEP"
  update_env "RECOVERED" "$RECOVERED"
else
  # shellcheck disable=SC1090
  . "$STATE_FILE"
  update_env "RECOVERED" "yes"
fi

touch "$RUN_LOG"

# shellcheck disable=SC1090
. "$STATE_FILE"

echo "$(date '+%F %T') hostname=$(hostname) SESSION_ID=$SESSION_ID LAST_STEP=$LAST_STEP RECOVERED=$RECOVERED" | tee -a "$RUN_LOG"

NEXT_STEP="$(
  awk -v current="$LAST_STEP" '
    $0 == current { found=1; next }
    found && NF { print; exit }
  ' "$STEPS_FILE"
)"

if [[ -n "${NEXT_STEP:-}" ]]; then
  update_env "LAST_STEP" "$NEXT_STEP"
  echo "current step: $NEXT_STEP" | tee -a "$RUN_LOG"
else
  echo "process already reached final step" | tee -a "$RUN_LOG"
fi

# shellcheck disable=SC1090
. "$STATE_FILE"

echo "SESSION_ID=$SESSION_ID" | tee -a "$RUN_LOG"
echo "LAST_STEP=$LAST_STEP" | tee -a "$RUN_LOG"
echo "RECOVERED=$RECOVERED" | tee -a "$RUN_LOG"

sleep infinity
