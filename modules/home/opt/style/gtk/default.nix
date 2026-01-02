{
  pkgs,
  lib,
  ...
}:

{
  gtk = {
    enable = true;

    gtk4.extraCss = ''
      @define-color accent_color #66858f;
      @define-color accent_bg_color #66858f;

      * {
        border-radius: 0;
      }
    '';

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    theme = {
      name = "Adwaita";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };
}
