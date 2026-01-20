{
  lib,
  pkgs,
  ...
}:
let
  utils = import ../default.nix {
    inherit lib pkgs;
  };
  inherit (utils) mkElectronWayland;
in
{
  spotify-wayland = mkElectronWayland {
    package = pkgs.spotify;
    name = "spotify";
  };
}
