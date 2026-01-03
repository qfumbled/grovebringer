{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./labwc
    ./hyprland
  ];
}
