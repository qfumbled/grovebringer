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

  # Enable optional home-manager modules for desktop
  grovebringer.home.programs.enable = true;
  grovebringer.home.shells.enable = true;
  grovebringer.home.terminals.enable = true;
  grovebringer.home.wm.enable = true;

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
