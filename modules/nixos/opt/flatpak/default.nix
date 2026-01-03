{
  config,
  lib,
  ...
}:

let
  cfg = config.funkouna.services.flatpak;
in {
  options.funkouna.services.flatpak = {
    enable = lib.mkEnableOption "Flatpak support";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
