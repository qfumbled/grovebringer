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
  
  # Desktop-specific configuration
  grovebringer.system.hostType = "desktop";
  grovebringer.system.impermanence.enable = false;  # Enable when ready

  services.flatpak.enable = true;
}
