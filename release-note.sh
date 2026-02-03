#!/bin/bash

# Claude Code Release Note Generator
# Generate release notes from today's git log activity
# Usage:
#   ./release-note.sh              # Full release note (today)
#   ./release-note.sh --tldr       # TLDR version (today)
#   ./release-note.sh --since yesterday
#   ./release-note.sh --tldr --since "2025-12-01"
#   ./release-note.sh --since "2 days ago"
#   ./release-note.sh --output RELEASE.md

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# Defaults
MODE="full"
SINCE="today"
SINCE_LABEL="today"
OUTPUT_FILE=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --tldr|-t)
            MODE="tldr"
            shift
            ;;
        --full|-f)
            MODE="full"
            shift
            ;;
        --since|-s)
            SINCE="$2"
            SINCE_LABEL="$2"
            shift 2
            ;;
        --output|-o)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: ./release-note.sh [options]"
            echo ""
            echo "Generate release notes from git log activity."
            echo ""
            echo "Options:"
            echo "  --full, -f          Full/comprehensive release note (default)"
            echo "  --tldr, -t          Short TLDR summary"
            echo "  --since, -s <date>  Start date (default: today)"
            echo "                      Accepts: today, yesterday, '2 days ago', '2025-12-01'"
            echo "  --output, -o <file> Write output to file instead of stdout"
            echo "  --help, -h          Show this help message"
            echo ""
            echo "Examples:"
            echo "  ./release-note.sh                          Full note, today's commits"
            echo "  ./release-note.sh --tldr                   TLDR, today's commits"
            echo "  ./release-note.sh --since yesterday        Full note, since yesterday"
            echo "  ./release-note.sh --tldr --since '1 week ago'"
            echo "  ./release-note.sh --output RELEASE.md      Write to file"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Run with --help for usage."
            exit 1
            ;;
    esac
done

# Check we're in a git repo
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo -e "${RED}Error: Not a git repository.${NC}"
    exit 1
fi

# Resolve since date for git log
if [ "$SINCE" = "today" ]; then
    SINCE_DATE=$(date +%Y-%m-%d)
    SINCE_FLAG="--since=$SINCE_DATE"
else
    SINCE_FLAG="--since=$SINCE"
fi

# Get repo info
REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "HEAD")
TODAY=$(date +%Y-%m-%d)

# Get commits
COMMIT_COUNT=$(git log "$SINCE_FLAG" --oneline 2>/dev/null | wc -l | tr -d ' ')

