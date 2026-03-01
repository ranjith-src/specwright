---
name: sw-pr
description: >
  Create a Pull Request (GitHub) or Merge Request (GitLab) with a description
  generated from Specwright change artifacts. The PR/MR body includes the
  problem statement, design approach, test coverage, and related decisions —
  giving reviewers full context without leaving the PR. Use after committing
  and pushing, when code is ready for review. Trigger on "create PR", "open
  PR", "pull request", "merge request", "MR", "ready for review", "push and
  create PR", "submit for review", or when implementation and review.md are
  complete. Works with both GitHub and GitLab.
---

# PR/MR Workflow

Creates a Pull Request or Merge Request with description assembled from
your change artifacts. Reviewers get full context in the PR itself.

## Steps

1. **Detect platform:**
   ```bash
   REMOTE=$(git remote get-url origin 2>/dev/null || echo "")
   ```
   - Contains `github.com` → GitHub (uses `gh` CLI)
   - Contains `gitlab` → GitLab (uses `glab` CLI)
   - If CLI not available, generate description for manual creation

2. **Identify the active change:**
   - Check `blueprint/changes/active/` for the current change
   - If multiple active, ask the user which one

3. **Read change artifacts** to build description:
   - `proposal.md` → Problem statement and scope
   - `design.md` → Technical approach
   - `tests.md` → Test coverage summary
   - `tasks.md` → Completion status
   - `review.md` → Self-review notes (if filled in)
   - Related ADRs from `blueprint/decisions/`

4. **Generate PR/MR title:**
   Format: `<type>(<scope>): <description>`
   Example: `feat(auth): add JWT-based user authentication`

5. **Generate PR/MR description** following
   `.specwright/templates/PULL_REQUEST.md`:

   ```markdown
   ## Problem
   [From proposal.md — what and why]

   ## Approach
   [From design.md — how, key design choices]

   ## Test Coverage
   [From tests.md — what's tested, edge cases covered]

   ## Changes
   [From tasks.md + git diff --stat — files changed summary]

   ## Decisions
   [Links to any ADRs created during this change]

   ## Review Notes
   [From review.md — known tradeoffs, areas to scrutinise]

   ## Checklist
   - [ ] Tests pass
   - [ ] Specs updated
   - [ ] No unrelated changes
   ```

6. **Create the PR/MR:**

   **GitHub:**
   ```bash
   gh pr create \
     --title "<title>" \
     --body "<generated-description>" \
     --base main \
     --head <current-branch>
   ```

   **GitLab:**
   ```bash
   glab mr create \
     --title "<title>" \
     --description "<generated-description>" \
     --target-branch main \
     --source-branch <current-branch>
   ```

   **Neither CLI available:**
   Output title and description for copy-paste. Provide URL:
   - GitHub: `https://github.com/<owner>/<repo>/compare/<branch>?expand=1`
   - GitLab: `https://gitlab.com/<owner>/<repo>/-/merge_requests/new`

7. **Report back** with the PR/MR URL.

## For spikes

- Title: `spike(<name>): <question from spike.md>`
- Body: findings.md content
- Mark as Draft/WIP

## For quick fixes (no change artifacts)

Generate minimal description from commit history:
```bash
git log main..HEAD --oneline
```
Follow the template but mark sections as "N/A — quick fix".

## Tips

- Lead with WHY (the problem), not WHAT (the diff)
- Link to specs and ADRs
- Flag what you're NOT confident about — most valuable thing for reviewers
