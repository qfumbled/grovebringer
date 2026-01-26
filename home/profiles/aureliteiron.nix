{
  pkgs,
  ...
}:
{
  funkouna = {
    browser = {
      zen = {
        enable = false;
      };
      firefox = {
        enable = true;
      };
    };
    programs = {
      noctalia = {
        enable = false;
      };

      discord = {
        enable = true;
      };
    };
    desktop = {
      plasma = {
        enable = true;
      };

    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  home = {
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "KDE";
      XDG_SESSION_DESKTOP = "plasma";
      XDG_SESSION_TYPE = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GDK_BACKEND = "wayland,x11";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      NIXOS_OZONE_WL = "1";
    };

    packages = [
      pkgs.app2unit
      pkgs.asciinema_3
      pkgs.bitwarden-desktop
      pkgs.bore-cli
      pkgs.circumflex
      pkgs.clipse
      pkgs.colordiff
      pkgs.deadnix
      pkgs.delta
      pkgs.doggo
      pkgs.eza
      pkgs.fd
      pkgs.feh

      pkgs.fx
      pkgs.fzf
      pkgs.gcc
      pkgs.gh
      pkgs.git-absorb
      pkgs.gitmoji-cli
      pkgs.glab
      pkgs.glow
      pkgs.gnumake
      pkgs.go
      pkgs.gping
      pkgs.grimblast
      pkgs.gum
      pkgs.httpie
      pkgs.imagemagick
      pkgs.inotify-tools
      pkgs.jq
      pkgs.jqp
      pkgs.just
      pkgs.k9s
      pkgs.keybase
      pkgs.kubecolor
      pkgs.kubectl
      pkgs.kubectx
      pkgs.kubernetes-helm
      pkgs.light
      pkgs.magic-wormhole
      pkgs.material-symbols
      pkgs.mods
      pkgs.navi
      pkgs.nemo
      pkgs.networkmanagerapplet
      pkgs.nh
      pkgs.nix-fast-build
      pkgs.nix-inspect
      pkgs.nix-output-monitor
      pkgs.nix-search-tv
      pkgs.nix-update
      pkgs.nixfmt-rfc-style
      pkgs.onefetch
      pkgs.opencode
      pkgs.openssl
      pkgs.openssh
      pkgs.pavucontrol
      pkgs.pgcli
      pkgs.pinentry-gnome3
      pkgs.playerctl
      pkgs.pre-commit
      pkgs.presenterm
      pkgs.python312Packages.gst-python
      pkgs.python312Packages.materialyoucolor
      pkgs.python312Packages.pillow
      pkgs.python312Packages.pip
      pkgs.python312Packages.pygobject3
      pkgs.python312Packages.setuptools
      pkgs.python312Packages.virtualenv
      pkgs.satty
      pkgs.stern
      pkgs.syncthing
      pkgs.statix
      pkgs.tldr
      pkgs.up
      pkgs.vlc
      pkgs.wireplumber
      pkgs.xdotool
      pkgs.xwayland
    ];
  };
}
