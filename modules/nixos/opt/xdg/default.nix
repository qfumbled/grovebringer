{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.system.xdg;
in
{
  config = mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];
      };
    };
    
    environment.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };
    
    # Enable Flatpak when XDG is enabled
    services.flatpak.enable = true;
    
    home-manager.users.${username} = {
      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
          desktop = "$HOME/Desktop";
          documents = "$HOME/Documents";
          download = "$HOME/Downloads";
          music = "$HOME/Music";
          pictures = "$HOME/Pictures";
          videos = "$HOME/Videos";
        };
      };
    };
  };
}
