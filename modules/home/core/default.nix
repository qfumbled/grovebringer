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
    ./sops/default.nix
    ./xdg
  ];
}
