#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/bw-session.sh"

ENV_MAP="$(dirname "$0")/env-map.json"
SECURE_DIR="${SECURE_DIR:-$HOME/.secure}"
OUTPUT_FILE="${OUTPUT_FILE:-$SECURE_DIR/.secure-env}"

mkdir -p "$SECURE_DIR"
chmod 700 "$SECURE_DIR"
> "$OUTPUT_FILE"
chmod 600 "$OUTPUT_FILE"

echo "🔐 Loading environment secrets from $ENV_MAP"

jq -r '
  to_entries[]
  | [
      .key,
      .value.bitwarden_item,
      (.value.field // "login.password"),
      (.value.write_to_file // false)
    ]
  | @tsv
' "$ENV_MAP" |
while IFS=$'\t' read -r VAR ITEM FIELD WRITE; do
  echo "➡️  $VAR ← $ITEM ($FIELD)"

  RAW_ITEM="$(bw_sess get item "$ITEM")"

  VALUE="$(echo "$RAW_ITEM" | jq -r "try .$FIELD // empty")"

  if [[ -z "$VALUE" || "$VALUE" == "null" ]]; then
    echo "  ❌ Failed to extract $FIELD from $ITEM"
    continue
  fi

  export "$VAR=$VALUE"
  echo "  ✅ Exported $VAR"

  if [[ "$WRITE" == "true" ]]; then
    echo "$VAR=$VALUE" >> "$OUTPUT_FILE"
    echo "  💾 Wrote $VAR to $OUTPUT_FILE"
  fi
done

echo "✅ All secrets loaded. Optional file: $OUTPUT_FILE"
