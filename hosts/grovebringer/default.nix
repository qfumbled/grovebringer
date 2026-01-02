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
    lib.optionals (builtins.pathExists ./hardware.nix) [ ./hardware.nix ];

  networking.hostName = "grovebringer";

  grovebringer = {
    nixos = {
      audio.enable = true;
      bluetooth.enable = true;
      ly.enable = true;  
      impermanence.enable = false;  # needs testing?
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