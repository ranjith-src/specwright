<!-- DO NOT EDIT: Managed by Specwright. Bypass: SPECWRIGHT_UNLOCK=1 -->

# Commit Message Convention

## Format

```
<type>(<scope>): <description>

[body — optional, explain WHY not WHAT]

[footer — references]
```

## Types

| Type | When |
|------|------|
| feat | New feature or capability |
| fix | Bug fix |
| test | Adding or updating tests |
| docs | Documentation, specs, ADRs |
| refactor | Code restructure, no behaviour change |
| perf | Performance improvement |
| chore | Build, tooling, dependency updates |
| ci | CI/CD pipeline changes |
| style | Formatting, no logic change |
| build | Build system or dependencies |

## Scope

Use the change name or component name:
- `feat(add-user-auth): implement JWT validation`
- `test(add-user-auth): add token expiry test cases`
- `docs(add-user-auth): create change proposal`

## Footer References

- `Part of: <change-name>` — link to Specwright change
- `See: ADR-NNNN` — link to related decision
- `Closes #123` — link to issue (GitHub/GitLab)
- `BREAKING CHANGE: <description>` — breaking change notice

## Examples

```
feat(add-user-auth): implement JWT token validation

Validates RS256 tokens against public key from JWKS endpoint.
Returns 401 for expired, malformed, or missing tokens.

Part of: add-user-auth
See: ADR-0003
```

```
fix(auth): handle null token in request header

Previously threw NullPointerException when Authorization header
was present but empty.

Closes #47
```
