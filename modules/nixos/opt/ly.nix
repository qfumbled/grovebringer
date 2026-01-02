{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.grovebringer.nixos.ly = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Ly display manager";
    };
  };

  config = lib.mkIf config.grovebringer.nixos.ly.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        hide_cursor = true;
      };
    };
  };
}
