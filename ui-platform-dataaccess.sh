#!/bin/bash

# Branch name passed as argument
branch_name="$1"

# Set your repository URL
repo_url="https://github.com/VinayakaD-RS/ui-platform-dataaccess.git"

# Clone the repository
git clone $repo_url

# Change directory to the repository
cd ui-platform-dataaccess

# Checkout the release-2024-r5 branch
git checkout release-2024-r5

# Add a remote branch
git remote add upstream https://github.com/riversandtechnologies/ui-platform-dataaccess

# Fetch newly created branches from remote
git fetch upstream


# Create and checkout a new branch from 'release-2024-r5'
git checkout -b "$branch_name" upstream/release-2024-r5

# Pull from the branch
$branch_name

# Pull from the release-2024-r5 branch
# git pull upstream release-2024-r5

# Push the New Branch to Your Forked Repository
git push origin "$branch_name"
