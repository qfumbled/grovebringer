# modules/home/style/gtk/default.nix
{ pkgs, lib, config, ... }:

{
  # GTK Configuration
  gtk = {
    enable = true;

    iconTheme = {
      name = lib.mkForce "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = lib.mkForce "adw-gtk3-dark";
      package = lib.mkForce pkgs.adw-gtk3;
    };

    gtk3.extraConfig = lib.mkForce {
      gtk-application-prefer-dark-theme = 1;
      gtk-decoration-layout = "menu:";
    };

    gtk4.extraConfig = lib.mkForce {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  stylix = {
    enable = true;
    targets.gtk.enable = true;
    targets.gtk.extraCss = lib.mkForce ''
      * {
        border-radius: 0;
      }
    '';
  };

  home.packages = with pkgs; [
    adw-gtk3
    papirus-icon-theme
  ];
}