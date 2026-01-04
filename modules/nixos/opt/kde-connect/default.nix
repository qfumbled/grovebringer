{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.funkouna.services.kde-connect;
in
{
  options.funkouna.services.kde-connect = {
    enable = mkEnableOption "KDE Connect service" // {
      default = true;
      description = "Whether to enable KDE Connect for device integration.";
    };
  };

  config = mkIf cfg.enable {
    programs.kdeconnect.enable = true;

    networking.firewall = {
      enable = true;

      allowedTCPPortRanges = [
        { from = 1714; to = 1764; }
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; }
      ];
    };
  };
}
