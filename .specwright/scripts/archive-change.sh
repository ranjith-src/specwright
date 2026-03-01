#!/bin/bash
set -euo pipefail

NAME="${1:?Usage: archive-change.sh <change-name>}"
SOURCE="blueprint/changes/active/$NAME"
DATE=$(date +%Y-%m-%d)
ARCHIVE="blueprint/changes/archive/${DATE}-${NAME}"
TEMPLATE_DIR=".specwright/templates/change"

if [ ! -d "$SOURCE" ]; then
  echo "Error: No active change at $SOURCE"
  exit 1
fi

if [ ! -f "$SOURCE/review.md" ]; then
  if [ -f "$TEMPLATE_DIR/review.md" ]; then
    sed "s/{{NAME}}/$NAME/g; s/{{DATE}}/$DATE/g" "$TEMPLATE_DIR/review.md" > "$SOURCE/review.md"
  fi
  echo "Created review.md — fill it in, then run this command again."
  exit 0
fi

mv "$SOURCE" "$ARCHIVE"
echo "Archived: $ARCHIVE"
echo ""
echo "Don't forget to update source-of-truth specs in blueprint/specs/"
