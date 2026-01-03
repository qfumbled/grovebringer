{
  pkgs,
  lib,
  config,
  ...
}:

{
  gtk = {
    enable = true;

    # Configure GTK CSS through Stylix when available
    gtk4.extraCss = lib.mkIf (config.stylix.enable or false) ''
      @define-color accent_color #66858f;
      @define-color accent_bg_color #66858f;

      * {
        border-radius: 0;
      }
    '';

    iconTheme = {
      name = lib.mkDefault "Adwaita";
      package = lib.mkDefault pkgs.adwaita-icon-theme;
    };

    theme = {
      name = lib.mkDefault "Adwaita";
      package = lib.mkDefault pkgs.gnome.gnome-themes-extra;
    };
  };

  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };

  # Use Stylix home-manager module when Stylix is enabled
  stylix.targets.gtk = lib.mkIf config.stylix.enable {
    extraCss = ''
      @define-color accent_color #66858f;
      @define-color accent_bg_color #66858f;

      * {
        border-radius: 0;
      }
    '';
  };
}
