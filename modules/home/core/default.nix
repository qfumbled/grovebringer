{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = lib.grovebringer.readSubdirs ./.;
}
