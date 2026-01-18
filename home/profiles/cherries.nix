{
  lib,
  config,
  pkgs,
  ...
}:

{
  funkouna = {
    programs = {
      vicinae = {
        enable = true;
      };
      discord = {
        enable = true;
      };
    };
    desktop = {
      plasma = {
        enable = true;
      };
      hyprland = {
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

    packages = with pkgs; [
      app2unit
      asciinema_3
      bitwarden-desktop
      bore-cli
      circumflex
      clipse
      colordiff
      onefetch
      statix
    ];
  };
}
