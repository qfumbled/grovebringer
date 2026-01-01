{ config, pkgs, lib, inputs, ... }:

{
  imports = [ ./hardware.nix ];

  networking.hostName = "grovebringer";

  services.flatpak.enable = true;
}