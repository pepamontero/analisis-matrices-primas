#!/bin/bash
# Run this BEFORE pulling

git fetch
if git diff --name-only origin/main | grep -q '^environment.yml$'; then
  echo "environment.yml has changed in the remote repo."
  echo "Consider running ./sync_env.sh after pulling."
else
  echo "environment.yml has not changed."
  echo "You can pull safely."
fi
