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

  networking.hostName = "aureliteiron";

  funkouna = {
    services = {
      bluetooth.enable = true;
      audio.enable = true;
      ly.enable = true;
      printing.enable = false;
      kde-connect.enable = true;
    };
    programs = {
      wayland.enable = true;
      fuzzel.enable = true;
      waybar.enable = true;
    };
    system = {
      stylix.enable = false;
      nix.enable = true;
      xdg.enable = false;
    };
  };
}
