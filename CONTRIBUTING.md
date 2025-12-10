# Contributing to Claude Code Documentation Standards

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## How to Contribute

### Reporting Issues

If you find a bug or have a suggestion:

1. Check existing [issues](https://github.com/nasrulhazim/claude-docs/issues) first
2. Create a new issue with a clear title and description
3. Include examples and steps to reproduce (for bugs)

### Suggesting Enhancements

For new features or improvements:

1. Open an issue describing the enhancement
2. Explain the use case and benefits
3. Wait for feedback before starting work

### Submitting Changes

1. **Fork the repository**

   ```bash
   git clone https://github.com/nasrulhazim/claude-docs.git
   cd claude-docs
   ```

2. **Create a feature branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**

   - Follow the documentation standards
   - Update relevant documentation
   - Test your changes

4. **Lint your changes**

   ```bash
   markdownlint **/*.md
   ```

5. **Commit your changes**

   ```bash
   git add .
   git commit -m "Add: description of your changes"
   ```

6. **Push to your fork**

   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**

   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Describe your changes clearly

## Coding Standards

### Markdown

- Follow the `.markdownlintrc` rules
- Use ATX-style headers (`#`)
- Use dash-style lists (`-`)
- Include language identifiers in code blocks
- Keep lines under 120 characters (prose)

### File Naming

- Use kebab-case: `01-getting-started.md`
- Use numbered prefixes: `01-`, `02-`, `03-`
- Be descriptive but concise

### Documentation

- Start each page with a brief introduction
- Use clear, active voice
- Include practical examples
- Add cross-references where relevant

## Commit Message Format

Use conventional commits:

```text
Type: Short description

Longer description if needed

Examples:
- Add: new linting rule for headers
- Fix: install script permission issue
- Update: README with better examples
- Docs: clarify installation steps
```

Types:

- **Add** - New feature or file
- **Fix** - Bug fix
- **Update** - Improvements to existing feature
- **Docs** - Documentation changes
- **Refactor** - Code restructuring
- **Test** - Adding tests
- **Chore** - Maintenance tasks

## Development Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/nasrulhazim/claude-docs.git
   cd claude-docs
   ```

2. **Install dependencies**

   ```bash
   npm install -g markdownlint-cli
   ```

3. **Test locally**

   ```bash
   ./install.sh
   ```

4. **Verify installation**

   ```bash
   ls -la ~/.claude/
   markdownlint **/*.md
   ```

## Testing Changes

Before submitting:

1. **Test installation**

   ```bash
   ./install.sh
   ```

2. **Lint all files**

   ```bash
   markdownlint **/*.md
   ```

3. **Test in real project**

   - Create test documentation with `/docs`
   - Verify structure follows standards
   - Check linting works

## Documentation Guidelines

When updating documentation:

1. **Keep it simple** - Avoid jargon
2. **Be specific** - Use concrete examples
3. **Stay consistent** - Follow existing patterns
4. **Test examples** - Ensure code works
5. **Add context** - Explain the "why"

## Review Process

Pull requests will be reviewed for:

- **Quality** - Clear, well-written documentation
- **Standards** - Follows project conventions
- **Testing** - Changes have been tested
- **Completeness** - All necessary files updated

Reviews typically take 1-3 days.

## Community

- Be respectful and constructive
- Help others in discussions
- Share your experiences
- Suggest improvements

## Questions?

- Open an [issue](https://github.com/nasrulhazim/claude-docs/issues)
- Start a [discussion](https://github.com/nasrulhazim/claude-docs/discussions)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing! 🎉
