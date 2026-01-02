{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.grovebringer.nixos.audio = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable audio support";
    };
  };

  config = lib.mkIf config.grovebringer.nixos.audio.enable {
    # Audio configuration here
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
