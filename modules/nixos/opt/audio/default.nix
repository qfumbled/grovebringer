{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkOption types;

  cfg = config.funkouna.services.audio;
in
{
  options = {
    funkouna = {
      services = {
        audio = {
          enable = mkEnableOption "audio stack (PipeWire + WirePlumber)";

          bluetooth = {
            enable = mkEnableOption "Bluetooth audio support";
          };

          lowLatency = {
            enable = mkEnableOption "low-latency PipeWire tuning";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      pulseaudio = {
        enable = false;
      };

      pipewire = {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };

        pulse = {
          enable = true;
        };

        jack = {
          enable = true;
        };

        wireplumber = {
          enable = true;

          configPackages =
            mkIf cfg.bluetooth.enable [
              (pkgs.writeTextDir
                "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua"
                ''
                  bluez_monitor.properties = {
                    ["bluez5.enable-sbc-xq"] = true,
                    ["bluez5.enable-msbc"] = true,
                    ["bluez5.enable-hw-volume"] = true,
                    ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",
                    ["bluez5.a2dp.ldac.quality"] = "auto",
                    ["bluez5.a2dp.aac.bitratemode"] = 0,
                    ["bluez5.default.rate"] = 48000,
                    ["bluez5.default.channels"] = 2,
                    ["bluez5.headset-profile"] = "a2dp-only"
                  }
                ''
              )
            ];
        };

        extraConfig =
          mkIf cfg.lowLatency.enable {
            pipewire = {
              "99-custom" = {
                "context.properties" = {
                  default.clock = {
                    rate = 48000;
                    quantum = 1024;
                    min-quantum = 32;
                    max-quantum = 2048;
                  };
                };
              };
            };
          };
      };
    };

    security = {
      rtkit = {
        enable = true;
      };
    };

    environment = {
      systemPackages = with pkgs; [
        pavucontrol
        playerctl
      ];
    };
  };
}
