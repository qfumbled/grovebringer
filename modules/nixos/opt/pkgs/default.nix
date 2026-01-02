{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.system.pkgs;
in
{
  config = mkIf cfg.enable {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowInsecure = false;
      };
      
      overlays = [
        (final: prev: {
          # Custom packages here
        })
      ];
    };
    
    environment.systemPackages = with pkgs; [
      # Essential tools
      git
      curl
      wget
      vim
      htop
      btop
      
      # File management
      ranger
      lf
      
      # Development
      gcc
      python3
      nodejs
      
      # System utilities
      usbutils
      pciutils
      lsof
    ];
  };
}
