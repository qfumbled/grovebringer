{
  lib,
  config,
  username,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.programs.nh;
in
{
  options = {
    funkouna = {
      programs = {
        nh = {
          enable = mkEnableOption "Enable nh (Nix Helper)";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      variables = {
        NH_FLAKE = "/home/${username}/grovebringer";
      };
    };

    programs = {
      nh = {
        enable = true;

        clean = {
          enable = true;
          extraArgs = "--keep-since 7d";
        };
      };
    };
  };
}
