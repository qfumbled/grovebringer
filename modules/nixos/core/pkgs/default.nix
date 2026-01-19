{
  lib,
  pkgs,
  ...
}:
let
  gcp = (import ../../../../packages/gcp/default.nix { inherit pkgs lib; }).gcp;
  spotify-wayland = (import ../../../../packages/spotify/default.nix { inherit pkgs lib; }).spotify-wayland;
  zed = (import ../../../../packages/zed/default.nix { inherit pkgs lib; }).zed;
in
{
  environment = {
    systemPackages = with pkgs; [
      sops
      age
      bat
      xdg-utils
      wirelesstools
      wget
      yq
      brightnessctl
      git
      unzip
      zip
      polkit_gnome
      nix-prefetch-git
      blueman
      loupe
      celluloid
      wl-clipboard
      libnotify
      swappy
      fuzzel
      fastfetch
      obs-studio
      gcp
      spotify-wayland
      zed
    ];
  };
}
