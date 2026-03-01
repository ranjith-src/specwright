#!/bin/bash
# DO NOT EDIT: Managed by Specwright. Bypass: SPECWRIGHT_UNLOCK=1
set -euo pipefail

NAME="${1:?Usage: new-spike.sh <spike-name>}"
DIR="blueprint/changes/spikes/$NAME"
DATE=$(date +%Y-%m-%d)
TEMPLATE_DIR=".specwright/templates/spike"

if [ -d "$DIR" ]; then
  echo "Error: Spike '$NAME' already exists at $DIR"
  exit 1
fi

mkdir -p "$DIR"

for file in spike.md findings.md; do
  if [ -f "$TEMPLATE_DIR/$file" ]; then
    sed "s/{{NAME}}/$NAME/g; s/{{DATE}}/$DATE/g" "$TEMPLATE_DIR/$file" > "$DIR/$file"
  fi
done

echo "Created spike: $DIR/"
echo "  ├── spike.md      (QUESTION + TIMEBOX)"
echo "  └── findings.md   (fill after exploration)"
echo ""
echo "Explore freely. No ceremony. Fill findings.md when done."
