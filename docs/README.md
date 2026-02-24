# Claude Code Documentation Standards

Documentation index for the `claude-docs` package — a standardized documentation
toolchain for Claude Code projects.

## Contents

| Section                                    | Description                                        |
|--------------------------------------------|----------------------------------------------------|
| [Getting Started](01-getting-started/)     | Installation, requirements, and first run          |
| [Usage](02-usage/)                         | Commands, linting, release notes, and workflows    |
| [Customization](03-customization/)         | Linting rules, contexts, CI/CD integration         |

## Overview

This package provides:

- Numbered folder structure with context-based organization
- Automated markdown linting via `markdownlint-cli`
- `/docs` slash command for Claude Code
- Release note generation from git log
- Project type auto-detection and scaffolding
- Documentation health reports
