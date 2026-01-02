{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../shared
  ];

  home = {
    username = "xekuri";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "25.11";
  };

  programs.home-manager = {
    enable = true;
  };

  # Desktop-specific home-manager settings
  # grovebringer.home.desktop.enable = true;  # TODO: Define this option
}
