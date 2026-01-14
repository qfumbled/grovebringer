{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.funkouna.services.sddm;
in
{
  options = {
    funkouna = {
      services = {
        sddm = {
          enable = mkEnableOption "Enable SDDM display manager";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland = {
            enable = true;
          };
        };
      };
    };
  };
}
