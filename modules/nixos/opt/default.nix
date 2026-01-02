{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./audio
    ./bluetooth
    ./impermanence
    ./ly
    ./qt
    ./labwc
    ./spotify
  ];

  # Only import modules that are enabled
  config = {
    # Audio module
    services.pipewire = lib.mkIf config.grovebringer.nixos.audio.enable {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Bluetooth module  
    hardware.bluetooth = lib.mkIf config.grovebringer.nixos.bluetooth.enable {
      enable = true;
    };
    services.blueman = lib.mkIf config.grovebringer.nixos.bluetooth.enable {
      enable = true;
    };

    # Ly display manager
    services.displayManager.ly = lib.mkIf config.grovebringer.nixos.ly.enable {
      enable = true;
      settings = {
        hide_cursor = true;
      };
    };

    # Impermanence (handled in its own module)
  };
}
