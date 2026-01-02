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
      ly.enable = false;  # Use different display manager
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