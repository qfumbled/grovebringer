{
  lib,
  config,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
in
{
  options = {
    funkouna = {
      programs = {
        hyprland = {
          enable = mkEnableOption "Hyprland compositor";
        };
      };
    };
  };

  config = mkIf config.funkouna.programs.hyprland.enable {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = false;
        xwayland = {
          enable = true;
        };
      };

      uwsm = {
        waylandCompositors = {
          hyprland = {
            prettyName = "Hyprland";
            comment = "Hyprland compositor managed by UWSM";
            binPath = "/run/current-system/sw/bin/Hyprland";
          };
        };
      };
    };
  };
}
