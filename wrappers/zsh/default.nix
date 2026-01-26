{
  pkgs,
  lib,
  extraDeps ? [
    # ...
  ],
  extraZshrc ? "",
  ...
}:


let
  pure-prompt = pkgs.pure-prompt;

  zshrc = pkgs.writeText "zshrc" ''
    HISTFILE=$HOME/.zsh_history
    HISTSIZE=5000
    SAVEHIST=5000
    setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_no_store no_hist_beep

    autoload -Uz compinit
    compinit -C -d ~/.cache/zsh/.zcompdump
    zstyle :prompt:pure:path color none
        zstyle :prompt:pure:prompt:success color none
        zstyle :prompt:pure:prompt:error color none
        zstyle :prompt:pure:git:branch color none
        zstyle :prompt:pure:git:dirty color none
        zstyle :prompt:pure:git:action color none
        zstyle :prompt:pure:user color none
        zstyle :prompt:pure:host color none

    zstyle ':completion:*' menu select
    zstyle ':completion::complete:*' gain-privileges 1
    zstyle ':completion:*' group-name ""

    eval "$(starship init zsh)"
    eval "$(zoxide init zsh)"
    eval "$(direnv hook zsh)"

    fpath+=(${pure-prompt}/share/zsh/site-functions)
    autoload -U promptinit; promptinit
    PURE_PROMPT_SYMBOL=">"

    [[ -f ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    [[ -f ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    alias ls="eza"
    alias l="eza --tree"
    alias cat="bat --paging=never --style=plain --color=never"
    alias grep="rg"
    alias find="fd"
    alias du="dust"
    alias ps="procs"
    alias hexdump="hexyl"
    alias sed="sd"

    export EDITOR=zed

    if [[ -o interactive ]]; then
      command -v systemd-detect-virt >/dev/null &&
        [[ "$(systemd-detect-virt)" == "qemu" ]] &&
        export QEMU=1

      microfetch
    fi

    ${extraZshrc}
  '';


  zshrcDir = pkgs.runCommand "zsh-config-dir" {} ''
    mkdir -p $out
    ln -s ${zshrc} $out/.zshrc
  '';

  deps = [
    pkgs.eza
    pkgs.bat
    pkgs.ripgrep
    pkgs.fd
    pkgs.dust
    pkgs.procs
    pkgs.hexyl
    pkgs.sd
    pkgs.broot
    pkgs.atuin
    pkgs.hyperfine
    pkgs.tokei
    pkgs.fzf
    pkgs.zoxide
    pkgs.direnv
    pkgs.keychain
    pkgs.starship
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.pure-prompt
  ] ++ extraDeps;

  path = lib.makeBinPath deps;


  zsh = pkgs.stdenv.mkDerivation {
    pname = "zsh-wrapped";
    version = "0.8";

    nativeBuildInputs = [ pkgs.makeWrapper ];
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin

      makeWrapper ${pkgs.zsh}/bin/zsh $out/bin/zsh \
        --set ZDOTDIR ${zshrcDir} \
        --prefix PATH : ${path} \
        --run "if [[ \"$1\" == \"--help\" ]]; then exec ${pkgs.zsh}/bin/zsh --help; else exec ${pkgs.zsh}/bin/zsh \"\$@\"; fi"
    '';
  };
in
{
  inherit zsh;
}
