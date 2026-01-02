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

  options.grovebringer.home.wm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable optional window managers";
    };
  };

  config = lib.mkIf config.grovebringer.home.wm.enable {
    # Window manager configuration here
  };
}
