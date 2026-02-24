# Project Detection

When you run `/docs`, Claude auto-detects your project type and suggests the
appropriate documentation template.

## Detection Rules

| Indicator                               | Project Type          | Template               |
|-----------------------------------------|-----------------------|------------------------|
| `composer.json` + `artisan`             | Laravel Application   | Full-Stack Application |
| `composer.json` + `src/` (no artisan)   | PHP/Laravel Package   | Laravel Package        |
| `package.json` + `src/`                 | Node.js Library/SDK   | Library/SDK            |
| `package.json` + `routes/` or `pages/`  | Full-Stack JS App     | Full-Stack Application |
| CLI entry point (`bin/`, `cli.js`)      | CLI Tool              | CLI Tool               |
| `openapi.yaml` or `swagger.json`        | API Service           | REST API               |

If no match is found, the general-purpose structure is used.

## Scaffolding

You can skip auto-detection and scaffold directly:

```bash
/docs scaffold laravel
/docs scaffold api
/docs scaffold cli
/docs scaffold sdk
/docs scaffold fullstack
```

See [Commands](../02-usage/01-commands.md) for the full command reference.
