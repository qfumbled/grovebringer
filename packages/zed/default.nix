{
  lib,
  pkgs,
  ...
}:
let
  utils = import ../default.nix {
    inherit lib pkgs;
  };
  inherit (utils) mkWrapper;

  zed-wrapper = mkWrapper {
    package = pkgs.zed-editor;
    name = "zeditor";
  };

  zed = pkgs.symlinkJoin {
    name = "zed";
    paths = [ zed-wrapper ];
    postBuild = ''
      ln -sf $out/bin/zeditor $out/bin/zed
    '';
  };
in
{
  name = "zed";

  inherit zed zed-wrapper;
}
