{
  lib,
  ...
}:
{
  imports = [
    # Nothing to see here !
  ] ++ lib.funkouna.readSubdirs ./.;
}
