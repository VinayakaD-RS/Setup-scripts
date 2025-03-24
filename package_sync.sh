#!/bin/bash

# Define variables for the source and target directories
UI_PLATFORM_PATH="D:/Repositories/ui-platform"
UI_PLATFORM_BUSINESS_ELEMENTS_PATH="D:/Repositories/ui-platform-business-elements"
UI_PLATFORM_ELEMENTS_PATH="D:/Repositories/ui-platform-elements"
UI_PLATFORM_BUSINESS_ELEMENTS="ui-platform-business-elements"
UI_PLATFORM_ELEMENTS="ui-platform-elements"

# Define multiple source directories and their corresponding target directories
declare -A PACKAGES_PATH
PACKAGES_PATH[$UI_PLATFORM_BUSINESS_ELEMENTS_PATH]="$UI_PLATFORM_PATH/node_modules/$UI_PLATFORM_BUSINESS_ELEMENTS/lib"
PACKAGES_PATH[$UI_PLATFORM_ELEMENTS_PATH]="$UI_PLATFORM_PATH/node_modules/$UI_PLATFORM_ELEMENTS/lib"

# Loop through each repo
for PKG_PATH in "${!PACKAGES_PATH[@]}"; do
    TARGET_DIR="${PACKAGES_PATH[$PKG_PATH]}"

    echo "Syncing from $PKG_PATH to $TARGET_DIR..."
    echo ""

    # Ensure the target directory exists
    mkdir -p "$TARGET_DIR"

    # Move to the business repo
    cd "$PKG_PATH" || { echo "Error: Cannot access $PKG_PATH"; exit 1; }
    echo ""

    # Get all modified and new files
    changed_files=$(git status --porcelain | awk '{print $1, $2}')

    # Process each file
    while read -r status file; do
        # Remove 'src/' from the path
        relative_path="${file#src/}"

        # Get full path in node_modules
        destination="$TARGET_DIR/$relative_path"

            # Ensure the destination folder exists
            mkdir -p "$(dirname "$destination")"

            # Copy the changed file
           if [ -d "$file" ]; then
                # If it's a directory, copy it recursively
                cp -r "$file" "$destination"
                echo "Updated (dir): $destination"
            else
                # If it's a file, copy it normally
                cp "$file" "$destination"
                echo "Updated (file): $destination"
            fi
    done <<< $changed_files

    echo ""
    echo "Sync completed for $PKG_PATH."
    echo ""
    echo ""
done

echo "All packages synced!"