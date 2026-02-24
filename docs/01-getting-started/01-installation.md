# Installation

## Requirements

| Requirement   | Status                                      |
|---------------|---------------------------------------------|
| Claude Code   | Latest version (required)                   |
| Node.js & npm | For markdownlint (optional but recommended) |
| Git           | For cloning (manual install only)           |

## One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/nasrulhazim/claude-docs/main/install.sh | bash
```

## Manual Install

1. Clone the repository:

   ```bash
   git clone https://github.com/nasrulhazim/claude-docs.git
   cd claude-docs
   ```

2. Run the installer:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. Verify installation:

   ```bash
   ls -la ~/.claude/
   # Should see: docs-guidelines.md, .markdownlintrc, commands/docs.md
   ```

## What Gets Installed

The installer copies these files to your `~/.claude` directory:

| File                   | Location                | Purpose                                |
|------------------------|-------------------------|----------------------------------------|
| `docs-guidelines.md`   | `~/.claude/`            | Global documentation standards         |
| `.markdownlintrc`      | `~/.claude/`            | Markdown linting rules                 |
| `docs.md`              | `~/.claude/commands/`   | `/docs` slash command                  |
| `lint.sh`              | `~/.claude/`            | Batch markdown linter script           |
| `release-note.sh`      | `~/.claude/`            | Release note generator from git log    |
| `markdownlint-cli`     | Global npm              | Markdown linter (if npm available)     |
