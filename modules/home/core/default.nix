{ lib, ... }:
{
  imports = 
    let
      dirs = builtins.attrNames (
        lib.attrsets.filterAttrs (_: type: type == "directory") (builtins.readDir ./.)
      );
    in
    map (d: ./. + "/${d}") dirs;
}
