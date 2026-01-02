{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    xdg-utils
    wirelesstools
    wget
    yq
    brightnessctl
    firefox
    git
    unzip
    zip
    swaybg
    mako
    waybar
    polkit_gnome
    wlsunset
    wayshot
    slurp
    wl-clipboard
    libnotify
    swappy
    fuzzel
    fastfetch
    # Multimedia libraries for Spotify
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];
}
