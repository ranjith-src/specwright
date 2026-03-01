---
name: sw-new-decision
description: >
  Create an Architecture Decision Record (ADR) from user context. The user
  describes the choice they're facing, the agent researches options, drafts
  the ADR with pros/cons/recommendation, and the user reviews and decides.
  Use when choosing between viable approaches, adding/removing a dependency,
  changing a pattern or convention, or any decision worth explaining in 2
  years. Trigger on "should we use X or Y", "I decided to", "why did we
  choose", "record a decision", "ADR", "architecture decision", "trade-off",
  or when a design reveals a non-trivial choice.
---

<!-- DO NOT EDIT: Managed by Specwright. Changes will be rejected by pre-commit hook. -->
<!-- To update, modify the source repo and reinstall. Bypass: SPECWRIGHT_UNLOCK=1 -->

# New Decision (ADR) Workflow

The user describes a choice. You research, draft, recommend. They decide.

## Steps

1. **Capture the decision context.** What choice is the user facing? What
   constraints matter? If unclear, ask — but often the user's initial
   statement contains enough to start.

2. **Derive a decision title.** Present-tense imperative:
   "Use PostgreSQL for event storage" not "We decided to use PostgreSQL".

3. **Run the script:**
   ```bash
   bash .specwright/scripts/new-decision.sh "<decision-title>"
   ```

4. **Read existing context:**
   - `blueprint/decisions/DECISION-LOG.md` — related past decisions
   - `blueprint/principles/PRINCIPLES.md` — relevant principles
   - `blueprint/specs/` — affected specs
   - Any active change or spike that prompted this

5. **Draft the ADR:**

   a. **Context** — Narrative from the user's description. Include forces at
      play, practical realities (solo dev, time, budget), and what's unknown.

   b. **Options** — Research at least 2 genuine options with honest pros/cons.
      Don't strawman the alternatives. If you need to search or investigate
      to give fair treatment, do so.

   c. **Decision** — Your recommendation with reasoning. Make it clear this
      is a recommendation the user can override.

   d. **Confidence** — High/Medium/Low with explanation.

   e. **Consequences** — What it enables, costs, and risks.

   f. **Review Trigger** — Specific conditions to revisit.

   g. **Related** — Cross-references to specs, ADRs, code, spikes.

6. **Present for review.** Summarise the options and your recommendation.
   The user makes the final call — update the ADR with their decision and
   change status from Proposed to Accepted.

## Roles

**Human:** describe the choice, review options, make the decision.
**Agent:** research options, draft ADR, recommend, update status.

## Writing principles

- Write as a conversation with a future developer (or model)
- "Solo developer with limited time" is valid context
- One decision per ADR
- ADRs are append-only — supersede, don't edit
