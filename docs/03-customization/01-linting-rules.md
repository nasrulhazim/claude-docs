# Linting Rules

How to customize the markdown linting configuration.

## Default Configuration

The default `.markdownlintrc` is installed to `~/.claude/.markdownlintrc`.

## Overriding Rules

### Project-Level Override

Create a `.markdownlintrc` in your project root. The `lint.sh` script checks
for a local config first before falling back to `~/.claude/.markdownlintrc`.

### Example: Change Line Length

```json
{
  "default": true,
  "MD013": {
    "line_length": 100
  }
}
```

### Example: Disable a Rule

```json
{
  "default": true,
  "MD033": false
}
```

## Available Rules

See the full [markdownlint rules reference](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md)
for all available rules and their options.
