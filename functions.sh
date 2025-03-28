#!/bin/bash

set_skip_worktree() {
    file="$1"
    echo "Will now hide changes from $file"
    git update-index --skip-worktree "$file"
}

remove_skip_worktree() {
    file="$1"
    echo "Will now show changes from $file"
    git update-index --no-skip-worktree "$file"
}
