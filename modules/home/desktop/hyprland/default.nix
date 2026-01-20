{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  inherit (pkgs)
    brightnessctl
    brillo
    cliphist
    dbus
    glib
    grim
    gtk3
    hyprpicker
    libcanberra-gtk3
    libnotify
    pamixer
    sassc
    slurp
    tesseract5
    wf-recorder
    wl-clipboard
    wlr-randr
    wtype
    xorg
    ydotool
  ;

  ocrScript = pkgs.writeShellScriptBin "wl-ocr" ''
    ${lib.getExe grim} -g "$(${lib.getExe slurp})" -t ppm - | ${tesseract5}/bin/tesseract - - | ${wl-clipboard}/bin/wl-copy
    ${libnotify}/bin/notify-send "$(${wl-clipboard}/bin/wl-paste)"
  '';

  volumectl = pkgs.writeShellScriptBin "volumectl" ''
    case "$1" in
      up)
        ${pamixer}/bin/pamixer -i "$2"
        ;;
      down)
        ${pamixer}/bin/pamixer -d "$2"
        ;;
      toggle-mute)
        ${pamixer}/bin/pamixer -t
        ;;
    esac

    volume_percentage="$(${pamixer}/bin/pamixer --get-volume)"
    isMuted="$(${pamixer}/bin/pamixer --get-mute)"

    if [ "$isMuted" = "true" ]; then
      ${libnotify}/bin/notify-send --transient -u normal -a "VOLUMECTL" -i audio-volume-muted-symbolic "VOLUMECTL" "Volume Muted"
    else
      ${libnotify}/bin/notify-send --transient -u normal -a "VOLUMECTL" -h string:x-canonical-private-synchronous:volumectl -h int:value:"$volume_percentage" -i audio-volume-high-symbolic "VOLUMECTL" "Volume: $volume_percentage%"
      ${libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
    fi
  '';

  lightctl = pkgs.writeShellScriptBin "lightctl" ''
    case "$1" in
      up)
        ${brightnessctl}/bin/brightnessctl -q s +"$2"%
        ;;
      down)
        ${brightnessctl}/bin/brightnessctl -q s "$2"%-
        ;;
    esac

    brightness_percentage=$((($(${brightnessctl}/bin/brightnessctl g) * 100) / $(${brightnessctl}/bin/brightnessctl m)))
    ${libnotify}/bin/notify-send --transient -u normal -a "LIGHTCTL" -h string:x-canonical-private-synchronous:lightctl -h int:value:"$brightness_percentage" -i display-brightness-symbolic "LIGHTCTL" "Brightness: $brightness_percentage%"
  '';
in
{
  options = {
    funkouna = {
      desktop = {
        hyprland = {
          enable = mkEnableOption "Hyprland window manager";
        };
      };
    };
  };

  imports = [
    ./config
  ];

  config = mkIf config.funkouna.desktop.hyprland.enable {
    home = {
      packages = [
        brightnessctl
        brillo
        cliphist
        dbus
        glib
        grim
        gtk3
        hyprpicker
        libcanberra-gtk3
        libnotify
        pamixer
        sassc
        slurp
        tesseract5
        wf-recorder
        wl-clipboard
        wlr-randr
        wtype
        xorg.xprop
        ydotool

        ocrScript
        volumectl
        lightctl
      ];

      sessionVariables = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
      };
    };

    systemd = {
      user = {
        targets = {
          tray = {
            Unit = {
              Description = "Home Manager System Tray";
              Requires = [ "graphical-session-pre.target" ];
            };
          };
        };
      };
    };

    wayland = {
      windowManager = {
        hyprland = {
          enable = true;
          package = null;
          portalPackage = null;
          systemd = {
            enable = false;
          };
          xwayland = {
            enable = true;
          };
        };
      };
    };
  };
}
