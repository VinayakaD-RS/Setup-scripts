#!/bin/bash

# repo name passed as argument
repo_name="$1"

# Set your repository URL
repo_url=""

# Change directory to the repository
cd ../$repo_name

# Set upstream
git remote set-url upstream git@github.com-work:riversandtechnologies/$repo_name.git