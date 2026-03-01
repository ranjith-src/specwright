---
name: sw-status
description: >
  Show current Specwright status — active changes, spikes, recent decisions,
  and spec coverage. Use when checking project state, "what's in progress",
  "show active work", "project status", or at the start of a session.
---

# Status Check

```bash
bash .specwright/scripts/status.sh
```

Shows: active changes (with task progress), active spikes (with timebox),
recent decisions, and totals.

## Reading the output

- Active changes without review.md → still in progress
- Active changes with review.md → ready to archive
- Active spikes → check if timebox expired
- Proposed decisions → need to be accepted or rejected
