# modules/home/style/gtk/default.nix
{ pkgs, lib, config, ... }:

{
  # GTK Configuration
  gtk = {
    enable = true;

    # Icon theme
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # GTK theme
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    # GTK3 Settings
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-decoration-layout = "menu:";
    };

    # GTK4 Settings
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Stylix Configuration
  stylix = {
    enable = true;
    targets.gtk.enable = true;
    targets.gtk.extraCss = ''
      * {
        border-radius: 0;
      }
    '';
  };

  # Ensure the theme is available
  home.packages = with pkgs; [
    adw-gtk3
    papirus-icon-theme
  ];
}