{
  lib,
  ...
}:
{
  options = {
    grovebringer = {
      system = {
        username = lib.mkOption {
          type = lib.types.str;
          default = "xekuri";
          description = "Primary username for the system";
        };

        impermanence = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable state persistence";
          };

          persistentPath = lib.mkOption {
            type = lib.types.str;
            default = "/persistent";
            description = "Path to persistent storage";
          };
        };

        hostType = lib.mkOption {
          type = lib.types.enum [
            "laptop"
            "desktop"
            "server"
          ];
          default = "laptop";
          description = "Type of host for configuration tuning";
        };
      };

      nixos = {
        audio = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable audio support";
          };
        };

        bluetooth = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Bluetooth support";
          };
        };

        ly = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Ly display manager";
          };
        };

        impermanence = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable state persistence";
          };
        };

        hyprland = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Hyprland compositor";
          };
        };
      };

      home = {
        programs = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable optional programs";
          };
        };

        shells = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable optional shells";
          };
        };

        terminals = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable optional terminals";
          };
        };

        wm = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable optional window managers";
          };
        };
      };
    };
  };
}
