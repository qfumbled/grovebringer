{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./discord
    ./fuzzel
    ./mako
    ./waybar
  ];

  config = lib.mkIf config.grovebringer.home.programs.enable {
    # Programs configurations here
    # Individual modules will handle their own conditional logic
  };
}
