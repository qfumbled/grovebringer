{ pkgs }:

pkgs.writeShellApplication {
  name = "gcp";
  text = ''
    #!/usr/bin/env bash

    # Safety and error handling
    set -euo pipefail

    # Usage information
    usage() {
      echo "gcp - Git commit and push automation"
      echo ""
      echo "Usage: gcp \"commit message\""
      echo "Example: gcp \"fix: update gcp script\""
      echo ""
      exit 1
    }

    # Environment and user checks
    check_environment() {
      echo "[INFO] Checking environment..."
      
      # Check if git repository
      if ! git rev-parse --git-dir 2>/dev/null; then
        echo "[ERROR] Not in a git repository"
        exit 1
      fi

      # Check for SSH key
      if ! ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        echo "[WARN] No SSH key configured for GitHub"
        echo "[INFO] Using HTTPS authentication"
      else
        echo "[INFO] SSH key detected for GitHub"
      fi

      # Show current user and remote
      echo "[INFO] Current user: $(git config user.name 2>/dev/null || echo 'Not configured')"
      echo "[INFO] Current remote: $(git remote get-url origin 2>/dev/null || echo 'Not configured')"
    }

    # Validate input
    if [ $# -eq 0 ]; then
      usage
    fi

    # Environment check
    check_environment

    # Git operations with comprehensive error handling
    echo "[INFO] Staging all changes..."
    if ! git add --all; then
      echo "[ERROR] Failed to stage changes"
      exit 1
    fi

    echo "[INFO] Creating commit with message: $*"
    if ! git commit --allow-empty -m "$*"; then
      echo "[ERROR] Failed to create commit"
      exit 1
    fi

    echo "[INFO] Pushing to remote repository..."
    if ! git push --force-with-lease; then
      echo "[WARN] Push failed, attempting automatic rebase..."
      if ! git pull --rebase; then
        echo "[ERROR] Rebase failed - please resolve conflicts manually"
        exit 1
      fi
      echo "[INFO] Rebase successful, retrying push..."
      if ! git push --force-with-lease; then
        echo "[ERROR] Push failed after rebase"
        exit 1
      fi
    fi

    echo "[SUCCESS] All operations completed successfully"
  '';
}
