{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./rc.nix
    ./themerc.nix
    ./menu.nix
    ./autostart.nix
    ./environment.nix
  ];
}