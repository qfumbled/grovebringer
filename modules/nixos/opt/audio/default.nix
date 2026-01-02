{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
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
}
