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
    };
  };
}
