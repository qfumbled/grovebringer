{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.system.users;
in
{
  config = mkIf cfg.enable {
    users = {
      users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = [ "wheel" "networkmanager" ];
        group = username;
      };
      
      groups.${username} = {};
    };
    
    home-manager = {
      users.${username} = {
        home = {
          homeDirectory = "/home/${username}";
        };
      };
    };
  };
}
