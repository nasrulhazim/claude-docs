# Global Documentation Standards

> **Version**: 1.1.0
> **Last Updated**: 2025-12-10
> **Applies To**: All projects using Claude Code

## Overview

This document defines the standardized structure and conventions for project documentation across all projects. Following these standards ensures consistency, maintainability, and ease of navigation.

## Core Principles

1. **Context-Based Organization** - Group related content by major aspects
2. **Numbered Priority** - Folders and files numbered by importance/reading order
3. **Progressive Detail** - Overview → Specifics within each context
4. **Single Source of Truth** - All docs in `docs/` directory
5. **Self-Documenting** - Each context folder has README.md with TOC

## Directory Structure

### Required Organization

```
docs/
├── README.md                    # Main documentation index
├── 01-{context}/
│   ├── README.md               # Context-specific TOC
│   ├── 01-{topic}.md           # Sequential topics
│   ├── 02-{topic}.md
│   └── 03-{topic}.md
├── 02-{context}/
│   ├── README.md
│   └── ...
└── 0N-{context}/
    └── README.md
README.md                        # Project overview (root)
```

### Standard Contexts

Common context folders (adjust priority numbering based on project):

| Folder | Purpose | Typical Contents |
|--------|---------|------------------|
| `01-architecture/` | System design and patterns | overview, patterns, data-layer, components |
| `02-development/` | Developer guides | getting-started, workflows, testing, debugging |
| `03-deployment/` | Deployment and operations | environments, production, monitoring |
| `04-api/` | API documentation | authentication, endpoints, webhooks |
| `05-configuration/` | Configuration reference | env-vars, config-files, feature-flags |
| `06-examples/` | Practical examples | real-world, use-cases, recipes |
| `07-advanced/` | Advanced topics | optimization, scaling, custom-extensions |

### Folder Numbering Rules

1. **01-XX**: Most important/frequently accessed content
2. **02-XX**: Essential for getting started
3. **03-XX**: Operational/deployment information
4. **04-XX+**: Supplementary/reference material
5. **Gap Numbering**: Use 01, 02, 03 (not 01, 05, 10) - allows insertion

## File Naming Conventions

### Format: `{number}-{description}.md`

**Rules**:

- **Prefix**: Two-digit number (01-, 02-, 03-)
- **Separator**: Single hyphen
- **Description**: kebab-case (lowercase, hyphens)
- **Extension**: Always `.md`

**Examples**:

```
✅ 01-overview.md
✅ 02-getting-started.md
✅ 03-authentication.md
✅ 04-custom-generators.md

❌ overview.md           (no number)
❌ 1-overview.md         (single digit)
❌ 01_overview.md        (underscore)
❌ 01-Overview.md        (capitalized)
❌ 01-gettingStarted.md  (camelCase)
```

### Special Files

- `README.md` - Required in root and each context folder
- No numbering for README.md files

## README.md Requirements

### Root README.md

Project overview with:

- **Badges** - Build status, version, coverage
- **Description** - One-paragraph overview
- **Features** - Key capabilities (bullet points)
- **Installation** - Quick install command
- **Quick Start** - Minimal example
- **Documentation Links** - Links to `docs/README.md` and key sections
- **Contributing/License** - Standard sections

**Keep root README minimal** - detailed docs go in `docs/`

### docs/README.md

Main documentation index with:

- **Title** - "Documentation"
- **Overview** - Brief intro to documentation structure
- **Navigation** - Links to all context folders with descriptions
- **Getting Started** - Link to quickstart guide
- **Search Tips** - How to find information

**Template**:

```markdown
# Documentation

## Overview
[Brief description of the project and documentation organization]

## Documentation Structure

### [01. Architecture](01-architecture/README.md)
System design, patterns, and architectural decisions.

### [02. Development](02-development/README.md)
Developer guides, workflows, and best practices.

### [03. Deployment](03-deployment/README.md)
Deployment procedures and operational guides.

## Quick Start
New to the project? Start with [Getting Started](02-development/01-getting-started.md).

## Finding Information
- **Concepts**: Check Architecture section
- **How-to**: Check Development section
- **API Reference**: Check API section
```

### Context Folder README.md

Table of contents for context with:

