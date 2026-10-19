#!/usr/bin/env bash

set -Eeuo pipefail

PROJECT_DIR="$HOME/projects/mini-linux-server"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP="$(date '+%Y%m%d-%H%M%S')"
BACKUP_FILE="$BACKUP_DIR/mini-linux-server-$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

if sudo tar -cf - -C /srv/mini-linux-server \
    app config data logs | gzip > "$BACKUP_FILE"; then
    printf 'Backup created: %s\n' "$BACKUP_FILE"
else
    rm -f "$BACKUP_FILE"
    printf 'Backup failed.\n' >&2
    exit 1
fi

if tar -tzf "$BACKUP_FILE" > /dev/null; then
    printf 'Backup archive verification: PASS\n'
else
    printf 'Backup archive verification: FAIL\n' >&2
    exit 1
fi
