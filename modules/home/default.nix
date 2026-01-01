{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;

{
  imports = [
    ./core/git
    ./wm/labwc
    ./terminals/foot
    ./programs/waybar
    ./programs/mako
    ./programs/fuzzel
  ];

  home = {
    username = "xekuri";
    homeDirectory = mkDefault "/home/xekuri";
    stateVersion = "25.11";
  };

  programs.home-manager = {
    enable = true;
  };
}