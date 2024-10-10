#!/bin/bash

# Branch name passed as argument
branch_name="$1"

# Set your repository URL
repo_url="https://github.com/VinayakaD-RS/ui-platform-servers.git"

# Clone the repository
git clone $repo_url

# Change directory to the repository
cd ui-platform-servers

# Checkout the dev branch
git checkout dev

# Add a remote branch
git remote add upstream https://github.com/riversandtechnologies/ui-platform-servers

# Fetch newly created branches from remote
git fetch upstream

# Create and checkout a new branch from 'pqr'
git checkout -b "$branch_name" upstream/dev

# Push the New Branch to Your Forked Repository
git push origin "$branch_name"

# Pull from the dev branch
# git pull upstream dev
