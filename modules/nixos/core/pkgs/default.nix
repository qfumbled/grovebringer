{
  lib,
  config,
  pkgs,
  ...
}:

let
  gcp = import ../../../../packages/gcp/default.nix { inherit pkgs; };
in
{
  environment.systemPackages = [
    pkgs.sops
    pkgs.age
    pkgs.bat
    pkgs.xdg-utils
    pkgs.wirelesstools
    pkgs.wget
    pkgs.yq
    pkgs.brightnessctl
    pkgs.firefox
    pkgs.git
    pkgs.unzip
    pkgs.zip
    pkgs.polkit_gnome
    pkgs.nix-prefetch-git
    pkgs.blueman
    pkgs.loupe
    pkgs.celluloid
    pkgs.wl-clipboard
    pkgs.libnotify
    pkgs.swappy
    pkgs.fuzzel
    pkgs.fastfetch
    pkgs.obs-studio
    gcp
  ];
}
