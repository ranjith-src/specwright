---
name: sw-new-spike
description: >
  Start an exploratory spike with a timebox. Use when the problem isn't well
  understood, evaluating a technology, prototyping, or investigating before
  committing to a full change. Trigger on "explore", "investigate", "evaluate",
  "prototype", "spike", "try out", "would X work for", "compare approaches",
  or any request where scope is unclear and exploration is needed first.
---

# Spike Workflow

Timeboxed exploration. No ceremony — question, timebox, findings.

## Steps

1. **Get a spike name and timebox.**
   "evaluate redis for caching" → `evaluate-redis-caching`

2. **Run the script:**
   ```bash
   bash .specwright/scripts/new-spike.sh <spike-name>
   ```

3. **Fill in spike.md:** Question, approach, timebox, success criteria.

4. **Explore freely.** No proposals, no tests, no design docs. Write throwaway code.

5. **When done or timebox expires, fill in findings.md:**
   - Direct answer to the question
   - Evidence (data, benchmarks, observations)
   - Recommendation: full change, ADR only, or drop it

6. **Next steps:**
   - Worth building? → `/sw-new-change`
   - Architectural learning? → `/sw-new-decision`
   - Dead end? → `/sw-archive`

## Key principle

The only deliverable is `findings.md`. If a spike doesn't produce findings,
it was wasted time. If it does, it saved building the wrong thing.
