#!/bin/bash
# DO NOT EDIT: Managed by Specwright. Bypass: SPECWRIGHT_UNLOCK=1
set -euo pipefail

NAME="${1:?Usage: new-change.sh <change-name>}"
DIR="blueprint/changes/active/$NAME"
DATE=$(date +%Y-%m-%d)
TEMPLATE_DIR=".specwright/templates/change"

if [ -d "$DIR" ]; then
  echo "Error: Change '$NAME' already exists at $DIR"
  exit 1
fi

mkdir -p "$DIR"

for file in proposal.md tests.md design.md tasks.md; do
  if [ -f "$TEMPLATE_DIR/$file" ]; then
    sed "s/{{NAME}}/$NAME/g; s/{{DATE}}/$DATE/g" "$TEMPLATE_DIR/$file" > "$DIR/$file"
  fi
done

echo "Created change: $DIR/"
echo "  ├── proposal.md   (WHY)"
echo "  ├── tests.md      (WHAT — write test specs FIRST)"
echo "  ├── design.md     (HOW)"
echo "  └── tasks.md      (STEPS)"
echo ""
echo "Workflow: proposal → tests → design → tasks → TDD → review → /sw-commit → /sw-pr → /sw-archive"
