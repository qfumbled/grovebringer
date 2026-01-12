{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [
    (if builtins.pathExists ./hardware.nix 
     then ./hardware.nix 
     else /etc/hardware-configuration.nix)
  ];

  networking.hostName = "grovebringer";

  funkouna = {
    services = {
      bluetooth.enable = true;
      audio.enable = true;
      flatpak.enable = true;
      kdeConnect.enable = true;
    };

    programs = {
      spotify.enable = true;
      minecraft.enable = true;
    };

    impermanence.enable = false;
  };
}
