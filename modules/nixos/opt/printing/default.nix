{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.funkouna.services.printing = {
    enable = mkEnableOption "Enable printing services";
  };

  config = mkIf config.funkouna.services.printing.enable {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      printing = {
        enable = true;
        drivers = with pkgs; [
          gutenprint
          cups-filters
        ];
      };
    };

    hardware = {
      printers = {
        ensurePrinters = [
          {
            name = "Canon_TS3500_series";
            location = "Home";
            deviceUri = "usb://Canon/TS3500%20series?serial=";
            model = "everywhere";
            ppdOptions = {
              PageSize = "A4";
            };
          }
        ];
      };
    };
  };
}

