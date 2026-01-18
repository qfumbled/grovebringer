{
  lib,
  config,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.funkouna.programs.vicinae;
in
{
  options = {
    funkouna = {
      programs = {
        vicinae = {
          enable = mkEnableOption "Enable vicinae";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      vicinae = {
        enable = true;
      };
    };
  };
}
