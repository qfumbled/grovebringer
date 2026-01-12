{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
  cfg = config.funkouna.services.bluetooth;
in
{
  config = mkIf cfg.enable {
    hardware = {
      bluetooth = {
        enable = true;

        settings = {
          General = {
            ClassicBondedOnly = false;
          };
        };
      };

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    environment.systemPackages = [
      pkgs.brillo
    ];
  };
}
