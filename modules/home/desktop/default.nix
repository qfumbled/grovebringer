{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Get all subdirectories that contain a default.nix file
  subdirs = builtins.filter
    (name: builtins.pathExists (./. + "/${name}/default.nix"))
    (builtins.attrNames (builtins.readDir ./.));

  # Import all subdirectories with default.nix
  imports = map (name: ./. + "/${name}") subdirs;
in {
  imports = imports;
}
