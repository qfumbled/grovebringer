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
  ];
}
