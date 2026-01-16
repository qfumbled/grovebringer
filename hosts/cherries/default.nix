{
  config,
  pkgs,
  ...
}:

let
  hardware =
    if builtins.pathExists ./hardware.nix
    then ./hardware.nix
    else /etc/hardware-configuration.nix;
in
{
  imports = [
    hardware
  ];
  
  networking = {
    hostName = "cherries";
  };

  funkouna = {
    services = {
      bluetooth = {
        enable = true;
      };

      audio = {
        enable = true;
      };

      flatpak = {
        enable = true;
      };

      kdeConnect = {
        enable = true;
      };

      sddm = {
        enable = true;
      };
    };

    programs = {
      plasma = {
        enable = true;
      };

      spotify = {
        enable = true;
      };

      minecraft = {
        enable = true;
      };
    };

    impermanence = {
      enable = false;
    };
  };
}
