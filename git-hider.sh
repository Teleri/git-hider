#!/bin/bash

# Source the other script files
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
source "$SCRIPT_DIR/functions.sh"
source "$SCRIPT_DIR/menu-options.sh"

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
            choose_file_to_hide_or_show
            ;;
        *)
            echo "Invalid choice."
            exit 1
            ;;
    esac
}

search_files
