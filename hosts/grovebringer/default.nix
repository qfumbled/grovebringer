{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [
    (if builtins.pathExists ./hardware.nix 
     then ./hardware.nix 
     else /etc/hardware-configuration.nix)
  ];

  networking.hostName = "grovebringer";

  # Disable X11 completely - Wayland only
  services.xserver.enable = false;  # Completely disable X11
  
  # SDDM with Wayland support only
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  
  # Enable Plasma 6 (Wayland)
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Configure pipewire for sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.pulseaudio.enable = false;  # Disable pulseaudio as we're using pipewire

  # User configuration
  users.users.grovesauce = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "storage" "docker"];
    group = "grovesauce";
  };

  users.groups.grovesauce = {};

  funkouna = {
    services = {
      bluetooth.enable = true;
      audio.enable = true;
      ly.enable = false;  # Disable ly as we're using SDDM
      flatpak.enable = true;
      kde-connect.enable = true;
    };

    programs = {
      wayland.enable = false;  # Disable Wayland for now
      steam.enable = false;
      spotify.enable = true;
    };

    system = {
      stylix.enable = true;
      networking.enable = true;
      security.enable = true;  # Enable security hardening
    };

    impermanence.enable = false;
  };
}