{
  pkgs,
  config,
  ...
}: {
  home.file.".config/labwc/autostart".text = ''

    # ${pkgs.wlsunset}/bin/wlsunset -l 43.7 -L -79.4 -t 3500 -T 6500 &
    ${pkgs.swaybg}/bin/swaybg -i ../../home/shared/walls/test.jpg &

    mako >/dev/null 2>&1 &
    waybar >/dev/null 2>&1 &
    # ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
  '';
}