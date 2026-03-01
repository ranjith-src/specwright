#!/bin/bash
set -euo pipefail

# Specwright remote installer
# Usage: curl -fsSL https://raw.githubusercontent.com/ranjith-src/specwright/main/remote-install.sh | bash
# Or:    curl -fsSL https://raw.githubusercontent.com/ranjith-src/specwright/main/remote-install.sh | bash -s /path/to/project

TARGET_DIR="${1:-.}"
TMP_DIR=$(mktemp -d)
REPO_URL="https://github.com/ranjith-src/specwright/archive/refs/heads/main.tar.gz"

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo "Downloading Specwright..."
curl -fsSL "$REPO_URL" | tar xz -C "$TMP_DIR"

# GitHub tarballs extract to repo-branch/ directory
EXTRACTED=$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -1)

if [ -z "$EXTRACTED" ] || [ ! -f "$EXTRACTED/install.sh" ]; then
  echo "Error: Failed to download Specwright. Check the repository URL."
  exit 1
fi

bash "$EXTRACTED/install.sh" "$TARGET_DIR"
