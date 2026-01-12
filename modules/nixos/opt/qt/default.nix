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
  options = {
    funkouna = {
      programs = {
        wayland = {
          enable = mkEnableOption "Enable Wayland support for Qt applications";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    qt.enable = true;
  };
}
