# Documentation Structure Examples

This document provides real-world examples of documentation structures using the Claude Code Documentation Standards.

## Example 1: Laravel Package

Perfect for Laravel packages and libraries.

```text
docs/
├── README.md                           # Main index
├── 01-getting-started/
│   ├── README.md                       # Getting started TOC
│   ├── 01-installation.md              # Installation guide
│   ├── 02-quick-start.md               # 5-minute quickstart
│   └── 03-configuration.md             # Basic configuration
├── 02-features/
│   ├── README.md                       # Features TOC
│   ├── 01-overview.md                  # All features overview
│   ├── 02-trait-uuid.md                # UUID trait
│   ├── 03-trait-token.md               # Token trait
│   └── 04-trait-slug.md                # Slug trait
├── 03-advanced/
│   ├── README.md                       # Advanced TOC
│   ├── 01-custom-generators.md         # Custom generators
│   └── 02-extending.md                 # Extending functionality
└── 04-api-reference/
    ├── README.md                       # API reference TOC
    ├── 01-classes.md                   # Class reference
    └── 02-methods.md                   # Method reference
README.md                                # Project overview
```

## Example 2: REST API Documentation

Ideal for API services and microservices.

```text
docs/
├── README.md                           # Main index
├── 01-getting-started/
│   ├── README.md
│   ├── 01-introduction.md              # What is this API?
│   ├── 02-authentication.md            # Auth setup
│   └── 03-first-request.md             # Making first API call
├── 02-endpoints/
│   ├── README.md
│   ├── 01-users.md                     # User endpoints
│   ├── 02-posts.md                     # Post endpoints
│   ├── 03-comments.md                  # Comment endpoints
│   └── 04-media.md                     # Media endpoints
├── 03-guides/
│   ├── README.md
│   ├── 01-pagination.md                # Pagination guide
│   ├── 02-filtering.md                 # Filtering results
│   ├── 03-rate-limiting.md             # Rate limits
│   └── 04-webhooks.md                  # Webhook setup
└── 04-reference/
    ├── README.md
    ├── 01-errors.md                    # Error codes
    ├── 02-status-codes.md              # HTTP status codes
    └── 03-changelog.md                 # API changelog
README.md                                # Project overview
```

## Example 3: Full-Stack Application

Comprehensive documentation for complex applications.

```text
docs/
├── README.md                           # Main index
├── 01-architecture/
│   ├── README.md
│   ├── 01-overview.md                  # System architecture
│   ├── 02-frontend.md                  # Frontend architecture
│   ├── 03-backend.md                   # Backend architecture
│   └── 04-database.md                  # Database design
├── 02-development/
│   ├── README.md
│   ├── 01-getting-started.md           # Dev environment setup
│   ├── 02-coding-standards.md          # Code style guide
│   ├── 03-git-workflow.md              # Git branching strategy
│   └── 04-testing.md                   # Testing guide
├── 03-deployment/
│   ├── README.md
│   ├── 01-environments.md              # Dev, staging, prod
│   ├── 02-docker.md                    # Docker setup
│   ├── 03-ci-cd.md                     # CI/CD pipeline
│   └── 04-monitoring.md                # Monitoring & logging
├── 04-features/
│   ├── README.md
│   ├── 01-authentication.md            # Auth system
│   ├── 02-user-management.md           # User features
│   ├── 03-notifications.md             # Notification system
│   └── 04-payments.md                  # Payment integration
└── 05-troubleshooting/
    ├── README.md
    ├── 01-common-issues.md             # Common problems
    ├── 02-debugging.md                 # Debugging guide
    └── 03-faq.md                       # FAQ
README.md                                # Project overview
```

## Example 4: CLI Tool

Documentation for command-line tools.

