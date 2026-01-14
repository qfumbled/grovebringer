{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.funkouna.programs.plasma;
in
{
  options = {
    funkouna = {
      programs = {
        plasma = {
          enable = mkEnableOption "Enable KDE Plasma desktop environment";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = false;
      };

      desktopManager = {
        plasma6 = {
          enable = true;
        };
      };

      pipewire = {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };

        pulse = {
          enable = true;
        };
      };
    };

    security = {
      rtkit = {
        enable = true;
      };
    };

    environment = {
      plasma6 = {
        excludePackages = with pkgs.kdePackages; [
          plasma-browser-integration
          okular
          kmail
          korganizer
          elisa
        ];
      };

      sessionVariables = {
        XDG_CURRENT_DESKTOP = "KDE";
        XDG_SESSION_DESKTOP = "plasma";
        XDG_SESSION_TYPE = "wayland";
        QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        MOZ_ENABLE_WAYLAND = "1";
      };
    };
  };
}
