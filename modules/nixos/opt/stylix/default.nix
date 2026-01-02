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
  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night.yaml";
      
      image = ./assets/wallpaper.png;
      
      fonts = {
        monospace = {
          package = pkgs.nerdfonts;
          name = "JetBrainsMono Nerd Font";
        };
        
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
      };
      
      targets = {
        gtk.enable = true;
        qt.enable = true;
      };
    };
  };
}
