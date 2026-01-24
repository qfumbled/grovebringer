{
  lib,
  pkgs,
  ...
}:

import ../wrappers/default.nix { inherit lib pkgs; }
