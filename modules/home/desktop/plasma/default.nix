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
    home.packages = with pkgs; [
      papirus-icon-theme
    ];

    programs.plasma.enable = true;

    programs.plasma = {
      workspace = {
        wallpaper = toString (./../../../../home/shared/walls/aesthetic.png);
        iconTheme = "Papirus-Dark";
        lookAndFeel = "org.kde.breeze.desktop";
      };

      panels = [
        {
          location = "bottom";
          height = 32;
          opacity = "opaque";
          floating = false;
          widgets = [
            "org.kde.plasma.kickoff"
            "org.kde.plasma.panelspacer"
            {
              digitalClock.date.enable = false;
            }
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.systemtray"
          ];
        }
        {
          location = "top";
          height = 24;
          opacity = "translucent";
          floating = false;
          widgets = [
            "org.kde.plasma.pager"
            "org.kde.plasma.notifications"
          ];
        }
      ];

      kwin = {
        effects = {
          blur.enable = false;
          windowOpenClose.animation = "none";
          cube.enable = false;
        };
        borderlessMaximizedWindows = true;
        compositor = {
          vsync = "none";
          scaleAnimations = false;
          reduceTransparency = true;
        };
      };

      input = {
        keyboard = {
          layouts = [
            {
              layout = "us";
              variant = "";
            }
          ];
          numlockOnStartup = "off";
          repeatRate = 60;
          repeatDelay = 150;
        };
        mice = [
          {
            enable = true;
            name = "Logitech G305";
            vendorId = "046d";
            productId = "c539";
            acceleration = 0.0;
            accelerationProfile = "none";
            leftHanded = false;
            naturalScroll = false;
          }
          {
            enable = true;
            name = "Logitech G502 X";
            vendorId = "046d";
            productId = "c099";
            acceleration = 0.0;
            accelerationProfile = "none";
            leftHanded = false;
            naturalScroll = false;
          }
        ];
      };

      fonts = {
        general = {
          family = "Noto Sans";
          pointSize = 10;
        };
        fixedWidth = {
          family = "Fira Code";
          pointSize = 10;
        };
        toolbar = {
          family = "Noto Sans";
          pointSize = 9;
        };
        windowTitle = {
          family = "Noto Sans";
          pointSize = 10;
          weight = "bold";
        };
      };

      powerdevil = {
        AC.turnOffDisplay.idleTimeout = "never";
      };

      shortcuts = {
        kwin = {
          "Window Fullscreen" = "Meta+F";
          "Window Close" = "Meta+Q";
          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Window to Desktop 2" = "Meta+Shift+2";
          "Window to Desktop 3" = "Meta+Shift+3";
          "Window to Desktop 4" = "Meta+Shift+4";
          "Move Window to Screen Left" = "Meta+Shift+Left";
          "Move Window to Screen Right" = "Meta+Shift+Right";
        };
        plasmashell = {
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

      krunner = {
        shortcuts.launch = "Meta";
        position = "top";
        historyBehavior = "enableAutoComplete";
      };

      desktop = {
        mouseActions = {
          leftClick = "applicationLauncher";
          rightClick = "contextMenu";
          middleClick = "paste";
        };
      };
      };
    };
  };
}
