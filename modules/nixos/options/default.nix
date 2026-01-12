{
  lib,
  ...
}:

{
  options = {
    funkouna = {
      services = {
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

      # Remove programs section to avoid conflicts
      # programs = { ... };

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

      system = {
        locale = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable system localization";
          };
        };
      };
    };
  };
}
