{ config, pkgs, ... }:

{
  imports = [
    ./system
    ./locale
    ./users
    ./pkgs
    ./audio
    ./ly
    ./bluetooth
    ./bootloader
    ./documentation
    ./graphics
    ./networking
    ./virtualisation
    ./nix
    ./qt
    ./xdg
    ./security
    ./labwc
    ./stylix
  ];
}
