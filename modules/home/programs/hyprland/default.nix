{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.funkouna.programs.hyprland;
in
{
  options.funkouna.programs.hyprland = {
    enable = mkEnableOption "Enable Hyprland window manager";
  };

  config = mkIf cfg.enable {
    # Hyprland configuration will be handled by the hyprland module
  };
}
