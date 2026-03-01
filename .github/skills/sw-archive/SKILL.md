---
name: sw-archive
description: >
  Archive a completed change or spike. Handles review creation, spec updates,
  and moving to archive. Use when implementation is done, tests pass, PR is
  merged, and it's time to close out. Trigger on "done with", "finish",
  "close out", "archive", "complete", "wrap up", or when all tasks are done.
---

# Archive Workflow

Closes a change or spike and ensures specs stay current.

## For Changes

1. **Check completion:**
   - All tasks in tasks.md checked off?
   - All tests pass?
   - PR/MR merged?

2. **Fill in review.md** (personal retrospective, not code review):
   - What went well / what was hard
   - Deviations from design (and why)
   - Lessons for future changes

3. **Update source-of-truth specs:**
   - Find affected specs in `blueprint/specs/`
   - Update behaviours, scenarios, test mapping tables
   - Add entry to spec's Change History table

4. **Run the archive script:**
   ```bash
   bash .specwright/scripts/archive-change.sh <change-name>
   ```

5. **Commit:** `git commit -m "docs: archive <change-name>"`

## For Spikes

1. **Ensure findings.md is filled in.**

2. **Archive:**
   ```bash
   bash .specwright/scripts/archive-spike.sh <spike-name>
   ```

3. **Follow up:** proceed → `/sw-new-change`, learning → `/sw-new-decision`, drop → done.

## Important

Never archive without updating specs. Stale specs are worse than no specs.
