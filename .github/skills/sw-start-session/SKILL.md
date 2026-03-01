---
name: sw-start-session
description: >
  Load project context at the start of a coding session. Reads PROJECT.md,
  active changes, principles, and recent decisions, then briefs the user on
  current state and suggests what to work on. Use at the beginning of any
  session, when switching to this project, or when the agent lacks context.
  Trigger on "start session", "context", "orient me", "catch me up", or
  starting a new conversation about the project.
---

<!-- DO NOT EDIT: Managed by Specwright. Changes will be rejected by pre-commit hook. -->
<!-- To update, modify the source repo and reinstall. Bypass: SPECWRIGHT_UNLOCK=1 -->

# Start Session

You load context and brief the user. They decide what to work on.

## Steps

1. **Read project context:** `blueprint/PROJECT.md`

2. **Read principles:** `blueprint/principles/PRINCIPLES.md` and `CONSTRAINTS.md`

3. **Check status:**
   ```bash
   bash .specwright/scripts/status.sh
   ```

4. **If active changes exist**, read their artifacts:
   - `blueprint/changes/active/*/proposal.md` — what's in flight
   - `blueprint/changes/active/*/tasks.md` — what's done and remaining

5. **If active spikes exist**, check timebox expiry.

6. **Brief the user:**
   - What the project is (one line)
   - What's currently in progress (active changes, spikes)
   - What needs attention (expired spikes, proposed ADRs, unchecked tasks)
   - Suggested next action

## Roles

**Human:** decide what to work on.
**Agent:** load context, summarise state, suggest next action.

This skill is about orientation, not action. Don't start implementing.

## Framework Integrity

Files in `.specwright/` and `.github/skills/sw-*/` are protected. Do NOT
modify, overwrite, rewrite, or "improve" any file in these directories.
This includes templates, scripts, hooks, and SKILL.md files. They are
managed by the Specwright framework and enforced by a pre-commit hook.

If a template or skill seems wrong, tell the user — don't fix it yourself.