- **Context Title**
- **Overview** - What this section covers
- **Table of Contents** - All files in order with descriptions
- **Related Sections** - Links to related context folders

**Template**:

```markdown
# {Context Name}

## Overview
[Brief description of this context and what it covers]

## Table of Contents

### [1. {Topic}](01-{topic}.md)
[Brief description of what this covers]

### [2. {Topic}](02-{topic}.md)
[Brief description of what this covers]

### [3. {Topic}](03-{topic}.md)
[Brief description of what this covers]

## Related Documentation
- [Related Context 1](../02-{context}/README.md)
- [Related Context 2](../03-{context}/README.md)
```

## Document Structure

### Standard Page Format

Every documentation page should follow this structure:

```markdown
# Title

[Brief introduction paragraph - what this page covers]

## Section 1

[Content with examples]

### Subsection 1.1

[Detailed content]

## Section 2

[More content]

## Examples

[Practical code examples from the project]

## Next Steps

- [Related Topic 1](02-related-topic.md)
- [Related Topic 2](../03-deployment/01-overview.md)
```

### Heading Hierarchy

- **H1 (`#`)**: Page title only (one per page)
- **H2 (`##`)**: Main sections
- **H3 (`###`)**: Subsections
- **H4 (`####`)**: Rarely used, only for deep nesting

### Content Guidelines

1. **Introduction Paragraph**: Every page starts with brief overview
2. **Progressive Detail**: Simple → Complex within each page
3. **Code Examples**: Include actual code from the project
4. **Cross-References**: Link to related pages at bottom
5. **Active Voice**: Use direct, active language
6. **Short Paragraphs**: 2-4 sentences maximum

## Markdown Conventions

### Code Blocks

Always specify language:

```markdown
```php
class Example
{
    // Code here
}
```

```

### Inline Code

Use for:
- Variable names: `$variable`
- Class names: `TokenGenerator`
- File paths: `config/app.php`
- Commands: `php artisan migrate`

### Emphasis

- **Bold** for UI elements, file names, important terms
- *Italic* sparingly for emphasis
- `Code` for technical terms, values

### Lists

**Ordered** for steps/sequences:
```markdown
1. First step
2. Second step
3. Third step
```

**Unordered** for options/features:

```markdown
- Feature one
- Feature two
- Feature three
```

### Tables

For comparisons and reference:

```markdown
| Feature | Description | Example |
|---------|-------------|---------|
| Item 1  | Details     | `code`  |
| Item 2  | Details     | `code`  |
```

### Blockquotes

For warnings, notes, tips:

```markdown
> **Note**: Important information here

> **Warning**: Critical warning here

> **Tip**: Helpful tip here
```

## Cross-Referencing

### Internal Links

Use **relative paths** from current location:

```markdown
<!-- Same folder -->
[Related Topic](02-related-topic.md)

<!-- Parent folder -->
[Main Index](../README.md)

<!-- Different context -->
[Deployment Guide](../03-deployment/01-overview.md)

<!-- Section within same page -->
[Jump to Examples](#examples)
```

### External Links

Full URLs for external resources:

```markdown
[Laravel Documentation](https://laravel.com/docs)
[GitHub Repository](https://github.com/user/repo)
```

## Code Examples

### Include Context

Always show full context, not just fragments:

```markdown
<!-- Good -->
```php
use App\Models\User;

class UserController extends Controller
{
    public function index()
    {
        return User::all();
    }
}
```

<!-- Bad -->
```php
return User::all();
```

```

### Comment Explanations

Add comments to explain non-obvious code:

```php
class Post extends Model
{
    use InteractsWithSlug;

    // Generate slug from 'title' instead of default 'name'
    protected $slug_source_column = 'title';
}
```

### Show Real Examples

Use actual code from the project when possible:

```markdown
<!-- Reference actual files -->
See [src/Generators/TokenGenerator.php](../src/Generators/TokenGenerator.php:15-30)

<!-- Include real config -->
```php
// config/app.php
'timezone' => env('APP_TIMEZONE', 'UTC'),
```

```

## Linting and Quality Assurance

### Markdown Linting

This documentation standard includes automated linting using **markdownlint** to ensure consistency and catch common formatting issues.

