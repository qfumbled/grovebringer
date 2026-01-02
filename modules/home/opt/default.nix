{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./programs
    ./shells
    ./terminals
    ./wm
    ./style
  ];
}
