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
    # Optional services
    services = {
      bluetooth.enable = true;
      audio.enable = true;
      ly.enable = true;
      flatpak.enable = true;
    };

    # Programs
    programs = {
      wayland.enable = true;
      steam.enable = false;
      spotify.enable = false;
    };

    # System theming
    system = {
      stylix.enable = true;
      networking.enable = true;
    };

    # System features
    impermanence.enable = false;
  };
}