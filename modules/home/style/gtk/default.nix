# modules/home/style/gtk/default.nix
{ pkgs, lib, config, ... }:

{
  # GTK Configuration
  gtk = {
    enable = true;

    # Icon theme
    iconTheme = {
      name = lib.mkForce "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # GTK theme - using mkForce to ensure this takes precedence
    theme = {
      name = lib.mkForce "adw-gtk3-dark";
      package = lib.mkForce pkgs.adw-gtk3;
    };

    # GTK3 Settings
    gtk3.extraConfig = lib.mkForce {
      gtk-application-prefer-dark-theme = 1;
      gtk-decoration-layout = "menu:";
    };

    # GTK4 Settings
    gtk4.extraConfig = lib.mkForce {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Stylix Configuration
  stylix = {
    enable = true;
    targets.gtk.enable = true;
    targets.gtk.extraCss = lib.mkForce ''
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