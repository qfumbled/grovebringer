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

  config = lib.mkIf config.grovebringer.home.shells.enable {
  };
}
