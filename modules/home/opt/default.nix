{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = 
    (lib.optionals config.grovebringer.home.programs.enable [ ./programs ]) ++
    (lib.optionals config.grovebringer.home.shells.enable [ ./shells ]) ++
    (lib.optionals config.grovebringer.home.terminals.enable [ ./terminals ]) ++
    (lib.optionals config.grovebringer.home.wm.enable [ ./wm ]) ++
    [ ./style ];  # Style always imported for theming
}
