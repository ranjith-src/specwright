#!/bin/bash
# DO NOT EDIT: Managed by Specwright. Bypass: SPECWRIGHT_UNLOCK=1
set -euo pipefail

TITLE="${1:?Usage: new-decision.sh <decision-title>}"
DECISIONS_DIR="blueprint/decisions"
DATE=$(date +%Y-%m-%d)
TEMPLATE_DIR=".specwright/templates/decision"

LAST_NUM=$(ls "$DECISIONS_DIR"/[0-9]*.md 2>/dev/null | sort -V | tail -1 | grep -oP '\d{4}' | head -1 || echo "0000")
NEXT_NUM=$(printf "%04d" $((10#${LAST_NUM} + 1)))

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
FILENAME="$DECISIONS_DIR/$NEXT_NUM-$SLUG.md"

if [ -f "$TEMPLATE_DIR/adr.md" ]; then
  sed "s/{{NUM}}/$NEXT_NUM/g; s/{{TITLE}}/$TITLE/g; s/{{DATE}}/$DATE/g" "$TEMPLATE_DIR/adr.md" > "$FILENAME"
fi

echo "| $NEXT_NUM | $DATE | $TITLE | Proposed | |" >> "$DECISIONS_DIR/DECISION-LOG.md"

echo "Created: $FILENAME"
echo "Updated: $DECISIONS_DIR/DECISION-LOG.md"
