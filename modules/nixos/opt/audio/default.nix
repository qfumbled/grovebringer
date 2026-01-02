{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.services.audio;
in
{
  config = mkIf cfg.enable {
    # Enable sound with pipewire
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Audio packages for multimedia support
    environment.systemPackages = with pkgs; [
      pavucontrol
      playerctl
    ];
  };
}
