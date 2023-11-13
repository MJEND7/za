#!/bin/bash

CONFIG_FILE="../za_config"

# Check if the configuration file exists
if [ -f "$CONFIG_FILE" ]; then
    # Source the configuration file to set the EDITOR_COMMAND
    source "$CONFIG_FILE"
else
    # If the configuration file doesn't exist, create it with the default editor command
    echo "EDITOR_COMMAND=nano" >"$CONFIG_FILE"
    source "$CONFIG_FILE"
fi

VERSION="0.2"

showVersion() {
    echo "v$VERSION"
}

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
            $EDITOR_COMMAND "$targetPath" # Use the configured editor command
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
    elif [ "$1" = "-v" ] || [ "$1" = "--version" ]; then
        showVersion
    elif [[ "$1" = "-ce" ]]; then
        # Check if the editor command is provided
        if [ -n "$2" ]; then
            # Update the configuration file with the new editor command
            echo "EDITOR_COMMAND=$2" >"$CONFIG_FILE"
            source "$CONFIG_FILE"
        else
            echo "Error: No editor command provided"
            return 1
        fi
    elif [[ -n "$1" ]]; then
        moveToDirectory "$path" "$1"
    else
        echo "Usage: $0 [directory_path]"
        return 1
    fi
}

# Run the main function with command line arguments
main "$@"
