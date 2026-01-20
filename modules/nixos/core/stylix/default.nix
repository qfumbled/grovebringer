{
  lib,
  pkgs,
  ...
}:

{
  config = {
    stylix = {
      enable = true;
      base16Scheme = ../../../../home/shared/colors/paradise.yaml;

      cursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
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

      targets = {
        gtk = {
          enable = true;
        };
        console = {
          enable = true;
        };
        qt = {
          enable = true;
          platform = lib.mkDefault "qtct";
        };
      };
    };
  };
}
