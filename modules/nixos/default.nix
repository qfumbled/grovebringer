{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  # Top-level imports
  imports = lib.funkouna.readSubdirs ./.;
}
