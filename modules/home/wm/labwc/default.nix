{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./configuration];
  home.packages = [
    pkgs.labwc
    pkgs.swaybg
  ];
}