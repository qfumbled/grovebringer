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
}
