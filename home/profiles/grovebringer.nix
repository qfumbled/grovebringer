{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;

  # Wayland environment variables with X11 fallback
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "KDE";
    XDG_SESSION_DESKTOP = "plasma";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland,x11";  # Fallback to X11 for compatibility
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  # Remove X11/Wayland-specific configurations
  funkouna = {
    programs = {
      hyprland.enable = false;
    };
  };
  
  home.packages = with pkgs; [
    foot
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
    xwayland  # Need for X11 compatibility on Wayland
    
    # KDE applications
    kdePackages.kate
    kdePackages.konsole
    kdePackages.okular
    kdePackages.dolphin
  ];
}