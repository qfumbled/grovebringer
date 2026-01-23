{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.funkouna.desktop.plasma;
in
{
  options = {
    funkouna = {
      desktop = {
        plasma = {
          enable = mkEnableOption "Enable KDE Plasma desktop environment";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        papirus-icon-theme
      ];
    };

    programs = {
      plasma = {
        enable = true;
        workspace = {
          wallpaper = toString (./../../../../home/shared/walls/main3.jpg);
          iconTheme = "Papirus-Dark";
          lookAndFeel = "org.kde.breezedark.desktop";
        };
        shortcuts = {
          "kwin" = {
            "Window Fullscreen" = "Meta+F";
            "Window Close" = "Meta+Q";
            "Switch to Desktop 1" = "Meta+1";
            "Switch to Desktop 2" = "Meta+2";
            "Switch to Desktop 3" = "Meta+3";
            "Switch to Desktop 4" = "Meta+4";
            "Window to Desktop 2" = "Meta+Shift+2";
            "Window to Desktop 3" = "Meta+Shift+3";
            "Window to Desktop 4" = "Meta+Shift+4";
          };
          "plasmashell" = {
            "activate task manager entry 1" = "none";
            "activate task manager entry 2" = "none";
            "activate task manager entry 3" = "none";
            "activate task manager entry 4" = "none";
            "activate task manager entry 5" = "none";
            "activate task manager entry 6" = "none";
            "activate task manager entry 7" = "none";
            "activate task manager entry 8" = "none";
            "activate task manager entry 9" = "none";
            "manage activities" = "none";
          };
        };
        panels = [
          {
            location = "top";
            height = 30;
            floating = false;
            widgets = [
              {
                kickoff = {
                  icon = "system-search";
                };
              }
              {
                name = "org.dhruv8sh.kara";
                config = {
                  general = {
                    type = 0;
                  };
                };
              }
              "org.kde.plasma.panelspacer"
              {
                digitalClock = {
                  date = {
                    enable = false;
                  };
                };
              }
              "org.kde.plasma.panelspacer"
              "org.kde.plasma.systemtray"
            ];
          }
          {
            location = "bottom";
            height = 48;
            floating = true;
            hiding = "autohide";
            lengthMode = "fit";
            widgets = [
              {
                name = "org.kde.plasma.icontasks";
                config = {
                  General = {
                    launchers = [
                      "applications:firefox.desktop"
                      "applications:org.kde.dolphin.desktop"
                    ];
                  };
                };
              }
            ];
          }
        ];
      };
    };
  };
}
