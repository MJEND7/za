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
                echo "[$((++i))][+] $entry_name"
            else
                echo "[$((++i))][-] $entry_name"
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
        if [ "$name" = ".." ]; then
            found=1
            targetPath=".."
        else
            # Find the selected entry
            for entry in "$path"/*; do
                # Extract the entry name
                entry_name=$(basename "$entry")

                # Ignore entries "." and ".."
                if [ "$entry_name" = "." ] || [ "$entry_name" = ".." ]; then
                    continue
                fi

                if [ "$((++i))" == "$name" ] || [ "$entry_name" = "$name" ]; then
                    found=1
                    targetPath="$entry"
                    break
                fi
            done
        fi

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

showHelp() {
    echo "
 ________  ________     
|\_____  \|\   __  \    
 \|___/  /\ \  \|\  \   
     /  / /\ \   __  \  
    /  /_/__\ \  \ \  \ 
   |\________\ \__\ \__\

    \|_______|\|__|\|__|
"
    echo "-----------------------------------------------------------------------------------"
    echo "  za                   - List files and directories in the current directory."
    echo "  za [name | number]   - Move to the specified directory or open the file with nano."
    echo "                         Use '+' to indicate a folder and '-' for a file."
    echo ""
    echo "  za help              - Show this help message."
    echo ""
    echo "-----------------------------------------------------------------------------------"
}

main() {
    path="."

    if [ "$#" -eq 0 ]; then
        listFilesAndDirectories "$path"
    elif [ "$1" = "help" ]; then
        showHelp
    elif [[ -n "$1" ]]; then
        moveToDirectory "$path" "$1"
    else
        echo "Usage: $0 [directory_path]"
        return 1
    fi
}

# Run the main function with command line arguments
main "$@"
