{ pkgs }:

pkgs.writeShellScriptBin "gcp" ''
  #!/usr/bin/env bash

  # Check for commit message
  if [ -z "$1" ]; then
    echo "Usage: gcp \"commit message\""
    exit 1
  fi

  # Stage all changes
  git add --all

  # Commit (allow empty)
  git commit --allow-empty -m "$*"
  if [ $? -ne 0 ]; then
    echo "Nothing to commit"
    exit 0
  fi

  # Push safely
  git push --force-with-lease
  if [ $? -ne 0 ]; then
    echo "Push failed, attempting 'git pull --rebase'..."
    git pull --rebase
    if [ $? -ne 0 ]; then
      echo "Rebase failed. Resolve conflicts manually."
      exit 1
    fi
    echo "Rebase successful, retrying push..."
    git push --force-with-lease
    if [ $? -ne 0 ]; then
      echo "Push still failed. Aborting."
      exit 1
    fi
  fi

  echo "Commit and push successful."
''
