{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:

let
  hardware = if builtins.pathExists ./hardware.nix then ./hardware.nix else /etc/hardware-configuration.nix;
in
{
  imports = [ hardware ];

  networking = {
    hostName = "aureliteiron";
  };

  funkouna = {
    services = {
      bluetooth.enable = true;
      audio.enable = true;
      printing.enable = false;
      kde-connect.enable = true;
    };

    programs = {
      wayland.enable = true;
      minecraft.enable = true;
    };

    system = {
      stylix.enable = false;
      nix.enable = true;
      xdg.enable = false;
    };
  };
}
