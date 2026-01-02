{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = lib.funkouna.readSubdirs ./.;
}
