{
  lib,
  pkgs, 
  ... 
}:

let
  utils = import ../default.nix { inherit lib pkgs; };
  inherit (utils) mkWrapper;
  
  # Create the wrapped spotify
  spotify-wrapped = mkWrapper {
    package = pkgs.spotify;
    name = "spotify";
    arguments = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
    env = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
    };
  };
  
  spotify-wayland = pkgs.symlinkJoin {
    name = "spotify-wayland";
    paths = [ spotify-wrapped ];
    postBuild = ''
      ln -sf $out/bin/spotify-unwrapped $out/bin/spotify-wayland
    '';
  };
in
{
  name = "spotify";
  
  inherit spotify-wrapped spotify-wayland;
}
