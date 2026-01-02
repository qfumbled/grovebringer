{
  pkgs,
  config,
  ...
}: {
  home.file.".config/labwc/autostart".text = ''
    ${pkgs.swaybg}/bin/swaybg -i /home/${config.home.username}/grovebringer/home/shared/walls/test.jpg &

    mako >/dev/null 2>&1 &
    waybar >/dev/null 2>&1 &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
  '';
}