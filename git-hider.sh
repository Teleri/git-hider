#!/bin/bash

search_files() {
    echo "Choose an option:"
    choice=$(echo -e "Choose a file to hide or show\nList Hidden files\nList Changed files" | fzf --header="Choose an option:")

    case "$choice" in
        List\ Hidden\ files)
            list_hidden_files
            ;;
        List\ Changed\ files)
            list_changed_files
            ;;
        Choose\ a\ file\ to\ hide\ or\ show)
            file=$(find . -type f | fzf)

            if [[ -z "$file" ]]; then
                echo "No file selected."
                exit 1
            fi

            echo "Choose an action:"
            action=$(echo -e "Hide file\nShow file" | fzf --header="Choose an action:")

            case "$action" in
                Hide\ file)
                    set_skip_worktree "$file"
                    ;;
                Show\ file)
                    remove_skip_worktree "$file"
                    ;;
                *)
                    echo "Invalid action."
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo "Invalid choice."
            exit 1
            ;;
    esac
}

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

list_hidden_files() {
    hidden_files=$(git ls-files -v | grep '^S' | awk '{print $2}')

    if [[ -z "$hidden_files" ]]; then
        echo "No hidden files."
        exit 0
    fi

    selected_files=$(echo "$hidden_files" | fzf --multi --header="Press TAB to select multiple files")

    if [[ -z "$selected_files" ]]; then
        echo "No hidden file selected."
        exit 1
    fi

    for file in $selected_files; do
        remove_skip_worktree "$file"
    done
}

list_changed_files() {
    changed_files=$(git status --porcelain | grep '^[ M]' | awk '{print $2}')

    if [[ -z "$changed_files" ]]; then
        echo "No changed files."
        exit 0
    fi

    selected_files=$(echo "$changed_files" | fzf --multi --header="Press TAB to select multiple files")

    if [[ -z "$selected_files" ]]; then
        echo "No changed file selected."
        exit 1
    fi

    for file in $selected_files; do
        set_skip_worktree "$file"
    done
}

search_files
