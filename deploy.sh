#!/usr/bin/env bash

set -euo pipefail

REMOTE_HOST="guanwang-server"
REMOTE_STAGE_DIR="/home/ubuntu/guanwang-deploy"
REMOTE_TARGET_DIR="/var/www/guanwang"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

rsync -az --delete \
  --exclude ".git/" \
  --exclude ".DS_Store" \
  --exclude "deploy.sh" \
  "$SCRIPT_DIR/" "$REMOTE_HOST:$REMOTE_STAGE_DIR/"

ssh "$REMOTE_HOST" "sudo mkdir -p '$REMOTE_TARGET_DIR' && sudo rsync -az --delete '$REMOTE_STAGE_DIR/' '$REMOTE_TARGET_DIR/'"

echo "Deployed to $REMOTE_HOST:$REMOTE_TARGET_DIR"
