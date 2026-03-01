#!/bin/bash
# DO NOT EDIT: Managed by Specwright. Bypass: SPECWRIGHT_UNLOCK=1
set -euo pipefail

NAME="${1:?Usage: archive-spike.sh <spike-name>}"
SOURCE="blueprint/changes/spikes/$NAME"
DATE=$(date +%Y-%m-%d)
ARCHIVE="blueprint/changes/archive/${DATE}-spike-${NAME}"

if [ ! -d "$SOURCE" ]; then
  echo "Error: No spike at $SOURCE"
  exit 1
fi

mv "$SOURCE" "$ARCHIVE"
echo "Archived spike: $ARCHIVE"
