{
  inputs,
  lib,
  config,
  pkgs,
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
      name = lib.mkForce "Adwaita";
      package = config.gtk.iconTheme.package;
    };

    theme = {
      name = lib.mkForce "Adwaita";
      package = config.gtk.theme.package;
    };
  };

  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };
}
