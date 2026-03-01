#!/bin/bash

DOCS="blueprint"

echo "=== Specwright Status ==="
echo ""

# Active changes
ACTIVE=$(find "$DOCS/changes/active" -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
if [ -n "$ACTIVE" ]; then
  echo "Active Changes:"
  for dir in $ACTIVE; do
    name=$(basename "$dir")
    status=""
    [ -f "$dir/review.md" ] && status=" [review written — ready to archive]"
    total=$(grep -c '^\- \[' "$dir/tasks.md" 2>/dev/null || true)
    done=$(grep -ci '^\- \[x\]' "$dir/tasks.md" 2>/dev/null || true)
    total=${total:-0}; done=${done:-0}
    [ "$total" -gt 0 ] 2>/dev/null && status=" [$done/$total tasks]$status"
    echo "  → $name$status"
  done
else
  echo "Active Changes: none"
fi
echo ""

# Active spikes
SPIKES=$(find "$DOCS/changes/spikes" -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
if [ -n "$SPIKES" ]; then
  echo "Active Spikes:"
  for dir in $SPIKES; do
    name=$(basename "$dir")
    timebox=""
    if [ -f "$dir/spike.md" ]; then
      tb=$(grep -i "^## Timebox" -A1 "$dir/spike.md" 2>/dev/null | tail -1 | sed 's/^[[:space:]]*//')
      [ -n "$tb" ] && timebox=" [timebox: $tb]"
    fi
    echo "  → $name$timebox"
  done
else
  echo "Active Spikes: none"
fi
echo ""

# Recent decisions
echo "Recent Decisions:"
if [ -f "$DOCS/decisions/DECISION-LOG.md" ]; then
  tail -5 "$DOCS/decisions/DECISION-LOG.md" | grep "^|" | grep -v "^| #" | grep -v "^|---" || echo "  none yet"
else
  echo "  no decision log found"
fi
echo ""

# Counts
SPEC_COUNT=$(find "$DOCS/specs" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
ADR_COUNT=$(find "$DOCS/decisions" -name "[0-9]*.md" 2>/dev/null | wc -l | tr -d ' ')
ARCHIVE_COUNT=$(find "$DOCS/changes/archive" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
echo "Totals: $SPEC_COUNT specs | $ADR_COUNT decisions | $ARCHIVE_COUNT archived"
