{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./audio
    ./bluetooth
    ./impermanence
    ./ly
    ./qt
    ./labwc
    ./spotify
  ];
}
