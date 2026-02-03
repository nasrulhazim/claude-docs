#!/bin/bash

# Claude Code Documentation Standards Installer
# Version: 1.1.0
# Usage: curl -fsSL https://raw.githubusercontent.com/nasrulhazim/claude-docs/main/install.sh | bash

set -e

echo "🚀 Installing Claude Code Documentation Standards"
echo "=================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Detect installation method
if [ -d ".git" ] && [ -f "docs-guidelines.md" ]; then
    # Running from cloned repository
    INSTALL_MODE="local"
    REPO_DIR="$(pwd)"
    echo -e "${BLUE}ℹ️  Installing from local repository${NC}"
else
    # Running from curl | bash
    INSTALL_MODE="remote"
    REPO_URL="https://raw.githubusercontent.com/nasrulhazim/claude-docs/main"
    echo -e "${BLUE}ℹ️  Installing from remote repository${NC}"
fi

echo ""

# Check if ~/.claude directory exists
if [ ! -d ~/.claude ]; then
    echo -e "${YELLOW}Creating ~/.claude directory...${NC}"
    mkdir -p ~/.claude
fi

# Check if ~/.claude/commands directory exists
if [ ! -d ~/.claude/commands ]; then
    echo -e "${YELLOW}Creating ~/.claude/commands directory...${NC}"
    mkdir -p ~/.claude/commands
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${YELLOW}⚠️  Warning: npm not found. Skipping markdownlint installation.${NC}"
    echo -e "${YELLOW}   Install Node.js/npm to enable markdown linting.${NC}"
    SKIP_LINTER=true
fi

# Function to install file from local or remote
install_file() {
    local source_file=$1
    local dest_file=$2
    local file_desc=$3

    if [ -f "$dest_file" ]; then
        echo -e "${YELLOW}⚠️  $file_desc already exists${NC}"
        read -p "Overwrite? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Skipping $file_desc${NC}"
            return 1
        fi
    fi

    if [ "$INSTALL_MODE" = "local" ]; then
        cp "$REPO_DIR/$source_file" "$dest_file"
    else
        curl -fsSL "$REPO_URL/$source_file" -o "$dest_file"
    fi

    if [ -f "$dest_file" ]; then
        echo -e "${GREEN}✓${NC} $file_desc installed"
        return 0
    else
        echo -e "${RED}✗${NC} Failed to install $file_desc"
        return 1
    fi
}

echo "📦 Installing files..."
echo ""

# Install markdownlint-cli globally
if [ -z "$SKIP_LINTER" ]; then
    echo "Installing markdownlint-cli..."
    if npm install -g markdownlint-cli &> /dev/null; then
        echo -e "${GREEN}✓${NC} markdownlint-cli installed"
    else
        echo -e "${YELLOW}⚠️  Warning: Failed to install markdownlint-cli${NC}"
        echo -e "${YELLOW}   You can install it manually: npm install -g markdownlint-cli${NC}"
    fi
    echo ""
fi

# Install files
install_file "docs-guidelines.md" ~/.claude/docs-guidelines.md "Documentation guidelines"
install_file ".markdownlintrc" ~/.claude/.markdownlintrc "Markdownlint configuration"
install_file "docs.md" ~/.claude/commands/docs.md "Documentation command"
install_file "lint.sh" ~/.claude/lint.sh "Markdown linter script"
install_file "release-note.sh" ~/.claude/release-note.sh "Release note generator"

# Make scripts executable
chmod +x ~/.claude/lint.sh 2>/dev/null || true
chmod +x ~/.claude/release-note.sh 2>/dev/null || true

echo ""
echo -e "${GREEN}✅ Claude Code Documentation Standards installed successfully!${NC}"
echo ""
echo "📖 Usage:"
echo "   /docs                           - Create new documentation"
echo "   /docs reorganize                - Reorganize existing docs"
echo "   /docs validate                  - Validate documentation structure"
echo "   /docs update-toc                - Update all README.md TOCs"
echo "   /docs health                    - Generate documentation health report"
echo "   /docs scaffold <type>           - Scaffold from template"
echo "   /docs release-note              - Generate release note from git log"
echo "   /docs release-note --tldr       - TLDR release note"
echo ""
echo "📋 Guidelines Location:"
echo "   ~/.claude/docs-guidelines.md"
echo ""
echo "🔍 Linting Commands:"
echo "   ~/.claude/lint.sh               - Lint all docs/ markdown files"
echo "   ~/.claude/lint.sh --fix         - Auto-fix all docs/ markdown files"
echo "   ~/.claude/lint.sh src/          - Lint a specific directory"
echo "   ~/.claude/lint.sh --fix src/    - Auto-fix a specific directory"
echo ""
echo "🔧 Example Commands:"
echo "   /docs"
echo "   Reorganize docs following ~/.claude/docs-guidelines.md"
echo "   Validate docs against ~/.claude/docs-guidelines.md"
echo "   ~/.claude/lint.sh"
echo ""
echo "📚 Full README:"
if [ "$INSTALL_MODE" = "local" ]; then
echo "   cat $REPO_DIR/README.md"
else
echo "   https://github.com/nasrulhazim/claude-docs"
fi
echo ""
echo "🎉 You're all set! Try '/docs' in any project with Claude Code."
echo ""
