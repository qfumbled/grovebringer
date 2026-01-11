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
      base16Scheme = ../../../../home/shared/colors/gruvbox.yaml;

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
          package = lib.mkForce pkgs.nerd-fonts.roboto-mono;
        };
        sansSerif = {
          name = "Roboto";
          package = lib.mkForce pkgs.roboto;
        };
      };

      # Basic theming targets
      targets = {
        gtk.enable = true;
        console.enable = true;
        qt = {
          enable = true;
          platform = lib.mkDefault "qtct";  # Make this the default, but allow override
        };
      };
    };

    # Disable wlsunset (blue light filter)
    systemd.user.services.wlsunset.enable = false;
  };
}
