{
  lib,
  config,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.funkouna.services.zram;
in
{
  options = {
    funkouna = {
      services = {
        zram = {
          enable = mkEnableOption "ZRAM compressed swap";

          algorithm = mkOption {
            type = types.str;
            default = "zstd";
            description = "Compression algorithm (zstd, lz4, lzo)";
          };

          memoryPercent = mkOption {
            type = types.int;
            default = 50;
            description = "Percentage of RAM to use for ZRAM";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    zramSwap = {
      enable = true;
      algorithm = cfg.algorithm;
      memoryPercent = cfg.memoryPercent;
    };
  };
}
