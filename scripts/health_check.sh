#!/usr/bin/env bash

set -u

PROJECT_DIR="$HOME/projects/mini-linux-server"
LOG_FILE="$PROJECT_DIR/logs/health-check.log"
URL="http://127.0.0.1:8080/health"

mkdir -p "$PROJECT_DIR/logs"

TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

HTTP_CODE="$(
    curl --max-time 5 -sS -o /dev/null \
        -w '%{http_code}' "$URL"
)" || HTTP_CODE="000"

if [[ "$HTTP_CODE" == "200" ]]; then
    printf '%s PASS HTTP %s %s\n' \
        "$TIMESTAMP" "$HTTP_CODE" "$URL" | tee -a "$LOG_FILE"
    exit 0
else
    printf '%s FAIL HTTP %s %s\n' \
        "$TIMESTAMP" "$HTTP_CODE" "$URL" | tee -a "$LOG_FILE"
    exit 1
fi
