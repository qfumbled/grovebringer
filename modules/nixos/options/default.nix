{
  lib,
  ...
}:
{
  options = {
    funkouna = {
      services = {
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

        virtualisation = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable virtualisation services";
          };
        };
      };

      programs = {
        wayland = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Wayland support";
          };
        };

        steam = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Steam support";
          };
        };

        spotify = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Spotify support";
          };
        };
      };

      impermanence = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable state persistence";
        };
      };

      system = {
        locale = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable system localization";
          };
        };

        networking = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable network configuration";
          };
        };

        security = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable system security";
          };
        };

        users = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable user management";
          };
        };

        stylix = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Stylix theming";
          };
        };

        pkgs = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable package management";
          };
        };

        nix = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable Nix configuration";
          };
        };

        xdg = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable XDG specifications";
          };
        };
      };
    };
  };
}
