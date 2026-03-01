---
name: sw-new-spike
description: >
  Start an exploratory spike from user intent. The user describes what they
  want to learn, the agent sets up the spike and conducts the exploration,
  then presents findings for review. Use when the problem isn't well
  understood, evaluating a technology, prototyping, or investigating before
  committing to a full change. Trigger on "explore", "investigate", "evaluate",
  "prototype", "spike", "try out", "would X work for", "compare approaches",
  or any request where scope is unclear and exploration is needed first.
---

<!-- DO NOT EDIT: Managed by Specwright. Changes will be rejected by pre-commit hook. -->
<!-- To update, modify the source repo and reinstall. Bypass: SPECWRIGHT_UNLOCK=1 -->

# Spike Workflow

The user asks a question. You explore. They review findings.

## Steps

1. **Capture the question.** What does the user want to learn? If unclear,
   ask — a specific question gets a useful spike.

2. **Derive a spike name** and suggest a timebox:
   "Would Redis work for our session cache?" → `redis-session-cache`, 2 hours

3. **Run the script:**
   ```bash
   bash .specwright/scripts/new-spike.sh <spike-name>
   ```

4. **Draft spike.md:** Frame the user's question, propose an exploration
   approach, set the timebox, define success criteria. Present for quick
   confirmation before exploring.

5. **Explore.** No proposals, no tests, no design docs. Write throwaway code.
   Run benchmarks. Test integrations. Work freely within the timebox.

6. **Draft findings.md when done:**
   - Direct answer to the question
   - Evidence (data, benchmarks, observations)
   - Your recommendation: full change, ADR only, or drop it

7. **Present findings for review.** Let the user decide the next step:
   - Worth building? → `/sw-new-change`
   - Architectural learning? → `/sw-new-decision`
   - Dead end? → `/sw-archive`

## Roles

**Human:** ask the question, review findings, decide next step.
**Agent:** set up spike, explore, gather evidence, recommend.

## Key principle

The only deliverable is `findings.md`. If a spike doesn't produce findings,
it was wasted time. If it does, it saved building the wrong thing.
