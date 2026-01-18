{
  lib,
  config,
  pkgs,
  username,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
in
{
  options = {
    funkouna = {
      services = {
        printing = {
          enable = mkEnableOption "Enable printing services (CUPS + Avahi)";
        };
      };
    };
  };

  config = mkIf config.funkouna.services.printing.enable {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        nssmdns = true;
        openFirewall = true;
        publish = {
          enable = true;
          userServices = true;
        };
      };

      printing = {
        enable = true;
        drivers = with pkgs; [
          cups-filters
          cups-browsed
          gutenprint
        ];
        listenAddresses = [
          "*:631"
        ];
        allowFrom = [
          "all"
        ];
        browsing = true;
        defaultShared = true;
        openFirewall = true;
      };
    };

    hardware = {
      printers = {
        ensureDefaultPrinter = "Canon_TS3500_series";
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

    users = {
      users = {
        ${username} = {
          extraGroups = [
            "lpadmin"
          ];
        };
      };
    };
  };
}
