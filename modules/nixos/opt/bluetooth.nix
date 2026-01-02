{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.grovebringer.nixos.bluetooth = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Bluetooth support";
    };
  };

  config = lib.mkIf config.grovebringer.nixos.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
