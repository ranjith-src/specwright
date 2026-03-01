---
name: sw-commit
description: >
  Stage, commit, and push changes with conventional commit messages generated
  from change context. The agent determines what changed, drafts the commit
  message, and the user confirms before push. Use after implementing code,
  completing a TDD cycle, or whenever it's time to commit. Trigger on
  "commit", "push", "save my work", "commit and push", "push to remote",
  "stage changes", or when implementation of a task is done.
---

<!-- DO NOT EDIT: Managed by Specwright. Changes will be rejected by pre-commit hook. -->
<!-- To update, modify the source repo and reinstall. Bypass: SPECWRIGHT_UNLOCK=1 -->

# Commit Workflow

You figure out what changed, draft the message, push after confirmation.

## Steps

1. **Check what's changed:**
   ```bash
   git status
   git diff --stat
   ```

2. **Identify the active change** (if any):
   - Check `blueprint/changes/active/` for current work
   - Read proposal.md and tasks.md for context

3. **Determine commit type, scope, and message:**
   - New feature code → `feat(<change-name>): <what>`
   - Bug fix → `fix(<component>): <what>`
   - Test additions → `test(<change-name>): <what>`
   - Spec/doc updates → `docs(<change-name>): <what>`
   - Refactoring → `refactor(<component>): <what>`
   - Reference the convention in `.specwright/templates/COMMIT_MSG.md`

4. **Present the commit for confirmation:**
   Show the user: files to be staged, proposed commit message, branch,
   and remote. Wait for approval before executing.

5. **Stage, commit, push:**
   ```bash
   git add <relevant-files>
   git commit -m "<message>"
   git push origin <branch>
   ```

## Commit granularity

Commit per logical unit, not per file:
- `test(phone-auth): add SMS validation test cases` (red phase)
- `feat(phone-auth): implement SMS validation` (green phase)
- `refactor(phone-auth): extract rate limiter` (refactor phase)

## Branch naming

Create or switch to a branch matching the change:
- `feat/<change-name>` for changes
- `spike/<spike-name>` for spikes
- `fix/<change-name>` for bug fixes

## For quick fixes (no active change)

Still use conventional commits:
```bash
git add <files>
git commit -m "fix(auth): handle null token in middleware"
git push origin <branch>
```

## Roles

**Human:** confirm the commit message and push.
**Agent:** determine what changed, draft message, stage, commit, push.
