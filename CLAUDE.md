# CLAUDE.md - Repository Guidelines

## Build/Test/Lint Commands
- Basic shell commands: `bash script_name.sh`
- Bazel commands: `bb='bazel build ...'`, `bt='bazel test ... --test_output=errors'`
- Vim linting via ALE plugin; see `.vimrc`
- Git commit helper: `bin/git-auto-commit-message [--auto] [--non-interactive]`

## Code Style Guidelines
- **Shell Scripts**: 
  - Use `#!/bin/bash` with `set -eu` or `set -euo pipefail`
  - Include usage comments at top
  - Use meaningful lowercase hyphenated filenames
  - Exit with proper codes for error handling

- **Git Style**:
  - Sign commits when possible
  - Prefer rebasing workflow
  - Use concise commit messages following repository style
  - Group related changes in single commits

- **Formatting**:
  - Indent with 4 spaces
  - UTF-8 encoding
  - Max line length ~80-100 characters
  - Use consistent braces and spacing

- **Organization**:
  - Bin scripts in `~/go/src/github.com/tmc/dotfiles/bin/`
  - Config files in repo root
  - Symlink to user's home directory