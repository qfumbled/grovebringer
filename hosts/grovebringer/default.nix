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

  services.flatpak.enable = true;
}