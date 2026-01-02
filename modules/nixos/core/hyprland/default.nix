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

    environment.sessionVariables = {
      WLR_RENDERER = "vulkan";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
