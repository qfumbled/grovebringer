{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [ ./hardware.nix ];

  networking.hostName = "grovebringer";

  services.flatpak.enable = true;
}