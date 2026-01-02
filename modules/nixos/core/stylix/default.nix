{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  config = {
    stylix = {
      enable = true;
      base16Scheme = ../../../../home/shared/colors/test.yaml;

      # Cursor settings
      cursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size = 20;
      };

      fonts = {
        sizes = {
          terminal = 12;
          applications = 12;
          desktop = 12;
        };
        monospace = {
          name = "RobotoMono Nerd Font Propo";
          package = pkgs.nerd-fonts.roboto-mono;
        };
        sansSerif = {
          name = "Rubik";
          package = pkgs.rubik;
        };
      };

      # Disable wlsunset (blue light filter)
      targets = {
        gtk.enable = true;
        console.enable = true;
      };
    };

    # Disable wlsunset (blue light filter)
    systemd.user.services.wlsunset.enable = false;
  };
}
