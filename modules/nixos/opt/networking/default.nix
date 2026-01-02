{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.system.networking;
in
{
  config = mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi = {
          powersave = false;
        };
      };
      
      firewall = {
        enable = true;
        allowedTCPPorts = [ 22 80 443 ];
        allowedUDPPorts = [ 53 ];
      };
    };
    
    environment.systemPackages = with pkgs; [
      networkmanagerapplet
      iw
      wirelesstools
    ];
  };
}
