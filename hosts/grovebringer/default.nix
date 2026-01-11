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
      kde-connect.enable = true;
    };

    programs = {
      wayland.enable = true;  # Enable Wayland for Plasma Wayland session
      steam.enable = false;
      spotify.enable = true;
      minecraft.enable = true;
    };

    system = {
      stylix.enable = true;
      networking.enable = true;
      security.enable = true;  # Enable security hardening
    };

    impermanence.enable = false;
  };
}
