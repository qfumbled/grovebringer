{
  pkgs,
  ...
}:
{
  funkouna = {
    browser = {
      zen = {
        enable = true;
      };
      firefox = {
        enable = true;
      };
    };
    programs = {

      noctalia = {
        enable = true;
      };

      discord = {
        enable = true;
      };
    };
    desktop = {
      plasma = {
        enable = false;
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
      XDG_SESSION_TYPE = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
      MOZ_ENABLE_WAYLAND = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      OZONE_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";
    };

    packages = [
      pkgs._0xproto
      pkgs.python3
      pkgs.app2unit
      pkgs.asciinema_3
      pkgs.bitwarden-desktop
      pkgs.bore-cli
      pkgs.circumflex
      pkgs.clipse
      pkgs.colordiff
      pkgs.onefetch
      pkgs.statix
      pkgs.grim
      pkgs.slurp
    ];
  };
}
