{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.services.virtualisation;
in
{
  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd.enable = true;
      docker.enable = true;
    };
    
    programs.dconf.enable = true;
    
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-vdagent
      win-spice
    ];
  };
}
