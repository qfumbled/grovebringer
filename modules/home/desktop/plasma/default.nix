{pkgs, ...}: {
  home.packages = with pkgs; [
    papirus-icon-theme
  ];
  programs.plasma = {
    enable = true;
    workspace = {
     wallpaper = "${../../../../../home/shared/anatomy.webp}";
     iconTheme = "Papirus-Dark";
     lookAndFeel = "org.kde.breeze.desktop";
     cursor.theme = "breeze";
    };
    shortcuts = {
      "kwin" = {
        "Window Fullscreen" = "Meta+F";
        "Window Close" = "Meta+Q";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Window to Desktop 1" = "Meta+Shift+1";
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
    hotkeys.commands = {
      "launch-konsole" = {
        name = "Launch Konsole";
        key = "Meta+Return";
        command = "konsole";
      };
    };
    panels = [
      {
        location = "bottom";
        height = 36;
        floating = false;
        hiding = "none";
        alignment = "center";
        opacity = "opaque";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config.General = {
              icon = "start-here-kde-symbolic";
            };
          }
          "org.kde.plasma.panelspacer"
          {
            name = "org.kde.plasma.icontasks";
            config.General = {
              iconsOnly = true;
              groupPopups = false;
              showOnlyCurrentDesktop = true;
              launchers = [
                "applications:firefox.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            };
          }
          "org.kde.plasma.panelspacer"
          {
            name = "org.kde.plasma.systemtray";
            config.General.scaleIconsToFit = true;
          }
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                showDate = false;
                showSeconds = false;
                use24hFormat = false;
              };
            };
          }
        ];
      }
    ];
  };
}
