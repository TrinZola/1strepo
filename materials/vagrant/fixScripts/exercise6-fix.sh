#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 destination_folder"
    exit 1
fi

destination_folder="${!#}"  # Get the last argument

# Get a list of all files in the current directory (excluding the script)
files_to_copy=$(ls -p | grep -v / | grep -v "$0")

total_bytes_copied=0

# Loop through all files to copy
for file_name in $files_to_copy; do
    file_path="$PWD/$file_name"
    destination_path="$destination_folder/$file_name"

    cp -p "$file_path" "$destination_path"  # -p preserves file metadata
    if [ $? -eq 0 ]; then
        echo "Copied: $file_path to $destination_path"
        total_bytes_copied=$((total_bytes_copied + $(stat -c %s "$file_path")))
    else
        echo "Error copying $file_path"
    fi
done

echo $total_bytes_copied
