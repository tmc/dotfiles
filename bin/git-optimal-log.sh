#!/bin/bash
# git-optimal-log - Show a well-formatted git log with useful information
set -euo pipefail

# Default number of commits to show
N=${1:-20}

# Show a nicely formatted log with concise but complete information
git log -n "$N" --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative