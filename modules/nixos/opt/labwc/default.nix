{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.programs.wayland;
in
{
  config = mkIf cfg.enable {
    programs.labwc = {
      enable = true;
    };
  };
}
