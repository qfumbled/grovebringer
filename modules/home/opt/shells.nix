{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./fish
    ./starship
  ];

  options.grovebringer.home.shells = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable optional shells";
    };
  };

  config = lib.mkIf config.grovebringer.home.shells.enable {
    # Shell configuration here
  };
}
