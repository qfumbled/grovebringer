{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  gcp =
    (import ../../../../packages/gcp/default.nix {
      inherit pkgs lib;
    }).gcp;

  njem =
    (import ../../../../packages/njem/default.nix {
      inherit pkgs lib;
    }).njem;

  zed =
    (import ../../../../wrappers/zed/default.nix {
      inherit pkgs lib;
    }).zed;

  zsh =
    (import ../../../../wrappers/zsh/default.nix {
      inherit pkgs lib;
    }).zsh;

  spotify =
    (import ../../../../wrappers/spotify/default.nix {
      inherit pkgs lib;
    }).spotify;

  wmenu =
    (import ../../../../wrappers/wmenu/default.nix {
      inherit pkgs lib;
    }).wmenu;

    wezterm =
      (import ../../../../wrappers/wezterm/default.nix {
        inherit pkgs lib;
      }).wezterm;

in
{
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.sops
    pkgs.microfetch
    pkgs.age
    pkgs.bat
    pkgs.xdg-utils
    pkgs.wirelesstools
    pkgs.wget
    pkgs.yq
    pkgs.brightnessctl
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
    pkgs.swaybg
    pkgs.fastfetch
    pkgs.obs-studio
    gcp
    zed
    zsh
    njem
    spotify
    wmenu
    wezterm
  ];
}
