# Git Hider

A simple utility script to temporarily hide and unhide files in a Git repository without removing them from your local filesystem.

## Overview

Git Hider uses Git's `update-index --skip-worktree` feature to tell Git to ignore changes to specific files while keeping them in your working directory. This is useful when you need to make local-only changes to configuration files or other tracked files that you don't want to commit.

## Dependencies

- `git` - Version control system
- `fzf` - Command-line fuzzy finder

## Installation

### Prerequisites

Make sure you have the required dependencies installed:

```bash
# macOS (using Homebrew)
brew install git fzf

# Debian/Ubuntu
sudo apt install git fzf

# Fedora
sudo dnf install git fzf
```

### Setup

1. Download the script:
   ```bash
   curl -o git-hider.sh https://raw.githubusercontent.com/yourusername/git-hider/main/git-hider.sh
   ```

2. Make it executable:
   ```bash
   chmod +x git-hider.sh
   ```

3. Optional: Move to your PATH for global access:
   ```bash
   sudo mv git-hider.sh /usr/local/bin/git-hider
   ```

## Usage

Run the script from within any Git repository:

```bash
./git-hider.sh
# Or if installed globally:
git-hider
# or you can make an alias:
alias githider='~/git-hider.sh'
githider
```

### Available Options

The interactive menu provides the following options:

1. **List changed files** - Shows files that have been modified in your working directory
   - Select a file to hide it from Git

2. **List hidden files** - Shows files that are currently hidden from Git
   - Select a file to unhide it (make it visible to Git again)

3. **Search for files** - Find specific files to hide or unhide using fuzzy search

## How It Works

Git Hider uses Git's `update-index --skip-worktree` flag to mark files as "skip-worktree", which tells Git to:

- Pretend the file is unchanged even when it has local modifications
- Skip checking for changes in the working tree

To unhide files, it uses `update-index --no-skip-worktree` to resume normal Git tracking.

## Use Cases

- Making local changes to configuration files without committing them
- Temporarily modifying tracked files for testing
- Keeping sensitive information local while sharing the repository

## License

[MIT License](LICENSE)
