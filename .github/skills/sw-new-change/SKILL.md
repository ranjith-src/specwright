---
name: sw-new-change
description: >
  Create a new spec-driven change from user intent. The user describes what
  they want, the agent drafts all artifacts (proposal, tests, design, tasks),
  and the user reviews before implementation begins. Use when starting a
  feature, fix, refactor, or any structured development work where scope is
  understood enough to define acceptance criteria. Trigger on "new feature",
  "add support for", "implement", "refactor", "build", "create a change",
  "I want to", or any request to start structured work. Do NOT use for
  exploration — use sw-new-spike instead.
---

<!-- DO NOT EDIT: Managed by Specwright. Changes will be rejected by pre-commit hook. -->
<!-- To update, modify the source repo and reinstall. Bypass: SPECWRIGHT_UNLOCK=1 -->

# New Change Workflow

The user provides intent. You draft everything. They review. You implement.

## Steps

1. **Capture intent.** Ask the user to describe what they want if not already
   clear. A sentence or two is enough — you'll do the rest.

2. **Derive a change name** (kebab-case) from the intent:
   "I want users to authenticate with phone numbers" → `phone-auth`

3. **Run the scaffolding script:**
   ```bash
   bash .specwright/scripts/new-change.sh <change-name>
   ```

4. **Read existing context** to draft informed artifacts:
   - `blueprint/specs/` — related specs (understand current system)
   - `blueprint/decisions/DECISION-LOG.md` — past decisions (don't contradict)
   - `blueprint/principles/PRINCIPLES.md` — constraints (stay within bounds)
   - `blueprint/principles/CONSTRAINTS.md` — hard limits

5. **Draft all artifacts from the user's intent:**

   a. **proposal.md** (WHY) — Translate the user's intent into a problem
      statement, proposed change, impact assessment, and explicit out-of-scope.
   
   b. **tests.md** (WHAT) — Define test cases BEFORE implementation. Each test:
      what it asserts, setup, expected outcome, file path. Cover happy path,
      edge cases, and error cases.
   
   c. **design.md** (HOW) — Technical approach, files to change, alternatives
      considered. If a choice between alternatives is significant, flag it and
      suggest creating an ADR with `/sw-new-decision`.
   
   d. **tasks.md** (STEPS) — Implementation checklist in TDD order:
      Phase 1: Tests (Red), Phase 2: Implement (Green),
      Phase 3: Refactor, Phase 4: Close out.

6. **Present for review.** Summarise what you've drafted. Highlight assumptions
   and areas needing input. Do NOT proceed to implementation until the user
   approves.

7. **Commit artifacts** after approval:
   ```
   git add blueprint/changes/active/<change-name>/
   git commit -m "docs: create change <change-name>"
   ```

8. **Implement using TDD:**
   - Write tests from tests.md → confirm they FAIL
   - Implement → confirm they PASS
   - Refactor → confirm tests still PASS

9. **When done:** draft review.md (retrospective), then `/sw-commit` and `/sw-pr`.

## Roles

**Human:** intent, review, approve.
**Agent:** read context, draft artifacts, flag assumptions, implement, commit, PR.

## When NOT to use

- Problem not understood → `/sw-new-spike` first
- < 30 min obvious fix → just fix, test, `/sw-commit`
- Choosing between approaches → `/sw-new-decision`
