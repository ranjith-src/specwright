---
name: sw-archive
description: >
  Archive a completed change or spike. The agent handles review creation,
  spec updates, and archiving. The user confirms completion. Use when
  implementation is done, tests pass, PR is merged, and it's time to close
  out. Trigger on "done with", "finish", "close out", "archive", "complete",
  "wrap up", or when all tasks are done.
---

<!-- DO NOT EDIT: Managed by Specwright. Changes will be rejected by pre-commit hook. -->
<!-- To update, modify the source repo and reinstall. Bypass: SPECWRIGHT_UNLOCK=1 -->

# Archive Workflow

The user says it's done. You handle the paperwork.

## For Changes

1. **Verify completion:**
   - All tasks in tasks.md checked off?
   - All tests pass?
   - PR/MR merged?
   If not, tell the user what's remaining.

2. **Draft review.md** (personal retrospective):
   - What went well / what was hard (infer from the change history)
   - Deviations from design (diff design.md against what was built)
   - Lessons for future changes
   Present for quick review.

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

1. **Check that findings.md is filled in.** If not, draft it from the
   exploration work and present for review.

2. **Archive:**
   ```bash
   bash .specwright/scripts/archive-spike.sh <spike-name>
   ```

3. **Suggest next step** based on findings:
   - Proceed → `/sw-new-change`
   - Record learning → `/sw-new-decision`
   - Drop → done

## Roles

**Human:** confirm it's done, review retrospective.
**Agent:** draft review, update specs, archive, commit.

## Important

Never archive without updating specs. Stale specs are worse than no specs.
