#!/bin/bash

listFilesAndDirectories() {
    path="$1"
    i=0

    # Check if the path is a directory
    if [ -d "$path" ]; then
        # Read each entry in the directory
        for entry in "$path"/*; do
            # Extract the entry name
            entry_name=$(basename "$entry")

            # Ignore entries "." and ".."
            if [ "$entry_name" = "." ] || [ "$entry_name" = ".." ]; then
                continue
            fi

            # Check if the entry is a directory
            if [ -d "$entry" ]; then
                echo "[$((++i))][DIR] $entry_name"
            else
                echo "[$((++i))][FIL] $entry_name"
            fi
        done
    else
        echo "Error: Not a directory - $path"
    fi
}

moveToDirectory() {
    path="$1"
    name="$2"
    i=0
    found=0
    targetPath=""

    # Check if the path is a directory
    if [ -d "$path" ]; then
        # Find the selected entry
        for entry in "$path"/*; do
            # Extract the entry name
            entry_name=$(basename "$entry")

            # Ignore entries "." and ".."
            if [ "$entry_name" = "." ] || [ "$entry_name" = ".." ]; then
                continue
            fi

            if [ $((++i)) -eq "$name" ] || [ "$entry_name" = "$name" ]; then
                found=1
                targetPath="$entry"
                break
            fi
        done
    else
        echo "Error: Not a directory - $path"
        return 1
    fi

    # Move to the selected directory or open the file with nano
    if [ $found -eq 1 ]; then
        if [ -d "$targetPath" ]; then
            echo "cd $targetPath"
            cd "$targetPath" || {
                echo "Error changing directory"
                return
            }
        else
            echo "Opening file with nano: $targetPath"
            nano "$targetPath"
        fi
    else
        echo "Error: Directory or file not found"
        return 1
    fi
}

main() {
    path="."

    if [ "$#" -eq 0 ]; then
        listFilesAndDirectories "$path"
    elif [[ "$1" =~ ^[0-9]+$ ]]; then
        moveToDirectory "$path" "$1"
    else
        echo "Usage: $0 [directory_path]"
        return 1
    fi
}

# Run the main function with command line arguments
main "$@"

