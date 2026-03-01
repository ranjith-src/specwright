# Specwright

**Spec-driven development with TDD, ADRs, and git workflow automation. Zero dependencies. Works with Claude Code, GitHub Copilot, Cursor, and any agent that supports Agent Skills.**

```
→ specs describe intent, tests prove behaviour, code implements both
→ decisions are first-class artifacts, not tribal knowledge
→ two tracks: full workflow for known problems, spikes for exploration
→ git workflow: consistent commits, PR/MR descriptions from your specs
→ zero dependencies — markdown + shell scripts + SKILL.md files
```

## Install

One command, nothing left behind:

```bash
curl -fsSL https://raw.githubusercontent.com/ranjith-src/specwright/main/remote-install.sh | bash
```

Or install into a specific directory:

```bash
curl -fsSL https://raw.githubusercontent.com/ranjith-src/specwright/main/remote-install.sh | bash -s /path/to/project
```

Downloads to `/tmp`, installs, cleans up. No cloned repo left in your project.

<details>
<summary>Alternative: clone and install manually</summary>

```bash
git clone https://github.com/ranjith-src/specwright.git /tmp/specwright
bash /tmp/specwright/install.sh
rm -rf /tmp/specwright
```
</details>

## What Gets Installed

Three directories, three concerns.

```
your-project/
├── .github/
│   └── skills/                        # Agent interface (slash commands)
│       ├── sw-new-change/SKILL.md     → start a feature/fix/refactor
│       ├── sw-new-spike/SKILL.md      → explore something unknown
│       ├── sw-new-decision/SKILL.md   → record an architectural choice
│       ├── sw-archive/SKILL.md        → close out completed work
│       ├── sw-status/SKILL.md         → check what's in progress
│       ├── sw-start-session/SKILL.md  → load context for a coding session
│       ├── sw-commit/SKILL.md         → stage, commit, push with conventions
│       └── sw-pr/SKILL.md             → create PR/MR from change artifacts
│
├── .specwright/                        # Framework tooling (removable)
│   ├── templates/                      # Templates for generated files
│   │   ├── change/
│   │   │   ├── proposal.md
│   │   │   ├── tests.md
│   │   │   ├── design.md
│   │   │   ├── tasks.md
│   │   │   └── review.md
│   │   ├── spike/
│   │   │   ├── spike.md
│   │   │   └── findings.md
│   │   ├── decision/
│   │   │   └── adr.md
│   │   ├── spec.md
│   │   ├── COMMIT_MSG.md
│   │   └── PULL_REQUEST.md
│   ├── scripts/                        # Shell automation
│   │   ├── new-change.sh
│   │   ├── new-spike.sh
│   │   ├── new-decision.sh
│   │   ├── archive-change.sh
│   │   ├── archive-spike.sh
│   │   └── status.sh
│   └── hooks/                          # Git hooks (installed to .git/hooks/)
│       ├── pre-commit                  # Protects framework files
│       ├── commit-msg                  # Enforces conventional commits
│       └── pre-push                    # Warns on stale specs
│
└── blueprint/                          # Living project documentation
    ├── PROJECT.md                      # (framework-independent, survives
    ├── specs/                          #  any tooling change)
    │   └── spec.md
    ├── decisions/
    │   └── DECISION-LOG.md
    ├── changes/
    │   ├── active/
    │   ├── spikes/
    │   └── archive/
    └── principles/
        ├── PRINCIPLES.md
        ├── CONVENTIONS.md
        └── CONSTRAINTS.md
```

Delete `.specwright/` and `.github/skills/sw-*/` and your project documentation survives intact.

## Usage

Type `/sw-` in your AI agent to see available commands:

| Skill | When to Use |
|-------|-------------|
| `/sw-new-change` | Starting a feature, fix, or refactor with known scope |
| `/sw-new-spike` | Exploring a technology, prototyping, investigating |
| `/sw-new-decision` | Recording an architectural choice |
| `/sw-archive` | Completing and archiving a change or spike |
| `/sw-status` | Checking what's active and pending |
| `/sw-start-session` | Beginning a coding session — loads context |
| `/sw-commit` | Staging, committing, pushing with conventional commits |
| `/sw-pr` | Creating a PR/MR with description generated from specs |

