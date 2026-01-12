{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.services.kdeConnect;
in
{
  options = {
    funkouna = {
      services = {
        kdeConnect = {
          enable = mkEnableOption "Enable KDE Connect service option" // {
            default = true;
            description = "Whether to enable KDE Connect for device integration.";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      kdeconnect = {
        enable = true;
      };
    };

    networking = {
      firewall = {
        enable = true;

        allowedTCPPortRanges = [
          { from = 1714; to = 1764; }
        ];
        allowedUDPPortRanges = [
          { from = 1714; to = 1764; }
        ];
      };
    };
  };
}
