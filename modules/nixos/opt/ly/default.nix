{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.services.ly;
in
{
  config = mkIf cfg.enable {
    services.displayManager.ly.enable = true;
  };
}
