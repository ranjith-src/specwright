#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-.}"

echo "=== Specwright Installer ==="
echo "Target: $(cd "$TARGET_DIR" && pwd)"
echo ""

# --- .github/skills/ ---
echo "Installing skills..."
mkdir -p "$TARGET_DIR/.github/skills"
for skill in "$SCRIPT_DIR"/.github/skills/sw-*/; do
  name=$(basename "$skill")
  mkdir -p "$TARGET_DIR/.github/skills/$name"
  cp "$skill/SKILL.md" "$TARGET_DIR/.github/skills/$name/SKILL.md"
done
SKILL_COUNT=$(find "$TARGET_DIR/.github/skills" -name SKILL.md 2>/dev/null | wc -l | tr -d ' ')
echo "  ✓ .github/skills/ ($SKILL_COUNT skills)"

# --- .specwright/ ---
echo "Installing .specwright/..."

mkdir -p "$TARGET_DIR/.specwright/scripts"
cp "$SCRIPT_DIR/.specwright/scripts/"*.sh "$TARGET_DIR/.specwright/scripts/"
chmod +x "$TARGET_DIR/.specwright/scripts/"*.sh
echo "  ✓ .specwright/scripts/"

mkdir -p "$TARGET_DIR/.specwright/templates/"{change,spike,decision}
cp "$SCRIPT_DIR/.specwright/templates/change/"* "$TARGET_DIR/.specwright/templates/change/"
cp "$SCRIPT_DIR/.specwright/templates/spike/"* "$TARGET_DIR/.specwright/templates/spike/"
cp "$SCRIPT_DIR/.specwright/templates/decision/"* "$TARGET_DIR/.specwright/templates/decision/"
cp "$SCRIPT_DIR/.specwright/templates/spec.md" "$TARGET_DIR/.specwright/templates/"
cp "$SCRIPT_DIR/.specwright/templates/COMMIT_MSG.md" "$TARGET_DIR/.specwright/templates/"
cp "$SCRIPT_DIR/.specwright/templates/PULL_REQUEST.md" "$TARGET_DIR/.specwright/templates/"
echo "  ✓ .specwright/templates/"

# --- blueprint/ ---
echo "Initialising blueprint/..."
mkdir -p "$TARGET_DIR/blueprint"/{specs,decisions,changes/{active,spikes,archive},principles}

create_if_missing() {
  local file="$1" label="$2"
  if [ ! -f "$file" ]; then
    cat > "$file"
    echo "  ✓ $label (new)"
  else
    echo "  · $label (exists, skipped)"
  fi
}

create_if_missing "$TARGET_DIR/blueprint/PROJECT.md" "blueprint/PROJECT.md" << 'HEREDOC'
# [Project Name] — Project Context

## What Is This?
[2-3 sentences. What does this project do? Who is it for?]

## Current State
- [what works]
- [what's in progress]

## Tech Stack
- [language, framework, infrastructure — with versions]

## Architecture Invariants
- [rules that must NEVER be broken]

## Team & Context
- [solo dev / team size / time constraints]

## Key Entry Points
- Specs: blueprint/specs/spec.md
- Decisions: blueprint/decisions/DECISION-LOG.md
- Principles: blueprint/principles/PRINCIPLES.md
- Active work: blueprint/changes/active/
HEREDOC

create_if_missing "$TARGET_DIR/blueprint/specs/spec.md" "blueprint/specs/spec.md" << 'HEREDOC'
# System Specification

## Overview
[What does this system do, end to end?]

## Capabilities
[List capabilities with links to detailed specs]

## Cross-Cutting Concerns
- Authentication: [approach]
- Error handling: [approach]
- Logging: [approach]

## Change History
| Date | Change | Delta |
|------|--------|-------|
HEREDOC

create_if_missing "$TARGET_DIR/blueprint/decisions/DECISION-LOG.md" "blueprint/decisions/DECISION-LOG.md" << 'HEREDOC'
# Decision Log

| # | Date | Title | Status | Confidence |
|---|------|-------|--------|------------|
HEREDOC

create_if_missing "$TARGET_DIR/blueprint/principles/PRINCIPLES.md" "blueprint/principles/PRINCIPLES.md" << 'HEREDOC'
# Engineering Principles

These are the load-bearing beliefs of this project. They change rarely.
When they do change, it gets an ADR.

## P1: Tests Prove Specs
A spec without a corresponding test is an aspiration, not a requirement.
Tests are written before implementation (TDD).

## P2: Decisions Are Documented
Any architectural choice gets an ADR. "We'll remember why" is not a strategy.

## P3: Small, Reviewable Changes
Each change should be completable in a focused session.
If it can't be, break it down further.

## P4: Future-Reader Friendly
All documentation is written assuming the reader has never seen
the codebase. Avoid jargon without definition. Cross-reference liberally.
HEREDOC

create_if_missing "$TARGET_DIR/blueprint/principles/CONVENTIONS.md" "blueprint/principles/CONVENTIONS.md" << 'HEREDOC'
# Conventions

## Commits
Conventional commits: feat:, fix:, docs:, refactor:, test:
Reference ADRs when relevant: "feat: add caching (see ADR-0012)"

## Naming
- Specs: spec-[feature-name].md (kebab-case)
- ADRs: NNNN-[decision-name].md (numbered, kebab-case)
- Tests: test_[behaviour]_[expected_outcome]
- Changes: [feature-name]/ (kebab-case)
- Branches: [type]/[change-name] (e.g. feat/add-user-auth, spike/evaluate-redis)

## Code Style
[Add project-specific conventions here]
HEREDOC

create_if_missing "$TARGET_DIR/blueprint/principles/CONSTRAINTS.md" "blueprint/principles/CONSTRAINTS.md" << 'HEREDOC'
# Constraints

Hard technical limits that constrain all design decisions.

## Performance
- [e.g. API responses must be < 200ms at p99]

## Security
- [e.g. all user input must be sanitised]

## Compatibility
- [e.g. must support Node 20+]

## Infrastructure
- [e.g. single-region deployment only]
HEREDOC

# .gitignore additions
if [ -f "$TARGET_DIR/.gitignore" ]; then
  if ! grep -q "specwright" "$TARGET_DIR/.gitignore" 2>/dev/null; then
    echo "" >> "$TARGET_DIR/.gitignore"
    echo "# Specwright scratch files" >> "$TARGET_DIR/.gitignore"
    echo "blueprint/changes/active/*/scratch/" >> "$TARGET_DIR/.gitignore"
    echo "  ✓ .gitignore updated"
  fi
fi

echo ""
echo "=== Specwright installed ==="
echo ""
echo "Installed:"
echo "  .github/skills/  → agent skills (slash commands)"
echo "  .specwright/      → framework tooling (templates, scripts)"
echo "  blueprint/        → project documentation (specs, decisions, changes)"
echo ""
echo "Next steps:"
echo "  1. Edit blueprint/PROJECT.md with your project context"
echo "  2. Edit blueprint/principles/PRINCIPLES.md with your beliefs"
echo "  3. Start working:"
echo "     /sw-new-change    — start a feature"
echo "     /sw-new-spike     — explore something"
echo "     /sw-new-decision  — record a decision"
echo "     /sw-commit        — commit and push"
echo "     /sw-pr            — create a PR/MR"
echo "  4. git add . && git commit -m 'chore: add specwright framework'"
