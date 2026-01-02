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
  # grovebringer.system.hostType = "desktop";  # TODO: Define this option
  # grovebringer.system.impermanence.enable = false;  # TODO: Define this option

  services.flatpak.enable = true;
}
