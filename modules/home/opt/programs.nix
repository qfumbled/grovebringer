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

  options.grovebringer.home.programs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable optional programs";
    };
  };

  config = lib.mkIf config.grovebringer.home.programs.enable {
    # Programs configuration here
  };
}
