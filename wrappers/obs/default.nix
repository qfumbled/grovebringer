{
  pkgs,
  lib,
  extraPlugins ? [],
  enableVirtualCamera ? false,
  enableNvidiaSupport ? false,
  enableVaapiSupport ? true,
}:

let
  baseObs =
    if enableNvidiaSupport then
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    else
      pkgs.obs-studio;

  plugins =
    with pkgs.obs-studio-plugins;
      [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-gstreamer
        obs-vkcapture
      ]
      ++ lib.optionals enableVaapiSupport [
        obs-vaapi
      ]
      ++ extraPlugins;

in
pkgs.symlinkJoin {
  name = "obs-studio-wrapped";

  paths = [ baseObs ] ++ plugins;

  buildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/obs \
      ${lib.optionalString enableVirtualCamera "--set OBS_VKCAPTURE 1"} \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [
        pkgs.libv4l
      ]}"
  '';

  meta = baseObs.meta // {
    description = "OBS Studio with plugins (clean wrapper)";
  };
}
