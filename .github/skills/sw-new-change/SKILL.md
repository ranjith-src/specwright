---
name: sw-new-change
description: >
  Create a new spec-driven change with proposal, tests, design, and task
  artifacts. Use when starting a feature, fix, refactor, or any structured
  development work where scope is understood enough to define acceptance
  criteria. Trigger on "new feature", "add support for", "implement",
  "refactor", "build", "create a change", or any request to start structured
  work. Do NOT use for exploration — use sw-new-spike instead.
---

# New Change Workflow

Creates a structured change delta for spec-driven development with TDD.

## Steps

1. **Get a change name** (kebab-case). Convert natural language:
   "add user authentication" → `add-user-auth`

2. **Run the scaffolding script:**
   ```bash
   bash .specwright/scripts/new-change.sh <change-name>
   ```

3. **Read context** before filling in artifacts:
   - `blueprint/specs/` — related specs
   - `blueprint/decisions/DECISION-LOG.md` — past decisions
   - `blueprint/principles/PRINCIPLES.md` — constraints

4. **Fill in artifacts in this order:**

   a. **proposal.md** (WHY) — Problem, proposed change, scope, out-of-scope.
   
   b. **tests.md** (WHAT) — Test cases BEFORE implementation. This is the
      TDD contract. Each test: what it asserts, setup, expected outcome, file path.
   
   c. **design.md** (HOW) — Technical approach, files to change, alternatives.
      If alternatives are significant → suggest `/sw-new-decision` for an ADR.
   
   d. **tasks.md** (STEPS) — TDD phases: Red (write tests) → Green (implement) → Refactor.

5. **Commit artifacts** before implementation:
   ```
   git add blueprint/changes/active/<change-name>/
   git commit -m "docs: create change <change-name>"
   ```

6. **Implement using TDD:**
   - Write tests from tests.md → confirm they FAIL
   - Implement → confirm they PASS
   - Refactor → confirm tests still PASS

7. **When done:** fill in review.md (retrospective), then `/sw-commit` and `/sw-pr`.

## When NOT to use

- Problem not understood → `/sw-new-spike` first
- < 30 min obvious fix → just fix, test, `/sw-commit`
- Choosing between approaches → `/sw-new-decision`
