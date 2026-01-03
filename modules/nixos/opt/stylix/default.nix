{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.system.stylix;
in
{
  config = mkIf (cfg.enable && false) {  
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night.yaml";
      
      fonts = {
        monospace = {
          package = lib.mkForce pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        
        sansSerif = {
          package = lib.mkForce pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
      };
      
      targets = {
        gtk.enable = true;
        console.enable = true;
      };
    };
  };
}
