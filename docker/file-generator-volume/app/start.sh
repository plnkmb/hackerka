#!/usr/bin/env bash
set -eu

APP_DIR="/opt/app"
DATA_DIR="$APP_DIR/data"
OUT_DIR="$DATA_DIR/out"
ENV_FILE="$DATA_DIR/generator.env"
TEMPLATE_FILE="$APP_DIR/file.template"

mkdir -p "$OUT_DIR"

if [ ! -f "$ENV_FILE" ]; then
  echo "GENERATED_COUNT=0" > "$ENV_FILE"
fi

. "$ENV_FILE"

CURRENT_COUNT="${GENERATED_COUNT:-0}"
NEXT_COUNT=$((CURRENT_COUNT + 1))

FILE_ID="$(pwgen -1 12)"
CREATED_AT="$(date '+%Y-%m-%d %H:%M:%S')"
PAYLOAD="$(pwgen -1 64)"

OUTPUT_FILE="$OUT_DIR/report_${NEXT_COUNT}.txt"

awk \
  -v file_id="$FILE_ID" \
  -v created_at="$CREATED_AT" \
  -v payload="$PAYLOAD" \
  '
  /^FILE_ID=/    { print "FILE_ID=" file_id; next }
  /^CREATED_AT=/ { print "CREATED_AT=" created_at; next }
  /^PAYLOAD=/    { print "PAYLOAD=" payload; next }
  { print }
  ' "$TEMPLATE_FILE" > "$OUTPUT_FILE"

echo "GENERATED_COUNT=$NEXT_COUNT" > "$ENV_FILE"

echo "generated file: $(basename "$OUTPUT_FILE")"
echo "GENERATED_COUNT=$NEXT_COUNT"

sleep infinity