{
  config,
  lib,
  pkgs,
  ...
}:

{
  home-manager.users.xekuri = {
    grovebringer.home = config.grovebringer.home or {};
  };
}