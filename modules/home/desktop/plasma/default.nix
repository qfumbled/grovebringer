{ config, pkgs, ... }:
{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breeze.desktop";
      colorScheme = "Breeze";
      iconTheme = "breeze";
      cursor = {
        theme = "breeze";
      };
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
    };

    panels = [
      {
        location = "bottom";
        height = 30;
        floating = false;
        hiding = "none";
        alignment = "center";
        opacity = "opaque";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config.General = {
              icon = "nix-snowflake";
              launcherIconSize = 30;
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
                "applications:vesktop.desktop"
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
              Font = {
                family = "Noto Sans";
                bold = true;
              };
              FontSettings = {
                fontSize = 18;
              };
            };
          }
        ];
      }
    ];
  };
}