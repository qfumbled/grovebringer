{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  funkouna = {
    programs = {
      hyprland.enable = true;
      fuzzel.enable = true;
      mako.enable = true;
      waybar.enable = true;
    };
  };
  
  sops.secrets.test-secret = {};
  
  sops.secrets.github-ssh-key = {
    mode = "600";
    owner = "xekuri";
    path = "${config.home.homeDirectory}/.ssh/id_github";
  };
  
  home.packages = with pkgs; [
    foot
    sops
    app2unit
    statix
    asciinema_3
    bitwarden-desktop
    bore-cli
    circumflex
    clipse
    colordiff
    deadnix
    delta
    doggo
    eza
    fd
    feh
    fx
    fzf
    gcc
    gh
    git-absorb
    gitmoji-cli
    glab
    glow
    gnumake
    go
    gping
    grimblast
    gum
    helmfile
    httpie
    imagemagick
    inotify-tools
    jq
    jqp
    just
    k9s
    keybase
    kubecolor
    kubectl
    kubectx
    kubernetes-helm
    light
    magic-wormhole
    material-symbols
    mods
    navi
    nemo
    networkmanagerapplet
    nh
    nix-fast-build
    nix-inspect
    nix-output-monitor
    nix-search-tv
    nix-update
    nixfmt-rfc-style
    onefetch
    opencode
    openssl
    opkssh
    pavucontrol
    pfetch
    pgcli
    pinentry-gnome3
    playerctl
    pre-commit
    presenterm
    python312Packages.gst-python
    python312Packages.materialyoucolor
    python312Packages.pillow
    python312Packages.pip
    python312Packages.pygobject3
    python312Packages.setuptools
    python312Packages.virtualenv
    satty
    starship
    stern
    syncthing
    tldr
    up
    vlc
    wireplumber
    xdotool
    xwayland
  ];
}