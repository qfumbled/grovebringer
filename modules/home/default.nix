{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = lib.funkouna.readSubdirs ./.;
}
