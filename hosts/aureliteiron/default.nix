{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = 
  [ (if builtins.pathExists ./hardware.nix then ./hardware.nix else /etc/hardware-configuration.nix) ];

  networking.hostName = "aureliteiron";

  grovebringer = {
    nixos = {
      audio.enable = true;
      bluetooth.enable = true;
<<<<<<< HEAD
      ly.enable = true;
=======
      ly.enable = true; 
>>>>>>> origin/main
      impermanence.enable = false;  # testing.
    };

    home = {
      programs.enable = true;
      shells.enable = true;
      terminals.enable = true;
      wm.enable = true;
    };
  };

  services.flatpak.enable = true;
}
