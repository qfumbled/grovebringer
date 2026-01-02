{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:

{
  imports = 
  [ (if builtins.pathExists ./hardware.nix then ./hardware.nix else /etc/hardware-configuration.nix) ];

  networking.hostName = "grovebringer";

  grovebringer = {
    nixos = {
      audio.enable = true;
      bluetooth.enable = true;
      ly.enable = true;  
      impermanence.enable = true;  
      hyprland.enable = true;  
    };

    home = {
      programs.enable = true;
      shells.enable = true;
      terminals.enable = true;
      wm.enable = true;
    };
  };

  services.flatpak.enable = true;
}