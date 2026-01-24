{
  pkgs,
  lib,
  ...
}:

let
  script = ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    declare -r VERSION="0.0.1"
    declare -r LOCKFILE="''${XDG_RUNTIME_DIR:-/tmp}/njem.lock"
    
    # Auto-detect NJEM_DIR
    if [[ -n "''${NJEM_DIR:-}" ]]; then
      declare -r NJEM_DIR="$NJEM_DIR"
    elif git rev-parse --show-toplevel &>/dev/null; then
      declare -r NJEM_DIR=$(git rev-parse --show-toplevel)
    else
      declare -r NJEM_DIR=$(pwd)
    fi
    
    declare -r NJEM_HOST="''${NJEM_HOST:-$(hostname)}"
    declare -r NJEM_ROLE="''${NJEM_ROLE:-laptop}"

    # Colors
    declare -r RED='\033[0;31m' GREEN='\033[0;32m' YELLOW='\033[1;33m'
    declare -r BLUE='\033[0;34m' CYAN='\033[0;36m' NC='\033[0m'

    log() { echo -e "''${BLUE}[njem]''${NC} $1"; }
    ok() { echo -e "''${GREEN}[njem]''${NC} $1"; }
    err() { echo -e "''${RED}[njem]''${NC} $1" >&2; }

    # Cleanup
    trap 'rm -f "$LOCKFILE"' EXIT
    acquire_lock() {
      if [[ -f "$LOCKFILE" ]]; then
        err "Another instance is running (PID: $(cat "$LOCKFILE"))"
        exit 1
      fi
      echo $$ > "$LOCKFILE"
    }

    get_flake() {
      if [[ -n "''${NJEM_FLAKE:-}" ]]; then
        echo "$NJEM_FLAKE"
      else
        if [[ ! -f "$NJEM_DIR/flake.nix" ]]; then
          err "No flake.nix found in $NJEM_DIR"
          exit 1
        fi
        echo ".#''${NJEM_HOST}"
      fi
    }

    in_dir() {
      (
        cd "$NJEM_DIR" || { err "Cannot enter $NJEM_DIR"; exit 1; }
        "$@"
      )
    }

    usage() {
      cat <<EOF
    njem v''${VERSION}

    Usage: njem <command> [args...]

    Commands:
      test              Test configuration (no boot entry)
      switch            Switch to configuration
      boot              Build for next boot only
      commit [-m msg]   Switch, format, fix perms, git commit
      update [inputs]   Update flake.lock
      format            Format all .nix files
      perms             Fix permissions (600 files, 700 dirs)
      purge             Garbage collect old generations
      repair            Repair nix store
      edit <vars|sops>  Edit variables or secrets
      help              Show this help

    Options:
      --fast            Fast rebuild (implies --no-reexec)
      --verbose         Verbose output

    Environment:
      NJEM_DIR          Flake directory (auto-detected)
      NJEM_HOST         Hostname for flake (default: $(hostname))
      NJEM_FLAKE        Full flake URI (e.g., .#desktop)

    Examples:
      njem switch                    # Build .#$(hostname)
      njem switch --fast             # Fast rebuild with --no-reexec
      njem commit -m "update deps"
      njem git status                # Dispatch to git
    EOF
    }

    rebuild() {
      local action="$1"
      shift
      local flake=$(get_flake)
      local cmd=(sudo nixos-rebuild "$action" --flake "$flake")
      
      # Parse options - note: --fast implies --no-reexec
      local use_fast=false
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --fast) 
            use_fast=true
            cmd+=("--fast" "--no-reexec")
            ;;
          --no-reexec) 
            # Only add if not already added by --fast
            [[ "$use_fast" == false ]] && cmd+=("$1")
            ;;
          --verbose|--quiet|--show-trace|--impure|--recreate-lock-file|--refresh|--offline)
            cmd+=("$1") 
            ;;
          *) 
            err "Unknown option: $1"
            exit 1
            ;;
        esac
        shift
      done
      
      log "Running: ''${cmd[*]}"
      "''${cmd[@]}"
    }

    cmd_test() {
      acquire_lock
      rebuild test "$@"
      ok "Test complete"
    }

    cmd_switch() {
      acquire_lock
      # Auto-format before building
      in_dir nixfmt . 2>/dev/null || true
      rebuild switch "$@"
      ok "Switch complete"
    }

    cmd_boot() {
      acquire_lock
      rebuild boot "$@"
      ok "Boot entry created"
    }

    cmd_commit() {
      [[ "$NJEM_ROLE" == "server" ]] && { err "commit not available for server"; exit 1; }
      
      local msg=""
      if [[ "$1" == "-m" ]]; then
        msg="$2"
        shift 2
      fi
      
      cmd_switch "$@"
      
      log "Fixing permissions..."
      find "$NJEM_DIR" -type f -name '*.nix' -exec chmod 600 {} + 2>/dev/null || true
      find "$NJEM_DIR" -type d -exec chmod 700 {} + 2>/dev/null || true
      
      log "Committing..."
      in_dir git add -A
      if [[ -z "$msg" ]]; then
        in_dir git commit || true
      else
        in_dir git commit -m "$msg" || true
      fi
    }

    cmd_update() {
      acquire_lock
      if [[ $# -eq 0 ]]; then
        log "Updating all inputs..."
        in_dir nix flake update
      else
        for input; do
          log "Updating $input..."
          in_dir nix flake lock --update-input "$input"
        done
      fi
      ok "Lockfile updated"
    }

    cmd_format() {
      log "Formatting..."
      in_dir find . -name '*.nix' -exec nixfmt {} +
      ok "Formatted"
    }

    cmd_perms() {
      log "Setting permissions..."
      find "$NJEM_DIR" -type f -exec chmod 600 {} +
      find "$NJEM_DIR" -type d -exec chmod 700 {} +
      ok "Permissions fixed"
    }

    cmd_purge() {
      acquire_lock
      read -p "Delete all old generations? [y/N] " -n 1 -r
      echo
      [[ $REPLY =~ ^[Yy]$ ]] || exit 0
      sudo nix-env --delete-generations old
      sudo nix-collect-garbage -d
      ok "Purge complete"
    }

    cmd_repair() {
      acquire_lock
      sudo nix-store --verify --check-contents --repair
      ok "Repair complete"
    }

    cmd_edit() {
      case "$1" in
        vars)
          local f="$NJEM_DIR/vars.nix"
          [[ -f "$f" ]] || f="$NJEM_DIR/variables.nix"
          [[ -f "$f" ]] || { err "No vars file found"; exit 1; }
          ''${EDITOR:-nano} "$f"
          ;;
        sops)
          local f=$(find "$NJEM_DIR/secrets" -name "*.yaml" -o -name "*.yml" 2>/dev/null | head -1)
          [[ -n "$f" ]] || { err "No secrets found"; exit 1; }
          sops "$f"
          ;;
        *) err "Usage: njem edit <vars|sops>"; exit 1 ;;
      esac
    }

    main() {
      local cmd="''${1:-}"
      shift || true

      case "$cmd" in
        ""|help|-h) usage ;;
        test) cmd_test "$@" ;;
        switch) cmd_switch "$@" ;;
        boot) cmd_boot "$@" ;;
        commit) cmd_commit "$@" ;;
        update) cmd_update "$@" ;;
        format) cmd_format ;;
        perms) cmd_perms ;;
        purge|gc|clean) cmd_purge ;;
        repair) cmd_repair ;;
        edit) cmd_edit "$@" ;;
        *)
          if in_dir command -v "$cmd" &>/dev/null; then
            in_dir "$cmd" "$@"
          else
            err "Unknown command: $cmd"
            exit 1
          fi
          ;;
      esac
    }

    main "$@"
  '';

in
{
  njem = pkgs.writeShellScriptBin "njem" script;
}
