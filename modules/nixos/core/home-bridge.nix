{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Pass NixOS-level grovebringer.home.* options to home-manager
  home-manager.users.xekuri = {
    grovebringer.home = config.grovebringer.home or {};
  };
}
