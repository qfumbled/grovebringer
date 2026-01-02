{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./programs
    ./shells
    ./terminals
    ./wm
    ./style
  ];

  # Only import modules that are enabled
  config = {
    # Programs module
    imports = lib.optionals config.grovebringer.home.programs.enable [
      ./programs
    ];

    # Shells module
    imports = lib.optionals config.grovebringer.home.shells.enable [
      ./shells
    ];

    # Terminals module
    imports = lib.optionals config.grovebringer.home.terminals.enable [
      ./terminals
    ];

    # Window manager module
    imports = lib.optionals config.grovebringer.home.wm.enable [
      ./wm
    ];

    # Style module (always imported for theming)
    imports = [
      ./style
    ];
  };
}
