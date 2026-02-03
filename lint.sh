#!/bin/bash

# Claude Code Documentation Linter
# Lint all markdown files in a given path (defaults to docs/)
# Usage:
#   ./lint.sh              # Lint docs/
#   ./lint.sh src/         # Lint src/
#   ./lint.sh --fix        # Lint & auto-fix docs/
#   ./lint.sh --fix src/   # Lint & auto-fix src/

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# Defaults
FIX_MODE=false
TARGET_PATH=""

# Parse arguments
for arg in "$@"; do
    case "$arg" in
        --fix|-f)
            FIX_MODE=true
            ;;
        --help|-h)
            echo "Usage: ./lint.sh [--fix] [path]"
            echo ""
            echo "Lint all markdown files recursively in the given path."
            echo ""
            echo "Arguments:"
            echo "  path       Directory to lint (default: docs/)"
            echo ""
            echo "Options:"
            echo "  --fix, -f  Auto-fix linting issues where possible"
            echo "  --help, -h Show this help message"
            echo ""
            echo "Examples:"
            echo "  ./lint.sh                  Lint docs/"
            echo "  ./lint.sh --fix            Lint & auto-fix docs/"
            echo "  ./lint.sh src/             Lint src/"
            echo "  ./lint.sh --fix src/       Lint & auto-fix src/"
            echo "  ./lint.sh .                Lint all markdown files in current directory"
            exit 0
            ;;
        *)
            TARGET_PATH="$arg"
            ;;
    esac
done

# Default to docs/ if no path given
if [ -z "$TARGET_PATH" ]; then
    TARGET_PATH="docs"
fi

# Strip trailing slash
TARGET_PATH="${TARGET_PATH%/}"

# Check markdownlint is installed
if ! command -v markdownlint &> /dev/null; then
    echo -e "${RED}Error: markdownlint-cli is not installed.${NC}"
    echo ""
    echo "Install it with:"
    echo "  npm install -g markdownlint-cli"
    exit 1
fi

# Check target path exists
if [ ! -d "$TARGET_PATH" ]; then
    echo -e "${RED}Error: Directory '$TARGET_PATH' not found.${NC}"
    exit 1
fi

# Find all markdown files
MD_FILES=$(find "$TARGET_PATH" -name '*.md' -type f 2>/dev/null | sort)
FILE_COUNT=$(echo "$MD_FILES" | grep -c '.' 2>/dev/null || echo 0)

if [ "$FILE_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}No markdown files found in '$TARGET_PATH'.${NC}"
    exit 0
fi

echo -e "${BOLD}Linting $FILE_COUNT markdown file(s) in '$TARGET_PATH/'${NC}"
echo ""

# Determine config file
CONFIG_FLAG=""
if [ -f ".markdownlintrc" ]; then
    CONFIG_FLAG="--config .markdownlintrc"
    echo -e "${BLUE}Using config: .markdownlintrc${NC}"
elif [ -f "$HOME/.claude/.markdownlintrc" ]; then
    CONFIG_FLAG="--config $HOME/.claude/.markdownlintrc"
    echo -e "${BLUE}Using config: ~/.claude/.markdownlintrc${NC}"
else
    echo -e "${YELLOW}No .markdownlintrc found, using defaults.${NC}"
fi

# Build command
CMD="markdownlint"
if [ "$FIX_MODE" = true ]; then
    CMD="$CMD --fix"
    echo -e "${BLUE}Mode: auto-fix${NC}"
else
    echo -e "${BLUE}Mode: check only${NC}"
fi

if [ -n "$CONFIG_FLAG" ]; then
    CMD="$CMD $CONFIG_FLAG"
fi

echo ""

# Run linter on all files at once
# shellcheck disable=SC2086
if $CMD $MD_FILES 2>&1; then
    echo ""
    echo -e "${GREEN}All $FILE_COUNT file(s) passed linting.${NC}"
    exit 0
else
    EXIT_CODE=$?
    echo ""
    if [ "$FIX_MODE" = true ]; then
        echo -e "${YELLOW}Auto-fixed what was possible. Some issues may need manual attention.${NC}"
    else
        echo -e "${RED}Linting failed. Run with --fix to auto-fix:${NC}"
        echo "  ./lint.sh --fix $TARGET_PATH"
    fi
    exit $EXIT_CODE
fi