if [ "$COMMIT_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}No commits found since $SINCE_LABEL.${NC}"
    exit 0
fi

# Get latest tag if any
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

# Collect git data
COMMITS_ONELINE=$(git log "$SINCE_FLAG" --oneline --no-merges 2>/dev/null)
COMMITS_FULL=$(git log "$SINCE_FLAG" --no-merges --format="- **%s** %n  %b" 2>/dev/null | sed '/^$/d; /^  $/d')
AUTHORS=$(git log "$SINCE_FLAG" --no-merges --format="%aN" 2>/dev/null | sort -u)
AUTHOR_COUNT=$(echo "$AUTHORS" | grep -c '.' 2>/dev/null || echo 0)
FILES_CHANGED=$(git log "$SINCE_FLAG" --no-merges --name-only --format="" 2>/dev/null | sort -u | grep -c '.' 2>/dev/null || echo 0)

# Categorize commits by conventional commit prefix
FEAT_COMMITS=$(echo "$COMMITS_ONELINE" | grep -iE '^[a-f0-9]+ (feat|add|new)[:(]' 2>/dev/null || true)
FIX_COMMITS=$(echo "$COMMITS_ONELINE" | grep -iE '^[a-f0-9]+ (fix|bug|patch|hotfix)[:(]' 2>/dev/null || true)
DOCS_COMMITS=$(echo "$COMMITS_ONELINE" | grep -iE '^[a-f0-9]+ (docs?|documentation)[:(]' 2>/dev/null || true)
REFACTOR_COMMITS=$(echo "$COMMITS_ONELINE" | grep -iE '^[a-f0-9]+ (refactor|clean|improve)[:(]' 2>/dev/null || true)
CHORE_COMMITS=$(echo "$COMMITS_ONELINE" | grep -iE '^[a-f0-9]+ (chore|build|ci|deps|style|test)[:(]' 2>/dev/null || true)

# Uncategorized = everything else
CATEGORIZED=$(printf '%s\n%s\n%s\n%s\n%s' "$FEAT_COMMITS" "$FIX_COMMITS" "$DOCS_COMMITS" "$REFACTOR_COMMITS" "$CHORE_COMMITS" | grep -v '^$' | awk '{print $1}' | sort -u)
OTHER_COMMITS=""
while IFS= read -r line; do
    hash=$(echo "$line" | awk '{print $1}')
    if ! echo "$CATEGORIZED" | grep -q "^${hash}$" 2>/dev/null; then
        OTHER_COMMITS="${OTHER_COMMITS}${line}\n"
    fi
done <<< "$COMMITS_ONELINE"

# Helper: format commit lines (strip hash, add bullet)
format_commits() {
    local commits="$1"
    if [ -z "$commits" ]; then
        return
    fi
    echo "$commits" | while IFS= read -r line; do
        if [ -n "$line" ]; then
            msg=$(echo "$line" | sed 's/^[a-f0-9]* //')
            echo "- $msg"
        fi
    done
}

# Build output
generate_full() {
    local version_label=""
    if [ -n "$LATEST_TAG" ]; then
        version_label=" (since $LATEST_TAG)"
    fi

    echo "# Release Note - $REPO_NAME"
    echo ""
    echo "> **Date**: $TODAY"
    echo "> **Branch**: $CURRENT_BRANCH"
    if [ -n "$LATEST_TAG" ]; then
        echo "> **Latest Tag**: $LATEST_TAG"
    fi
    echo "> **Period**: Since $SINCE_LABEL"
    echo ""
    echo "## Summary"
    echo ""
    echo "| Metric | Count |"
    echo "|--------|-------|"
    echo "| Commits | $COMMIT_COUNT |"
    echo "| Files Changed | $FILES_CHANGED |"
    echo "| Contributors | $AUTHOR_COUNT |"
    echo ""

    # Features
    if [ -n "$FEAT_COMMITS" ]; then
        echo "## New Features"
        echo ""
        format_commits "$FEAT_COMMITS"
        echo ""
    fi

    # Fixes
    if [ -n "$FIX_COMMITS" ]; then
        echo "## Bug Fixes"
        echo ""
        format_commits "$FIX_COMMITS"
        echo ""
    fi

    # Docs
    if [ -n "$DOCS_COMMITS" ]; then
        echo "## Documentation"
        echo ""
        format_commits "$DOCS_COMMITS"
        echo ""
    fi

    # Refactor
    if [ -n "$REFACTOR_COMMITS" ]; then
        echo "## Refactoring"
        echo ""
        format_commits "$REFACTOR_COMMITS"
        echo ""
    fi

    # Chores
    if [ -n "$CHORE_COMMITS" ]; then
        echo "## Maintenance"
        echo ""
        format_commits "$CHORE_COMMITS"
        echo ""
    fi

    # Other
    OTHER_CLEAN=$(echo -e "$OTHER_COMMITS" | sed '/^$/d')
    if [ -n "$OTHER_CLEAN" ]; then
        echo "## Other Changes"
        echo ""
        format_commits "$OTHER_CLEAN"
        echo ""
    fi

    # Contributors
    echo "## Contributors"
    echo ""
    echo "$AUTHORS" | while IFS= read -r author; do
        if [ -n "$author" ]; then
            echo "- $author"
        fi
    done
    echo ""

    # Files changed detail
    echo "## Files Changed"
    echo ""
    echo '```text'
    git log "$SINCE_FLAG" --no-merges --name-only --format="" 2>/dev/null | sort | uniq -c | sort -rn | head -20
    echo '```'
    echo ""

    echo "---"
    echo ""
    echo "*Generated on $TODAY by [Claude Code Documentation Standards](https://github.com/nasrulhazim/claude-docs)*"
}

generate_tldr() {
    echo "# TLDR - $REPO_NAME ($TODAY)"
    echo ""
    echo "**$COMMIT_COUNT commits** | **$FILES_CHANGED files changed** | **$AUTHOR_COUNT contributor(s)** | Since $SINCE_LABEL"
    echo ""

    if [ -n "$FEAT_COMMITS" ]; then
        local feat_count
        feat_count=$(echo "$FEAT_COMMITS" | grep -c '.' 2>/dev/null || echo 0)
        echo "**New** ($feat_count):"
        format_commits "$FEAT_COMMITS"
        echo ""
    fi

    if [ -n "$FIX_COMMITS" ]; then
        local fix_count
        fix_count=$(echo "$FIX_COMMITS" | grep -c '.' 2>/dev/null || echo 0)
        echo "**Fixed** ($fix_count):"
        format_commits "$FIX_COMMITS"
        echo ""
    fi

    # Everything else as one-liners
    local rest=""
    if [ -n "$DOCS_COMMITS" ]; then
        rest="${rest}$(format_commits "$DOCS_COMMITS")\n"
    fi
    if [ -n "$REFACTOR_COMMITS" ]; then
        rest="${rest}$(format_commits "$REFACTOR_COMMITS")\n"
    fi
    if [ -n "$CHORE_COMMITS" ]; then
        rest="${rest}$(format_commits "$CHORE_COMMITS")\n"
    fi
    OTHER_CLEAN=$(echo -e "$OTHER_COMMITS" | sed '/^$/d')
    if [ -n "$OTHER_CLEAN" ]; then
        rest="${rest}$(format_commits "$OTHER_CLEAN")\n"
    fi

    rest_clean=$(echo -e "$rest" | sed '/^$/d')
    if [ -n "$rest_clean" ]; then
        echo "**Other:**"
        echo -e "$rest_clean"
        echo ""
    fi
}

# Generate
if [ "$MODE" = "tldr" ]; then
    if [ -n "$OUTPUT_FILE" ]; then
        generate_tldr > "$OUTPUT_FILE"
        echo -e "${GREEN}TLDR release note written to $OUTPUT_FILE${NC}"
    else
        generate_tldr
    fi
else
    if [ -n "$OUTPUT_FILE" ]; then
        generate_full > "$OUTPUT_FILE"
        echo -e "${GREEN}Full release note written to $OUTPUT_FILE${NC}"
    else
        generate_full
    fi
fi