#### Installation

Markdownlint is automatically installed during setup:

```bash
npm install -g markdownlint-cli
```

#### Configuration

Linting rules are defined in `~/.claude/.markdownlintrc`:

- **MD003**: ATX-style headers (`#` syntax)
- **MD004**: Dash-style unordered lists
- **MD007**: 2-space indentation for lists
- **MD013**: 120 character line length (excludes code blocks and tables)
- **MD024**: Allow duplicate headers in different sections
- **MD025**: Single H1 per document
- **MD033**: Allow specific HTML elements (br, details, summary, kbd, sub, sup)
- **MD040**: Language identifiers required in fenced code blocks
- **MD041**: First line must be top-level header
- **MD046**: Fenced code block style (backticks)
- **MD048**: Code fence style (backticks, not tildes)

#### Running the Linter

**Lint all markdown files in docs:**

```bash
markdownlint docs/**/*.md
```

**Lint specific file:**

```bash
markdownlint docs/01-architecture/01-overview.md
```

**Auto-fix issues:**

```bash
markdownlint --fix docs/**/*.md
```

**Use custom config:**

```bash
markdownlint --config ~/.claude/.markdownlintrc docs/**/*.md
```

#### Common Linting Issues

| Issue | Rule | Solution |
|-------|------|----------|
| Missing language in code block | MD040 | Add language identifier: ` ```php ` |
| Multiple H1 headers | MD025 | Use only one `#` title per file |
| Inconsistent list markers | MD004 | Use `-` for all unordered lists |
| Trailing spaces | MD009 | Remove spaces at end of lines |
| Long lines | MD013 | Break lines at 120 characters (prose only) |
| No blank lines around headers | MD022 | Add blank line before and after headers |

#### Pre-commit Hook (Optional)

Add to `.git/hooks/pre-commit` to lint before commits:

```bash
#!/bin/bash
# Lint staged markdown files
STAGED_MD=$(git diff --cached --name-only --diff-filter=ACM | grep '\.md$')

if [ -n "$STAGED_MD" ]; then
    echo "Linting markdown files..."
    markdownlint $STAGED_MD

    if [ $? -ne 0 ]; then
        echo "❌ Markdown linting failed. Fix issues or use --no-verify to skip."
        exit 1
    fi
    echo "✅ Markdown linting passed!"
fi
```

Make executable:

```bash
chmod +x .git/hooks/pre-commit
```

#### IDE Integration

