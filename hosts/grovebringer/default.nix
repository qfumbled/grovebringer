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
      ly.enable = true;
      flatpak.enable = true;
      printing.enable = false;
    };

    programs = {
      wayland.enable = true;
      steam.enable = false;
      spotify.enable = true;
    };

    system = {
      stylix.enable = true;
      networking.enable = true;
    };

    impermanence.enable = false;
  };
}