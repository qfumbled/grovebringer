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
    ./opt
    ./options
  ];
}
