#!/bin/bash

# Global Documentation Standards Setup Script
# Version: 1.0.0
# Purpose: Install global documentation standards for Claude Code

set -e

echo "🚀 Installing Global Documentation Standards for Claude Code"
echo "=============================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Check if npm is installed (needed for markdownlint)
if ! command -v npm &> /dev/null; then
    echo -e "${YELLOW}⚠️  Warning: npm not found. Skipping markdownlint installation.${NC}"
    echo -e "${YELLOW}   Install Node.js/npm to enable markdown linting.${NC}"
    SKIP_LINTER=true
fi

# Check if files already exist
if [ -f ~/.claude/commands/docs.md ]; then
    echo -e "${YELLOW}⚠️  Warning: ~/.claude/commands/docs.md already exists${NC}"
    read -p "Overwrite? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Skipping docs.md installation${NC}"
        SKIP_DOCS_CMD=true
    fi
fi

if [ -f ~/.claude/docs-guidelines.md ]; then
    echo -e "${YELLOW}⚠️  Warning: ~/.claude/docs-guidelines.md already exists${NC}"
    read -p "Overwrite? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Skipping docs-guidelines.md installation${NC}"
        SKIP_GUIDELINES=true
    fi
fi

if [ -f ~/.claude/.markdownlintrc ]; then
    echo -e "${YELLOW}⚠️  Warning: ~/.claude/.markdownlintrc already exists${NC}"
    read -p "Overwrite? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Skipping .markdownlintrc installation${NC}"
        SKIP_LINTRC=true
    fi
fi

echo ""
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
fi

# Files should already exist from the Write tool, so just verify
if [ -z "$SKIP_DOCS_CMD" ]; then
    if [ -f ~/.claude/commands/docs.md ]; then
        echo -e "${GREEN}✓${NC} ~/.claude/commands/docs.md installed"
    else
        echo -e "${RED}✗${NC} ~/.claude/commands/docs.md missing"
        exit 1
    fi
fi

if [ -z "$SKIP_GUIDELINES" ]; then
    if [ -f ~/.claude/docs-guidelines.md ]; then
        echo -e "${GREEN}✓${NC} ~/.claude/docs-guidelines.md installed"
    else
        echo -e "${RED}✗${NC} ~/.claude/docs-guidelines.md missing"
        exit 1
    fi
fi

if [ -z "$SKIP_LINTRC" ]; then
    if [ -f ~/.claude/.markdownlintrc ]; then
        echo -e "${GREEN}✓${NC} ~/.claude/.markdownlintrc installed"
    else
        echo -e "${RED}✗${NC} ~/.claude/.markdownlintrc missing"
        exit 1
    fi
fi

echo ""
echo "✅ Global Documentation Standards installed successfully!"
echo ""
echo "📖 Usage:"
echo "   /docs                           - Create new documentation"
echo "   /docs reorganize                - Reorganize existing docs"
echo "   /docs validate                  - Validate documentation structure"
echo "   /docs update-toc                - Update all README.md TOCs"
echo ""
echo "📋 Guidelines Location:"
echo "   ~/.claude/docs-guidelines.md"
echo ""
if [ -z "$SKIP_LINTER" ]; then
echo "🔍 Linting Commands:"
echo "   markdownlint docs/**/*.md       - Lint all markdown files"
echo "   markdownlint --fix docs/*.md    - Auto-fix markdown issues"
echo "   markdownlint --config ~/.claude/.markdownlintrc docs/*.md"
echo ""
fi
echo "🔧 Example Commands:"
echo "   /docs"
echo "   Reorganize docs following ~/.claude/docs-guidelines.md"
echo "   Validate docs against ~/.claude/docs-guidelines.md"
if [ -z "$SKIP_LINTER" ]; then
echo "   markdownlint docs/**/*.md"
fi
echo ""
echo "🎉 You're all set! Try '/docs' in any project."
