{ pkgs, lib, config, ... }:

{
  boot = {
    kernel = {
      sysctl = {
        "net.isoc" = true;
      };
    };
    
    initrd = {
      systemd.enable = true;
    };
    
    supportedFilesystems = [ "ntfs" ];
    
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
        enable = true;
        configurationLimit = 15;
        editor = false;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
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

  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/tmp";
    };
  };

  # Environment packages
  environment = {
    systemPackages = with pkgs; [
      config.boot.kernelPackages.cpupower
    ];
  };
}