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
    ./mako
    ./waybar
  ];
}
