{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./core
    ./programs
    ./services
    ./wm
    ./style
    ./scripts
  ];
}
