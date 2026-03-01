---
name: sw-new-decision
description: >
  Create an Architecture Decision Record (ADR) for a significant technical
  choice. Use when choosing between viable approaches, adding/removing a
  dependency, changing a pattern or convention, or any decision worth
  explaining to someone reading the codebase in 2 years. Trigger on "should
  we use X or Y", "I decided to", "why did we choose", "record a decision",
  "ADR", "architecture decision", "trade-off", or when a design reveals a
  non-trivial choice.
---

# New Decision (ADR) Workflow

ADRs capture the WHY behind architectural choices.

## Steps

1. **Get a decision title.** Present-tense imperative:
   "Use PostgreSQL for event storage" not "We decided to use PostgreSQL".

2. **Run the script:**
   ```bash
   bash .specwright/scripts/new-decision.sh "<decision-title>"
   ```
   Auto-numbers and updates DECISION-LOG.md.

3. **Read context:**
   - `blueprint/decisions/DECISION-LOG.md` — related decisions
   - `blueprint/principles/PRINCIPLES.md` — relevant principles
   - Any active change or spike that prompted this

4. **Fill in the ADR:**

   a. **Context** — Narrative. Forces at play. Practical realities (solo dev,
      time pressure, budget). What you DON'T know.

   b. **Options** — At least 2 with genuine pros/cons. Don't strawman rejects.

   c. **Decision** — Which option and reasoning weighing tradeoffs.

   d. **Confidence** — High/Medium/Low with explanation.

   e. **Consequences** — What it enables, costs, and risks.

   f. **Review Trigger** — Specific conditions, not "in 6 months".

   g. **Related** — Cross-reference specs, ADRs, code, spikes.

5. **Update status** from Proposed to Accepted when confirmed.

## Writing principles

- Write as a conversation with a future developer (or model)
- "Solo developer with limited time" is valid context
- One decision per ADR
- ADRs are append-only — supersede, don't edit
