{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./fish
    ./starship
    ./git
    ./xdg
    ./plasma
  ];
}
