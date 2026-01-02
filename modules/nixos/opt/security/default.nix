{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.system.security;
in
{
  config = mkIf cfg.enable {
    security = {
      sudo = {
        wheelNeedsPassword = false;
      };
      
      rtkit.enable = true;
      polkit.enable = true;
      
      pam = {
        services = {
          swaylock = {};
          greetd = {};
        };
      };
    };
    
    users.users.${username}.extraGroups = [ "audio" "video" "input" ];
  };
}
