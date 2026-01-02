{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./foot
  ];

  options.grovebringer.home.terminals = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable optional terminals";
    };
  };

  config = lib.mkIf config.grovebringer.home.terminals.enable {
    # Terminal configuration here
  };
}