Or use shell scripts directly:

```bash
bash .specwright/scripts/new-change.sh add-user-auth
bash .specwright/scripts/new-spike.sh evaluate-redis
bash .specwright/scripts/new-decision.sh "use postgresql over dynamodb"
bash .specwright/scripts/status.sh
```

## The Full Flow

```
 ┌─────────────────────── Spec-Driven Development ──────────────────────┐
 │                                                                       │
 │  proposal.md → tests.md → design.md → tasks.md → [TDD] → review.md  │
 │    (WHY)        (WHAT)      (HOW)      (STEPS)   (CODE)   (RETRO)   │
 │                                                                       │
 └──────────────────────────────┬────────────────────────────────────────┘
                                │
                                ▼
 ┌──────────────────── Git Workflow ─────────────────────┐
 │                                                        │
 │  /sw-commit → conventional commit → push to remote    │
 │  /sw-pr     → PR/MR description from specs → review   │
 │                                                        │
 └────────────────────────┬───────────────────────────────┘
                          │
                          ▼
                    /sw-archive
                  (update specs, move to archive)
```

**review.md** is a personal retrospective. **Code review** happens in the PR/MR, where `/sw-pr` generates the description from your change artifacts.

## Two Tracks

**Full Workflow** — known problems with definable acceptance criteria:

```
proposal → tests → design → tasks → TDD → review → commit → PR → archive
```

**Spike Track** — exploration where you don't know enough to spec:

```
spike.md → [explore freely] → findings.md → commit → archive
```

## The 30-Minute Rule

| Scope | Track |
|-------|-------|
| < 30 min, obvious fix | Just fix it, write a test, `/sw-commit` |
| < 2 hours, known scope | Full change workflow |
| Unknown scope or technology | Spike first, then decide |
| Choosing between approaches | ADR regardless of code size |

## Agent Compatibility

| Agent | Discovery | Slash Commands |
|-------|-----------|----------------|
| Claude Code | `.github/skills/` | ✅ `/sw-*` |
| GitHub Copilot | `.github/skills/` | ✅ `/sw-*` |
| Cursor | `.github/skills/` | ✅ `/sw-*` |
| Windsurf | `.github/skills/` | ✅ via skills |
| CLI / manual | — | `bash .specwright/scripts/*.sh` |

## Customisation

Edit files in `blueprint/` — that's your project knowledge, change it freely.

Files in `.specwright/` and `.github/skills/` are **protected by a pre-commit hook**.
The agent cannot modify them, and neither can you accidentally. To intentionally
update the framework:

```bash
SPECWRIGHT_UNLOCK=1 git commit -m "chore: update specwright templates"
# or: git commit --no-verify
```

## Git Hooks

Specwright installs three hooks (into `.git/hooks/`, source in `.specwright/hooks/`):

| Hook | Behaviour |
|------|-----------|
| **pre-commit** | Blocks commits that modify `.specwright/` or `.github/skills/sw-*`. Bypass: `SPECWRIGHT_UNLOCK=1` or `--no-verify`. |
| **commit-msg** | Validates conventional commit format (`type(scope): description`). Rejects malformed messages. Bypass: `--no-verify`. |
| **pre-push** | Warns (does not block) if code changed but `blueprint/specs/` wasn't updated. Advisory only. |

If hooks weren't installed (no `.git/` at install time):
```bash
cp .specwright/hooks/* .git/hooks/ && chmod +x .git/hooks/*
```

## Philosophy

AI coding agents are powerful but context-limited. Specs persist intent across sessions. ADRs preserve reasoning across years. Tests prove behaviour regardless of who (or what) wrote the code.

The framework (``.specwright/``) is deliberately separate from the knowledge it manages (``blueprint/``). Your project's engineering documentation belongs to the project, not to any tool.

## License

MIT
