{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./system
    ./locale
    ./users
    ./pkgs
    ./bootloader
    ./documentation
    ./graphics
    ./networking
    ./virtualisation
    ./nix
    ./xdg
    ./security
    ./stylix
    ./hyprland
  ];
}
