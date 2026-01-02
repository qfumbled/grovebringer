{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = 
    lib.optionals (builtins.pathExists ./hardware.nix) [ ./hardware.nix ];

  networking.hostName = "aureliteiron";

  grovebringer = {
    nixos = {
      audio.enable = true;
      bluetooth.enable = true;
      ly.enable = true;  # Desktop display manager
      impermanence.enable = false;  # Enable when ready
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
