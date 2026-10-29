#!/usr/bin/env bash
set -euo pipefail

# Public reference collector. It emits a small, synthetic-safe payload and
# sends it to a configurable ingestion endpoint. No production paths or
# credentials are embedded here.

API_URL="${API_URL:-http://localhost:3333/api/v1/ingest/host}"
COLLECTOR_TOKEN="${COLLECTOR_TOKEN:-}"
HOST_LABEL="${HOST_LABEL:-example-host}"

cpu_percent="$(awk -F' ' '/^cpu / {idle=$5; total=$2+$3+$4+$5+$6+$7+$8; print (1-idle/total)*100; exit}' /proc/stat 2>/dev/null || printf '0')"
memory_percent="$(awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {if (total) printf "%.2f", (1-available/total)*100; else print "0"}' /proc/meminfo 2>/dev/null)"
disk_percent="$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}' 2>/dev/null || printf '0')"

payload=$(printf '{"host":"%s","cpu_percent":%.2f,"memory_percent":%.2f,"disk_percent":%s}' \
  "$HOST_LABEL" "$cpu_percent" "$memory_percent" "$disk_percent")

headers=(-H 'Content-Type: application/json')
if [[ -n "$COLLECTOR_TOKEN" ]]; then
  headers+=(-H "Authorization: Bearer ${COLLECTOR_TOKEN}")
fi

curl --fail-with-body --silent --show-error --max-time 15 \
  "${headers[@]}" --data "$payload" "$API_URL"
