{...}: {
  programs.plasma = {
    enable = true;

    workspace = {
      iconTheme = "Papirus-Light";
     # wallpaper = "${../../assets/wallpapers/wallpaper.png}";
      lookAndFeel = "org.kde.breeze.desktop";
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
        name = "Launch Foot";
        key = "Meta+Return";
        command = "run-as-service foot";
      };
    };

    panels = [
      {
        opacity = "opaque";
        location = "bottom";
        height = 34
        floating = false;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.panelspacer"
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = [
                "applications:firefox.desktop"
                "applications:vesktop.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };
}
