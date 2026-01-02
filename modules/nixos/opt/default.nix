{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = lib.grovebringer.readSubdirs ./.;
}
