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

  # Enable optional NixOS modules
  grovebringer.nixos.audio.enable = true;
  grovebringer.nixos.bluetooth.enable = true;
  grovebringer.nixos.ly.enable = false;  # Use different display manager
  grovebringer.nixos.impermanence.enable = false;  # Enable when ready

  services.flatpak.enable = true;
}