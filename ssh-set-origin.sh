#!/bin/bash

# repo name passed as argument
repo_name="$1"

# Set your repository URL
repo_url=""

# Change directory to the repository
cd ../$repo_name

# Set origin
git remote set-url origin git@github.com-work:VinayakaD-RS/$repo_name.git