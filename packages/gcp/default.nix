{
   lib ? {},
   pkgs, 
   ... 
}:

let
  utils = import ../default.nix { inherit lib pkgs; };
  inherit (utils) mkShell;
in
{
  name = "gcp";
  
  gcp = mkShell {
    name = "gcp";
    script = ''
      #!/usr/bin/env bash

      set -euo pipefail

      VERBOSE=false
      QUIET=false
      DRY_RUN=false

      progress() {
        if [ "$QUIET" = false ]; then
          local msg="$1"
          local step="$2"
          local total="$3"
          local width=40
          local filled=$((step * width / total))
          echo -ne "\r[INFO] $msg [$step/$total] $((filled))/$total]"
        fi
      }

      log_info() {
        if [ "$QUIET" = false ]; then
          echo "[INFO] $*"
        fi
      }

      log_warn() {
        if [ "$QUIET" = false ]; then
          echo "[WARN] $*"
        fi
      }

      log_error() {
        if [ "$QUIET" = false ]; then
          echo "[ERROR] $*" >&2
        fi
      }

      log_verbose() {
        if [ "$VERBOSE" = true ] && [ "$QUIET" = false ]; then
          echo "[VERBOSE] $*"
        fi
      }

      usage() {
        echo "gcp - Git commit and push automation"
        echo ""
        echo "Usage: gcp [OPTIONS] \"commit message\""
        echo "       gcp [FLAGS]"
        echo ""
        echo "OPTIONS:"
        echo "  -v, --verbose    Enable verbose output"
        echo "  -q, --quiet      Suppress non-error output"
        echo "  -n, --dry-run    Show what would be done without executing"
        echo ""
        echo "FLAGS:"
        echo "  --user          Show environment information"
        echo "  --help          Show this help message"
        echo ""
        echo "Examples:"
        echo "  gcp \"fix: update gcp script\""
        echo "  gcp --verbose \"feat: add new feature\""
        echo "  gcp --user"
        echo ""
        echo "For more information, see: gcp(1)"
        exit 1
      }

      while [ $# -gt 0 ]; do
        case "$1" in
          -v|--verbose)
            VERBOSE=true
            shift
            ;;
          -q|--quiet)
            QUIET=true
            shift
            ;;
          -n|--dry-run)
            DRY_RUN=true
            shift
            ;;
          --user)
            check_environment
            log_info "Environment check complete"
            exit 0
            ;;
          --help)
            usage
            ;;
          -*)
            log_error "Unknown option: $1"
            usage
            ;;
          *)
            break
            ;;
        esac
      done

      check_environment() {
        log_info "Checking environment..."
        
        if ! git rev-parse --git-dir 2>/dev/null; then
          log_error "Not in a git repository"
          exit 1
        fi

        if [ "$DRY_RUN" = false ]; then
          if timeout 3 ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
            log_info "SSH key detected for GitHub"
          else
            log_warn "No SSH key configured for GitHub"
            log_info "Using HTTPS authentication"
          fi
        fi

        local user
        local remote
        user="$(git config user.name 2>/dev/null || echo "Not configured")"
        remote="$(git remote get-url origin 2>/dev/null || echo "Not configured")"
        log_info "Current user: $user"
        log_info "Current remote: $remote"
        log_verbose "Current branch: $(git branch --show-current 2>/dev/null || echo 'Unknown')"
      }

      git_add() {
        log_info "Staging all changes..."
        if [ "$DRY_RUN" = true ]; then
          log_verbose "Would run: git add --all"
          return 0
        fi
    
        if ! git add --all; then
          log_error "Failed to stage changes"
          exit 1
        fi
        log_verbose "Staged $(git status --porcelain | wc -l) files"
      }

      git_commit() {
        local message="$*"
        log_info "Creating commit..."
    
        if [ "$DRY_RUN" = true ]; then
          log_verbose "Would run: git commit --allow-empty -m \"$message\""
          return 0
        fi
    
        if ! git commit --allow-empty -m "$message"; then
          log_error "Failed to create commit"
          exit 1
        fi
        log_verbose "Commit created: $(git rev-parse --short HEAD)"
      }

      git_push() {
        log_info "Pushing to remote repository..."
    
        if [ "$DRY_RUN" = true ]; then
          log_verbose "Would run: git push --force-with-lease"
          return 0
        fi
    
        if ! git push --force-with-lease; then
          log_warn "Push failed, attempting automatic rebase..."
          if ! git pull --rebase; then
            log_error "Rebase failed - please resolve conflicts manually"
            exit 1
          fi
          log_info "Rebase successful, retrying push..."
          if ! git push --force-with-lease; then
            log_error "Push failed after rebase"
            exit 1
          fi
        fi
        log_verbose "Pushed to $(git remote get-url origin)"
      }

      main() {
        if [ $# -eq 0 ]; then
          usage
        fi

        if [ "$1" = "--user" ]; then
          check_environment
          log_info "Environment check complete"
          exit 0
        fi

        local total_steps=3
        local current_step=0

        check_environment
    
        current_step=$((current_step + 1))
        progress "Git operations" "$current_step" "$total_steps"
        git_add "$@"
    
        current_step=$((current_step + 1))
        progress "Git operations" "$current_step" "$total_steps"
        git_commit "$@"
    
        current_step=$((current_step + 1))
        progress "Git operations" "$current_step" "$total_steps"
        git_push

        echo # New line after progress
        if [ "$DRY_RUN" = true ]; then
          log_info "Dry run completed successfully"
        else
          log_info "All operations completed successfully"
        fi
      }

      main "$@"
    '';
  };
}
