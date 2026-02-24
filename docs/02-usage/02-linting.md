# Linting

Automated markdown linting using `markdownlint-cli` and the included `lint.sh`
script.

## Quick Reference

| Action                    | Command                        |
|---------------------------|--------------------------------|
| Lint all docs             | `~/.claude/lint.sh`            |
| Lint and auto-fix         | `~/.claude/lint.sh --fix`      |
| Lint specific directory   | `~/.claude/lint.sh src/`       |
| Lint and fix specific dir | `~/.claude/lint.sh --fix src/` |
| Lint current directory    | `~/.claude/lint.sh .`          |

The script auto-detects `.markdownlintrc` config (local first, then `~/.claude/`),
finds all `.md` files recursively, and lints them in one pass.

## Linting Rules

The default `.markdownlintrc` enforces:

| Rule  | Setting            | Purpose                                   |
|-------|--------------------|-------------------------------------------|
| MD003 | `style: atx`       | ATX-style headers (`#` not underline)     |
| MD004 | `style: dash`      | Dash-style lists (`-` not `*` or `+`)     |
| MD007 | `indent: 2`        | 2-space indentation for lists             |
| MD013 | `line_length: 120` | 120 character line length (prose only)    |
| MD025 | enabled            | Single H1 per document                    |
| MD040 | enabled            | Language identifiers in code blocks       |
| MD046 | `style: fenced`    | Fenced code block style (backticks)       |

See [Customization > Linting Rules](../03-customization/01-linting-rules.md) for
how to override these.
