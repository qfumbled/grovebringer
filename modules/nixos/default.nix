{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Nothing to see here !
  ] ++ lib.funkouna.readSubdirs ./.;
}