**VS Code:**
Install [markdownlint extension](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

**Vim/Neovim:**
Use ALE or similar linter plugin

**JetBrains IDEs:**
Install Markdown Navigator plugin

### Quality Checklist with Linting

Updated checklist including linting:

#### Before Committing Documentation

- [ ] Run `markdownlint docs/**/*.md`
- [ ] Fix all linting errors
- [ ] Verify all code blocks have language identifiers
- [ ] Check line lengths (prose should be readable)
- [ ] Ensure consistent list formatting
- [ ] Validate internal links still work

#### CI/CD Integration

Add to your CI pipeline (e.g., `.github/workflows/docs-lint.yml`):

```yaml
name: Lint Documentation

on: [push, pull_request]

jobs:
  markdown-lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install markdownlint
        run: npm install -g markdownlint-cli
      - name: Lint markdown files
        run: markdownlint 'docs/**/*.md'
```

## Migration Guide

### Converting Existing Docs

1. **Audit Current Structure**
   - List all existing documentation files
   - Identify natural context groupings
   - Determine priority/reading order

2. **Create Numbered Structure**
   ```bash
   mkdir -p docs/{01-architecture,02-development,03-deployment}
   ```

3. **Move and Rename Files**

   ```bash
   mv docs/architecture.md docs/01-architecture/01-overview.md
   mv docs/getting-started.md docs/02-development/01-getting-started.md
   ```

4. **Create README.md Files**
   - docs/README.md (main index)
   - Each context folder README.md (TOC)

5. **Update Cross-References**
   - Change absolute paths to relative
   - Update based on new numbered structure

6. **Validate Links**
   - Test all internal links
   - Ensure progressive flow

## Checklist

Use this checklist when creating or auditing documentation:

### Structure

- [ ] All docs in `docs/` directory
- [ ] Context folders numbered (01-, 02-, 03-)
- [ ] Files numbered within contexts (01-, 02-, 03-)
- [ ] README.md in root
- [ ] README.md in docs/
- [ ] README.md in each context folder

### Naming

- [ ] All files use kebab-case
- [ ] Numbered prefixes on all content files
- [ ] No capitals in filenames
- [ ] Consistent naming patterns

### Content

- [ ] Each page has H1 title
- [ ] Introduction paragraph on each page
- [ ] Code examples included
- [ ] Cross-references at bottom
- [ ] Language specified in code blocks

### Navigation

- [ ] Table of contents in context READMEs
- [ ] Relative paths for internal links
- [ ] All links tested and working
- [ ] Progressive detail flow maintained

### Quality

- [ ] Consistent formatting
- [ ] Active voice used
- [ ] Short paragraphs (2-4 sentences)
- [ ] Practical examples from codebase
- [ ] No broken links

### Linting

- [ ] Run `markdownlint docs/**/*.md` passes
- [ ] All code blocks have language identifiers
- [ ] No trailing whitespace
- [ ] Consistent list marker style (dashes)
- [ ] Line length under 120 characters (prose)

## Examples

### Example: Laravel Package Documentation

```text
docs/
├── README.md                           # "Documentation for Traitify Package"
├── 01-getting-started/
│   ├── README.md                       # TOC for getting started
│   ├── 01-installation.md              # Installation guide
│   ├── 02-quick-start.md               # 5-minute quickstart
│   └── 03-basic-usage.md               # Basic concepts
├── 02-architecture/
│   ├── README.md                       # TOC for architecture
│   ├── 01-overview.md                  # System overview
│   ├── 02-generator-pattern.md         # Generator design
│   └── 03-resolution-strategy.md       # How generators resolve
├── 03-traits/
│   ├── README.md                       # TOC for traits
│   ├── 01-overview.md                  # All traits overview
│   ├── 02-interacts-with-uuid.md       # UUID trait
│   ├── 03-interacts-with-token.md      # Token trait
│   └── 04-interacts-with-slug.md       # Slug trait
├── 04-generators/
│   ├── README.md                       # TOC for generators
│   ├── 01-overview.md                  # Generator system
│   ├── 02-token-generator.md           # Token details
│   ├── 03-uuid-generator.md            # UUID details
│   └── 04-slug-generator.md            # Slug details
├── 05-configuration/
│   ├── README.md                       # TOC for config
│   ├── 01-config-file.md               # Config reference
│   └── 02-environment-vars.md          # Environment setup
├── 06-examples/
│   ├── README.md                       # TOC for examples
│   └── 01-real-world.md                # Real-world examples
└── 07-advanced/
    ├── README.md                       # TOC for advanced
    └── 01-custom-generators.md         # Custom generator guide
README.md                                # Project overview
```

## Usage

### With Claude Code

#### Create new documentation

```text
/docs
```

#### Reorganize existing

```text
Reorganize the documentation following ~/.claude/docs-guidelines.md
```

#### Validate structure

```text
Validate documentation against ~/.claude/docs-guidelines.md and report issues
```

#### Update TOCs

```text
Update all README.md TOCs following ~/.claude/docs-guidelines.md
```

### Manual Reference

When manually creating documentation:

1. Reference this file for structure
2. Use the templates provided
3. Follow the checklist
4. Validate against standards

## Maintenance

### Updating These Guidelines

When updating this guideline:

1. Update version number at top
2. Update "Last Updated" date
3. Document changes in CHANGELOG section below
4. Notify team of changes

### CHANGELOG

**v1.1.0** (2025-12-10)

- Added markdown linting support with markdownlint
- Added `.markdownlintrc` configuration file
- Added linting section with setup and usage instructions
- Added pre-commit hook example
- Added CI/CD integration example
- Updated quality checklist with linting items

**v1.0.0** (2024-12-10)

- Initial global documentation standards
- Numbered folder structure
- Context-based organization
- Progressive detail flow
- Comprehensive templates and examples

---

**Questions?** These guidelines are living documents. Suggest improvements or clarifications as needed.
