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

  config = lib.mkIf config.funkouna.home.shells.enable {
  };
}
