{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./discord
    ./fuzzel
    ./hyprland
    ./mako
    ./waybar
  ];
}
