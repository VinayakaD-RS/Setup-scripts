#!/bin/bash

# Directory containing all the bash scripts
scripts_dir="scripts"

# Branch name
branch_name="feature_name"

# Iterate over all files in the scripts directory
for script_file in "$scripts_dir"/*.sh; do
    # Check if the file is a regular file and executable
    if [ -f "$script_file" ] && [ -x "$script_file" ]; then
        # Execute the script with the branch name argument
        echo "Executing $script_file"
        "$script_file" "$branch_name"
    fi
done
