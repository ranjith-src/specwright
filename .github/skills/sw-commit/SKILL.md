---
name: sw-commit
description: >
  Stage, commit, and push changes with conventional commit messages. Generates
  commit messages from change context (proposal, tasks, design). Use after
  implementing code, after completing a TDD cycle, or whenever it's time to
  commit. Trigger on "commit", "push", "save my work", "commit and push",
  "push to remote", "stage changes", or when implementation of a task is done.
  Ensures consistent commit history across the project.
---

# Commit Workflow

Creates consistent conventional commits from change context.

## Commit Convention

```
<type>(<scope>): <description>

[body]

[footer]
```

**Types:** feat, fix, docs, refactor, test, chore, perf, ci, build, style
**Scope:** component or change name (optional but encouraged)
**Footer:** reference ADRs, issues, breaking changes

## Steps

1. **Check what's changed:**
   ```bash
   git status
   git diff --stat
   ```

2. **Identify the active change** (if any):
   - Check `blueprint/changes/active/` for current work
   - Read proposal.md and tasks.md for context

3. **Determine commit type and scope:**
   - New feature code → `feat(<change-name>)`
   - Bug fix → `fix(<component>)`
   - Test additions → `test(<change-name>)`
   - Spec/doc updates → `docs(<change-name>)`
   - Refactoring → `refactor(<component>)`

4. **Generate the commit message** following
   `.specwright/templates/COMMIT_MSG.md`:

   ```bash
   git add <relevant-files>
   git commit -m "feat(add-user-auth): implement JWT token validation

   Validates tokens against RS256 public key.
   Returns 401 for expired or malformed tokens.

   Part of: add-user-auth
   See: ADR-0003"
   ```

5. **Push to remote:**
   ```bash
   git push origin <branch>
   ```

## Commit granularity

Commit per logical unit, not per file. Good commits:
- `test(add-user-auth): add JWT validation test cases` (red phase)
- `feat(add-user-auth): implement JWT validation` (green phase)
- `refactor(add-user-auth): extract token parser` (refactor phase)

## Branch naming

- `feat/<change-name>` for changes
- `spike/<spike-name>` for spikes
- `fix/<change-name>` for bug fixes

## For quick fixes (no active change)

```bash
git add <files>
git commit -m "fix(auth): handle null token in middleware"
git push origin <branch>
```

## Platform detection

```bash
git remote get-url origin 2>/dev/null
```
- Contains `github.com` → GitHub
- Contains `gitlab` → GitLab
- Neither → generic git
