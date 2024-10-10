#!/bin/bash

# Define the paths
sourcePath="/d/Repositories/app-ml-services/ui/dist/lib"
destinationPath="/d/Repositories/ui-platform/plugin-src/mlservice"

# Remove the existing folders in the destination path
if [ -d "$destinationPath" ]; then
    rm -rf "$destinationPath"/*
    echo "Deleted existing folders in $destinationPath"
else
    echo "Destination path $destinationPath does not exist"
    exit 1
fi

# Copy the folders from the source path to the destination path
if [ -d "$sourcePath" ]; then
    cp -r "$sourcePath"/* "$destinationPath"
    echo "Copied folders from $sourcePath to $destinationPath"
else
    echo "Source path $sourcePath does not exist"
    exit 1
fi
