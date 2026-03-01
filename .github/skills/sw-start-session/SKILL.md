---
name: sw-start-session
description: >
  Load project context at the start of a coding session. Reads PROJECT.md,
  active changes, principles, and recent decisions to orient. Use at the
  beginning of any session, when switching to this project, or when the
  agent lacks context. Trigger on "start session", "context", "orient me",
  "catch me up", or starting a new conversation about the project.
---

# Start Session

Load context for a productive coding session.

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

6. **Summarise** for the user:
   - What the project is
   - What's in progress
   - What needs attention (expired spikes, proposed ADRs, unchecked tasks)
   - Suggested next action

This skill is about orientation, not action. Don't start implementing.
