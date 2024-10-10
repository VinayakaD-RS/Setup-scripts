#!/bin/bash

# Branch name passed as argument
branch_name="$1"

# Set your repository URL
repo_url="https://github.com/VinayakaD-RS/ui-platform-business-elements.git"

# Clone the repository
git clone $repo_url

# Change directory to the repository
cd ui-platform-business-elements

# Checkout the dev branch
git checkout release-2024-r5

# Add a remote branch
git remote add upstream https://github.com/riversandtechnologies/ui-platform-business-elements

# Fetch newly created branches from remote
git fetch upstream

# Create and checkout a new branch from 'pqr'
git checkout -b "$branch_name" upstream/release-2024-r5

# Pull from the dev branch
# git pull upstream release-2024-r5

# Push the New Branch to Your Forked Repository
git push origin "$branch_name"