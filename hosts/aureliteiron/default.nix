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
  
  # Desktop-specific configuration - enable all optional modules
  grovebringer.nixos.audio.enable = true;
  grovebringer.nixos.bluetooth.enable = true;
  grovebringer.nixos.ly.enable = true;  # Desktop display manager
  grovebringer.nixos.impermanence.enable = false;  # Enable when ready

  services.flatpak.enable = true;
}
