{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breeze.desktop";
      colorScheme = "BreezeDark";
      iconTheme = "breeze-dark";
      cursorTheme = "breeze";
    };

    panels = [
      {
        location = "bottom";
        height = 34;
        floating = true;
        opacity = "translucent";
        alignment = "center";

        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config.General.icon = "start-here-kde";
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
