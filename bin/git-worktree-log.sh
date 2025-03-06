#!/bin/bash
# git-worktree-log - Display git log with worktree information
set -euo pipefail

# Get all worktrees
echo "=== Git Worktrees ==="
git worktree list

# Get the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo -e "\n=== Current Branch: $current_branch ==="

# Show log for the current branch
echo -e "\n=== Recent Commits on $current_branch ==="
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s - %C(yellow)%aN%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative -10

# List all branches
echo -e "\n=== All Branches ==="
git branch -a