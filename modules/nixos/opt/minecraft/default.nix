{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.funkouna = {
    programs = {
      minecraft = {
        enable = lib.mkEnableOption "Enable Minecraft with OpenJDK 17";
      };
    };
  };

  config = lib.mkIf config.funkouna.programs.minecraft.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
      openjdk17
    ];

    environment.variables = {
      JAVA_HOME = "${pkgs.openjdk17}";
    };
  };
}
