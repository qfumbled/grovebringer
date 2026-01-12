{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.funkouna.programs.spotify;
in
{
  options = {
    funkouna = {
      programs = {
        spotify = {
          enable = mkEnableOption "Enable Spotify with multimedia libraries and Wayland support";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    environment.systemPackages = with pkgs; [
      spotify
      spotify-player
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-libav
      alsa-lib
      libpulseaudio
      ffmpeg
      xorg.libX11
      xorg.libXext
      xorg.libXrandr
      xorg.libXtst
      xorg.libXScrnSaver
    ];
  };
}
