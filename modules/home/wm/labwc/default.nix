{pkgs, ...}: {
  imports = [./configuration];
  home.packages = [
    pkgs.labwc
    pkgs.swaybg
  ];
}