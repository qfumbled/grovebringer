{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./labwc
  ];

  config = lib.mkIf config.grovebringer.home.wm.enable {
    # Window manager configurations here
  };
}
