{
  lib,
  config,
  pkgs,
  username,
  ...
}:

{
  imports = lib.funkouna.readSubdirs ./.;
}
