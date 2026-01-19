{
  lib,
  config,
  pkgs,
  ...
}:

let
  hardware =
    if builtins.pathExists ./hardware.nix
    then ./hardware.nix
    else /etc/hardware-configuration.nix;
in
{
  imports = [
    hardware
  ];

  networking = {
    hostName = "aureliteiron";
  };

  security = {
    forcePageTableIsolation = true;
    protectKernelImage = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
  };

  boot = {
    kernelModules = [
      "amdgpu"
      "v4l2loopback"
      "i2c-dev"
      "efivarfs"
    ];
    kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelParams = [
      "amd_pstate=active"
      "amd_iommu=force"
      "mitigations=off"
      "preempt=voluntary"
      "nowatchdog"
      "psi=1"
      "randomize_kstack_offset=on"
      "vsyscall=none"
      "slab_nomerge"
      "module.sig_enforce=1"
      "lockdown=confidentiality"
      "page_poison=1"
      "page_alloc.shuffle=1"
      "sysrq_always_enabled=0"
      "rootflags=noatime"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "fbcon=nodefer"
      "init_on_alloc=1"
      "init_on_free=1"
    ];
    kernel = {
      sysctl = {
        "vm.swappiness" = 10;
        "vm.vfs_cache_pressure" = 50;
        "vm.dirty_ratio" = 10;
        "vm.dirty_background_ratio" = 5;

        "kernel.nmi_watchdog" = 0;

        "net.core.netdev_budget" = 600;
        "net.core.netdev_max_backlog" = 16384;
        "net.ipv4.tcp_no_metrics_save" = 1;
        "net.ipv4.tcp_moderate_rcvbuf" = 1;

        "kernel.sysrq" = 0;
        "kernel.kptr_restrict" = 2;
        "kernel.ftrace_enabled" = false;
        "kernel.dmesg_restrict" = 1;
        "fs.protected_fifos" = 2;
        "fs.protected_regular" = 2;
        "fs.suid_dumpable" = 0;
        "net.core.bpf_jit_harden" = 2;

        "kernel.core_uses_pid" = 1;
        "kernel.randomize_va_space" = 2;
        "vm.mmap_rnd_bits" = 32;
        "vm.mmap_rnd_compat_bits" = 16;
        "dev.tty.ldisc_autoload" = 0;
        "vm.unprivileged_userfaultfd" = 1;
      };
    };

    blacklistedKernelModules = [
      "af_802154"
      "appletalk"
      "atm"
      "ax25"
      "decnet"
      "econet"
      "ipx"
      "n-hdlc"
      "netrom"
      "p8022"
      "p8023"
      "psnap"
      "rds"
      "rose"
      "tipc"
      "x25"
      "adfs"
      "affs"
      "befs"
      "bfs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "f2fs"
      "freevxfs"
      "gfs2"
      "hfs"
      "hfsplus"
      "hpfs"
      "jffs2"
      "jfs"
      "ksmbd"
      "minix"
      "nilfs2"
      "omfs"
      "qnx4"
      "qnx6"
      "squashfs"
      "sysv"
      "udf"
      "vivid"
      "firewire-core"
      "thunderbolt"
    ];

    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Output"
      options rtw88_core disable_lps_deep=y
      options rtw88_pci disable_aspm=y
    '';
  };

  systemd = {
    coredump = {
      extraConfig = ''
        Storage=none
        ProcessSizeMax=0
      '';
    };
  };

  services = {
    fstrim = {
      enable = true;
    };
  };

  funkouna = {
    services = {
      kanata = {
        enable = true;
      };

      tpm = {
        enable = true;
      };

      printing = {
        enable = false;
      };

      bluetooth = {
        enable = true;
      };

      audio = {
        enable = true;
      };

      flatpak = {
        enable = true;
      };

      kdeConnect = {
        enable = true;
      };

      sddm = {
        enable = true;
      };
    };

    programs = {
      plasma = {
        enable = true;
      };

      nh = {
        enable = false;
      };

      spotify = {
        enable = true;
      };

      minecraft = {
        enable = true;
      };

      hyprland = {
        enable = false;
      };
    };

    impermanence = {
      enable = true;
    };
  };
}
