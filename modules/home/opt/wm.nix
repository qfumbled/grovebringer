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

  config = lib.mkIf config.funkouna.home.wm.enable {
    # Window manager configurations here
  };
}
