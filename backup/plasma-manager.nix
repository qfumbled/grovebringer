{ config, lib, pkgs, inputs, ... }:

{
  programs.plasma = {
    enable = true;
    
    # Force dark theme - no light mode allowed
    workspace = {
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      cursorTheme = "Breeze";
      iconTheme = "breeze-dark";
      wallpaper = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-dark-blue.png";
        sha256 = "1n3iy7z7d3xq2y2q2y2q2y2q2y2q2y2q2y2q2y2q2y2q2y2q2y2q2y2q2y2q2";
      };
    };

    # Dark theme for applications
    fonts = {
      general = {
        family = "JetBrains Mono";
        size = 12;
      };
    };

    # Panel configuration
    panels = [
      {
        location = "top";
        height = 48;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          "org.kde.plasma.taskmanager"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    # Force override config for declarative setup
    overrideConfig = true;
  };

  # KDE applications with dark theme
  programs.kdeconnect.enable = true;
  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.konsole
    kdePackages.okular
    kdePackages.dolphin
  ];
}
