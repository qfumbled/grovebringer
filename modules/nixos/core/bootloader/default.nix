{
  lib,
  config,
  pkgs,
  ...
}:

{
  boot = {
    kernel = {
      sysctl = {
        "net.isoc" = true;
      };
    };

    initrd = {
      systemd = {
        enable = true;
      };
    };

    supportedFilesystems = [
      "ntfs"
    ];

    kernelPackages = pkgs.linuxPackages_latest;

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];

    loader = {
      systemd-boot = {
        enable = lib.mkForce false;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      limine = {
        enable = true;
        style = {
          wallpapers = [
            ../../../../home/shared/walls/main3.jpg
          ];
        };
        efiSupport = true;
        secureBoot = {
          enable = false;
        };
        maxGenerations = 15;
      };
    };

    plymouth = {
      enable = false;
    };

    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
  };

  systemd = {
    services = {
      nix-daemon = {
        environment = {
          TMPDIR = "/var/tmp";
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      sbctl
      config.boot.kernelPackages.cpupower
    ];
  };
}