```text
docs/
├── README.md                           # Main index
├── 01-installation/
│   ├── README.md
│   ├── 01-requirements.md              # System requirements
│   ├── 02-install.md                   # Installation steps
│   └── 03-configuration.md             # Initial setup
├── 02-usage/
│   ├── README.md
│   ├── 01-basic-commands.md            # Common commands
│   ├── 02-advanced-usage.md            # Advanced features
│   └── 03-examples.md                  # Real-world examples
├── 03-commands/
│   ├── README.md
│   ├── 01-init.md                      # init command
│   ├── 02-build.md                     # build command
│   ├── 03-deploy.md                    # deploy command
│   └── 04-config.md                    # config command
└── 04-reference/
    ├── README.md
    ├── 01-flags.md                     # Command flags
    ├── 02-environment.md               # Environment variables
    └── 03-config-file.md               # Config file reference
README.md                                # Project overview
```

## Example 5: Library/SDK

Documentation for SDKs and libraries.

```text
docs/
├── README.md                           # Main index
├── 01-introduction/
│   ├── README.md
│   ├── 01-overview.md                  # What is this library?
│   ├── 02-installation.md              # Installation
│   └── 03-quick-start.md               # Quick start guide
├── 02-guides/
│   ├── README.md
│   ├── 01-authentication.md            # Auth guide
│   ├── 02-making-requests.md           # Making API calls
│   ├── 03-handling-responses.md        # Response handling
│   └── 04-error-handling.md            # Error handling
├── 03-api-reference/
│   ├── README.md
│   ├── 01-client.md                    # Client class
│   ├── 02-resources.md                 # Resource classes
│   ├── 03-models.md                    # Model classes
│   └── 04-exceptions.md                # Exception classes
└── 04-advanced/
    ├── README.md
    ├── 01-customization.md             # Customizing behavior
    ├── 02-plugins.md                   # Plugin system
    └── 03-testing.md                   # Testing with SDK
README.md                                # Project overview
```

## Common Patterns

### Root README.md Structure

```markdown
# Project Name

Brief description of what this project does.

## Features

- Feature 1
- Feature 2
- Feature 3

## Installation

\`\`\`bash
npm install project-name
\`\`\`

## Quick Start

\`\`\`javascript
// Minimal working example
\`\`\`

## Documentation

Full documentation is available in the [docs/](docs/) directory:

- [Getting Started](docs/01-getting-started/README.md)
- [API Reference](docs/02-api-reference/README.md)
- [Advanced Usage](docs/03-advanced/README.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

MIT
```

### Context README.md Structure

```markdown
# Getting Started

This section covers everything you need to get up and running.

## Table of Contents

### [1. Installation](01-installation.md)

How to install and set up the project.

### [2. Quick Start](02-quick-start.md)

Get running in 5 minutes with a simple example.

### [3. Configuration](03-configuration.md)

Configure the project for your needs.

## Related Documentation

- [API Reference](../02-api-reference/README.md)
- [Advanced Topics](../03-advanced/README.md)
```

### Individual Page Structure

```markdown
# Topic Title

Brief introduction to what this page covers and why it's important.

## Section 1

Main content with explanations.

### Subsection 1.1

Detailed information.

## Examples

\`\`\`language
// Code example
\`\`\`

## Common Issues

Troubleshooting tips if applicable.

## Next Steps

- [Related Topic](02-related.md)
- [Advanced Usage](../03-advanced/01-overview.md)
```

## Tips for Choosing Structure

### For Small Projects (< 10 docs)

```text
docs/
├── README.md
├── 01-getting-started.md
├── 02-usage.md
└── 03-api-reference.md
```

### For Medium Projects (10-30 docs)

Use 3-4 context folders:

- `01-getting-started/`
- `02-guides/`
- `03-api-reference/`

### For Large Projects (30+ docs)

Use 5-7 context folders with clear separation:

- `01-introduction/`
- `02-architecture/`
- `03-development/`
- `04-deployment/`
- `05-api-reference/`
- `06-examples/`
- `07-advanced/`

## Customizing for Your Project

1. **Identify contexts** - What are the major aspects? (Getting started, API, deployment, etc.)
2. **Prioritize** - Number folders by importance and reading order
3. **Group logically** - Keep related content together
4. **Start simple** - Begin with 2-3 contexts, expand as needed
5. **Stay consistent** - Follow the same pattern throughout

## Need Help?

- See [docs-guidelines.md](../docs-guidelines.md) for full standards
- Use `/docs` command in Claude Code for automatic structure generation
- Check existing projects for inspiration
