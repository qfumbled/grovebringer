{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.funkouna.desktop.river;
  mod = cfg.modKey;
in
{
  options = {
    funkouna = {
      desktop = {
        river = {
          enable = mkEnableOption "River window manager";

          modKey = mkOption {
            type = types.str;
            default = "Super";
            description = "Primary mod key used for river keybinds";
          };

          wallpaper = mkOption {
            type = types.str;
            default = "";
            description = "Path to wallpaper image";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        river-classic
        rivercarro
        grim
        slurp
        wl-clipboard
        brillo
        swww
      ];
    };

    wayland = {
      windowManager = {
        river = {
          enable = true;
          xwayland.enable = true;

          extraSessionVariables = {
            WLR_NO_HARDWARE_CURSORS = "1";
            XDG_CURRENT_DESKTOP = "River";
          };

          settings = {
            map-normal = {
              "${mod} Return" = "spawn foot";
              "${mod} q" = "close";
              "${mod} d" = "spawn fuzzel";
              "${mod}+Shift q" = "exit";
              "${mod}+Shift Return" = "spawn foot";
              "${mod} Space" = "toggle-float";
              "${mod}+Shift Space" = "toggle-fullscreen";
              "${mod} Tab" = "focus-view next";
              "${mod}+Shift Tab" = "focus-view previous";
              "${mod} j" = "focus-view next";
              "${mod} k" = "focus-view previous";
              "${mod}+Shift j" = "swap next";
              "${mod}+Shift k" = "swap previous";
              "${mod} F" = "toggle-fullscreen";
            };

            map-pointer-normal = {
              "${mod} BTN_LEFT" = "move-view";
              "${mod} BTN_RIGHT" = "resize-view";
            };
          };

          extraConfig = ''
            # Set keyboard repeat rate
            riverctl set-repeat 40 300
            
            # Cursor settings
            riverctl hide-cursor when-typing enabled
            riverctl focus-follows-cursor always
            riverctl set-cursor-warp on-focus-change
            
            # Map tags
            for i in {1..9}; do
              riverctl map normal ${mod} $i set-focused-tags $((1 << (i - 1)))
              riverctl map normal ${mod}+Shift $i set-view-tags $((1 << (i - 1)))
              riverctl map normal ${mod}+Control $i toggle-focused-tags $((1 << (i - 1)))
              riverctl map normal ${mod}+Control+Shift $i toggle-view-tags $((1 << (i - 1)))
            done

            # Touchpad configuration
            for pad in $(riverctl list-inputs | grep -i touchpad); do
              riverctl input $pad events enabled
              riverctl input $pad tap enabled
            done

            # Specific touchpad configuration (from your old config)
            riverctl input pointer-961030-Pine64_Pinebook_Pro_Touchpad tap enabled
            riverctl input pointer-9610-30-Pine64_Pinebook_Pro_Touchpad natural-scroll enabled

            # Function keys
            for mode in normal locked; do
              riverctl map $mode None XF86MonBrightnessUp   spawn 'brillo -A 5'
              riverctl map $mode None XF86MonBrightnessDown spawn 'brillo -U 5'
              riverctl map $mode None XF86AudioRaiseVolume spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ +5%'
              riverctl map $mode None XF86AudioLowerVolume spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ -5%'
              riverctl map $mode None XF86AudioMute        spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
              riverctl map-switch $mode lid close spawn 'wlr-randr --output eDP-1 --off'
              riverctl map-switch $mode lid open spawn 'wlr-randr --output eDP-1 --on'
            done

            riverctl map normal None Print spawn 'grim -g "$(slurp)" - | wl-copy'

            # Startup applications
            riverctl spawn swww-daemon
            ${lib.optionalString (cfg.wallpaper != "") ''
              riverctl spawn swww img ${cfg.wallpaper}
            ''}
          '';
        };
      };
    };
  };
}