{
  lib,
  pkgs,
}:
{
  spotify =
    pkgs.symlinkJoin {
      name = "spotify-wrapped";

      paths = [
        pkgs.spotify
      ];

      nativeBuildInputs = [
        pkgs.makeWrapper
      ];

      postBuild = ''
        wrapProgram $out/bin/spotify \
          --add-flags "--disable-background-timer-throttling" \
          --add-flags "--disable-renderer-backgrounding" \
          --add-flags "--disable-backgrounding-occluded-windows" \
          --add-flags "--process-per-site" \
          --add-flags "--enable-gpu-rasterization" \
          --add-flags "--enable-zero-copy" \
          --add-flags "--disable-features=CalculateNativeWinOcclusion" \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "--ozone-platform=wayland"
      '';

      passthru = {
        unwrapped = pkgs.spotify;
      };

      meta =
        pkgs.spotify.meta
        // {
          priority =
            (pkgs.spotify.meta.priority or 0) - 1;
        };
    };
}
