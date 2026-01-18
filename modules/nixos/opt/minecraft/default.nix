{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.programs.minecraft;
in
{
  options = {
    funkouna = {
      programs = {
        minecraft = {
          enable = mkEnableOption "Enable Minecraft with OpenJDK 17";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = [
        pkgs.prismlauncher
        pkgs.openjdk17
      ];

      variables = {
        JAVA_HOME = "${pkgs.openjdk17}";
      };
    };
  };
}
