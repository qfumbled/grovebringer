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
  [ (if builtins.pathExists ./hardware.nix then ./hardware.nix else /etc/hardware-configuration.nix) ];

  networking.hostName = "grovebringer";

  funkouna = {
    services = {
      bluetooth.enable = true;
      audio.enable = true;
      ly.enable = true;
    };
    programs = {
      wayland.enable = true;
      steam.enable = false;
      spotify.enable = false;
    };
    impermanence.enable = false;
    
    system = {
      locale.enable = true;
      networking.enable = true;
      security.enable = true;
      users.enable = true;
      stylix.enable = true;
      nix.enable = true;
      xdg.enable = false;  # When false, Flatpak will also be disabled
    };
  };
}