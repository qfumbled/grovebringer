{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.services.bluetooth;
in
{
  config = mkIf cfg.enable {
    hardware = {
      bluetooth.enable = true;
      bluetooth.input.General = {
        ClassicBondedOnly = false;
      };
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      brillo.enable = true;
    };
  };
}
