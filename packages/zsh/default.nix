{
  pkgs,
  lib,
  extraZshrc ? "",
  extraDeps ? [],
  ...
}:
let
  zshrc = pkgs.writeText "zshrc" ''
    HISTFILE=$HOME/.zsh_history
    HISTSIZE=5000
    SAVEHIST=5000
    HISTDUP=erase
    setopt appendhistory sharehistory
    setopt hist_ignore_space hist_ignore_all_dups
    setopt hist_save_no_dups hist_no_store
    setopt no_hist_beep


    autoload -Uz compinit
    compinit -d ~/.cache/zsh/.zcompdump

    zstyle ':completion:*' menu select
    zstyle ':completion::complete:*' gain-privileges 1
    zstyle ':completion:*' group-name ""

    eval "$(starship init zsh)"

    unsetopt autocd beep notify
    bindkey -v


    eval "$(zoxide init zsh)"
    eval "$(direnv hook zsh)"
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    alias v="zed"
    alias :q="exit"
    alias cat="bat --paging=never"
    alias cleanram="sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'"
    alias cleanup="sudo nix-collect-garbage --delete-older-than 1d"
    alias du="dust"
    alias g="git"
    alias la="ll -a"
    alias ll="ls -l --time-style long-iso --icons"
    alias ls="eza"
    alias tb="toggle-background"
    alias tree="eza --tree --icons"

    # Nix
    alias nrb-cherry='sudo nixos-rebuild switch --flake .#cherries'
    alias nrb-fast-cherry='sudo nixos-rebuild switch --flake .#cherries --no-reexec'


    bak() {
      [[ "$#" -ne 1 ]] && echo "Usage: bak <file>" && return 1
      local file_arg="$1"
      local base_file
      [[ "$file_arg" == *.bak ]] && base_file="''${file_arg%.bak}" || base_file="$file_arg"
      local bak_file="$base_file.bak"

      if [[ -e "$file_arg" ]]; then
        if [[ -e "$bak_file" && "$file_arg" != "$bak_file" ]]; then
          mv "$file_arg" "$bak_file.tmp" &&
          mv "$bak_file" "$file_arg" &&
          mv "$bak_file.tmp" "$bak_file"
        else
          mv "$file_arg" "$bak_file"
        fi
      elif [[ -e "$bak_file" ]]; then
        mv "$bak_file" "$file_arg"
      else
        echo "Neither '$file_arg' nor '$bak_file' exist."
        return 1
      fi
    }

    ex() {
      [[ ! -f "$1" ]] && echo "'$1' is not a valid file." && return 1
      case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz)   tar xzf "$1" ;;
        *.tar.xz)         tar xf "$1" ;;
        *.zip)            unzip "$1" ;;
        *.rar)            unrar x "$1" ;;
        *.7z)             7z x "$1" ;;
        *)                echo "'$1' cannot be extracted." ;;
      esac
    }

    refresh() {
      source "$ZDOTDIR/.zshrc"
    }

    mkcd() {
      mkdir -p -- "$1" && builtin cd -- "$1"
    }

    ..() {
      local n="''${1:-1}"
      local path=""
      for _ in $(seq 1 "$n"); do path="../$path"; done
      builtin cd "$path"
    }

    lu() {
      history | grep -i "''${1:-}"
    }

    cd() {
      builtin cd "$@" || return
      if git rev-parse --is-inside-work-tree &>/dev/null; then
        local repo
        repo=$(basename "$(git rev-parse --show-toplevel)")
        [[ "$repo" != "$LAST_REPO" ]] && onefetch && LAST_REPO="$repo"
      fi
    }

    export EDITOR=zed

    if [[ -o interactive ]]; then
      command -v systemd-detect-virt >/dev/null &&
        [[ "$(systemd-detect-virt)" == "qemu" ]] &&
        export QEMU=1
      fastfetch
    fi

    typeset -gA abbreviations

    ''${extraZshrc}
  '';

  zshrcDir = pkgs.runCommand "zsh-config-dir" {} ''
    mkdir -p $out
    ln -s ${zshrc} $out/.zshrc
  '';

  deps = [
    pkgs.fzf
    pkgs.zoxide
    pkgs.direnv
    pkgs.bat
    pkgs.dust
    pkgs.eza
    pkgs.onefetch
    pkgs.keychain
    pkgs.starship
    pkgs.zsh-syntax-highlighting
  ] ++ extraDeps;

  path = lib.makeBinPath deps;

  zsh = pkgs.stdenv.mkDerivation {
    pname = "zsh-wrapped";
    version = "0.3";
    nativeBuildInputs = [ pkgs.makeWrapper ];
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.zsh}/bin/zsh $out/bin/zsh \
        --set ZDOTDIR ${zshrcDir} \
        --prefix PATH : ${path}
    '';
  };
in
{
  inherit zsh;
}
