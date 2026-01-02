{
  config,
  lib,
  pkgs,
  ...
}:

{
  home-manager.users.xekuri = {
    funkona.home = config.funkouna.home or {};
  };
}