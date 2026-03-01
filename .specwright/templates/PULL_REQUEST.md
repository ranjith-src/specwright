<!-- DO NOT EDIT: Managed by Specwright. Bypass: SPECWRIGHT_UNLOCK=1 -->

# Pull Request / Merge Request Template

> Used by /sw-pr to generate PR/MR descriptions from change artifacts.

## Generated Description Format

```markdown
## Problem
<!-- From proposal.md -->

[Problem statement]

## Approach
<!-- From design.md -->

[Technical approach, key design choices]

## Test Coverage
<!-- From tests.md -->

- [Test groups and what they prove]
- Edge cases covered: [list]

## Changes
<!-- From tasks.md + git diff --stat -->

| Area | Files | What Changed |
|------|-------|--------------|
| [component] | N files | [summary] |

## Decisions
<!-- Links to ADRs created during this change -->

- ADR-NNNN: [title] — [one-line summary]

## Review Notes
<!-- From review.md -->

**Areas to scrutinise:**
- [What you're least confident about]
- [Known tradeoffs or shortcuts]

**Deviations from design:**
- [Where implementation diverged and why]

## Checklist
- [ ] All tests pass
- [ ] Specs updated (blueprint/specs/)
- [ ] No unrelated changes included
- [ ] Commit messages follow conventions
- [ ] review.md filled in
```

## Notes

- Lead with WHY (the problem), not WHAT (the diff)
- Link to specs and ADRs so reviewers see the full picture
- Flag uncertainty — most valuable thing for reviewers
- For spikes: use findings.md instead, mark as Draft/WIP
