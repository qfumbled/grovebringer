{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./core
    ./wm/labwc
    ./terminals/foot
    ./programs/waybar
    ./programs/mako
    ./programs/fuzzel
    ./programs/discord
    ./shells/fish
    ./shells/starship
  ];

  home = {
    username = "xekuri";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "25.11";
  };

  programs.home-manager = {
    enable = true;
  };
}