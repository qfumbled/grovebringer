{
  lib,
  pkgs,
  ...
}:
let
  utils = import ../default.nix {
    inherit lib pkgs;
  };
  inherit (utils) mkWrapper mkAlias;

  zed-wrapper = mkWrapper {
    package = pkgs.zed-editor;
    name = "zeditor";
  };

  zed = mkAlias {
    name = "zed";
    target = "${zed-wrapper}/bin/zeditor";
  };
in
{
  inherit zed zed-wrapper;
}
