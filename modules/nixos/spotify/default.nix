{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Spotify Wayland configuration
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  # Add Spotify and required multimedia libraries
  environment.systemPackages = with pkgs; [
    spotify
    spotify-player  # Terminal alternative
    # Essential multimedia libraries
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    # Audio support (PipeWire compatible)
    alsa-lib
    libpulseaudio
    # Codecs
    ffmpeg
    # X11 libraries for compatibility
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    xorg.libXtst
    xorg.libXScrnSaver
  ];

  # Enable required services
  services.dbus.enable = true;
}
