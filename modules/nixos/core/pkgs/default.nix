{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  gcp = (import ../../../../packages/gcp/default.nix { inherit pkgs lib; }).gcp;
  zed = (import ../../../../packages/zed/default.nix { inherit pkgs lib; }).zed;
  zsh = (import ../../../../packages/zsh/default.nix { inherit pkgs lib; }).zsh;
  in
{
  environment = {
    systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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
      swaybg
      fastfetch
      obs-studio
      gcp
      zed
      zsh
    ];
  };
}
