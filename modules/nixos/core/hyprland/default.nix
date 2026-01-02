{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.grovebringer.nixos.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
