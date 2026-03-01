---
name: sw-pr
description: >
  Create a Pull Request (GitHub) or Merge Request (GitLab) with a description
  generated from change artifacts. The agent assembles the PR body from
  proposal, design, tests, and review artifacts, and the user confirms before
  creation. Use after committing and pushing, when code is ready for review.
  Trigger on "create PR", "open PR", "pull request", "merge request", "MR",
  "ready for review", "push and create PR", "submit for review", or when
  implementation and review.md are complete. Works with GitHub and GitLab.
---

<!-- DO NOT EDIT: Managed by Specwright. Changes will be rejected by pre-commit hook. -->
<!-- To update, modify the source repo and reinstall. Bypass: SPECWRIGHT_UNLOCK=1 -->

# PR/MR Workflow

You assemble the PR from change artifacts. The user confirms before creation.

## Steps

1. **Detect platform:**
   ```bash
   REMOTE=$(git remote get-url origin 2>/dev/null || echo "")
   ```
   - Contains `github.com` → GitHub (`gh` CLI)
   - Contains `gitlab` → GitLab (`glab` CLI)
   - Neither available → generate description for manual copy-paste

2. **Identify the active change:**
   - Check `blueprint/changes/active/`
   - If multiple, ask the user which one

3. **Read change artifacts** to assemble description:
   - `proposal.md` → Problem statement and scope
   - `design.md` → Technical approach
   - `tests.md` → Test coverage summary
   - `tasks.md` → Completion status
   - `review.md` → Self-review notes, areas to scrutinise
   - Related ADRs from `blueprint/decisions/`
   - Reference template: `.specwright/templates/PULL_REQUEST.md`

4. **Draft PR/MR title and description:**
   Title: `<type>(<scope>): <description>`
   Body: problem, approach, test coverage, changes, decisions, review notes,
   checklist — all assembled from the artifacts.

5. **Present for confirmation.** Show the user the title, description, base
   branch, and head branch. Wait for approval.

6. **Create the PR/MR:**

   **GitHub:**
   ```bash
   gh pr create \
     --title "<title>" \
     --body "<description>" \
     --base main \
     --head <current-branch>
   ```

   **GitLab:**
   ```bash
   glab mr create \
     --title "<title>" \
     --description "<description>" \
     --target-branch main \
     --source-branch <current-branch>
   ```

   **Neither CLI available:**
   Output title and description for copy-paste. Provide URL:
   - GitHub: `https://github.com/<owner>/<repo>/compare/<branch>?expand=1`
   - GitLab: `https://gitlab.com/<owner>/<repo>/-/merge_requests/new`

7. **Report back** with the PR/MR URL.

## For spikes

- Title: `spike(<name>): <question>`
- Body: findings.md content
- Mark as Draft/WIP

## For quick fixes (no change artifacts)

Generate from commit history: `git log main..HEAD --oneline`
Follow template but mark sections as "N/A — quick fix".

## Roles

**Human:** confirm PR title/description, review the PR after creation.
**Agent:** assemble description from artifacts, create PR/MR, report URL.

## Tips for good PRs

- Lead with WHY (the problem), not WHAT (the diff)
- Link to specs and ADRs
- Flag what you're NOT confident about — most valuable for reviewers
