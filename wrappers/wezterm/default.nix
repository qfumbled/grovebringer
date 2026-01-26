{
  pkgs,
  lib,
  extraDeps ? [],
  extraFlags ? "",
  ...
}:

let
  deps = [
    pkgs.wezterm
  ] ++ extraDeps;

  path = lib.makeBinPath deps;

  weztermConfig = pkgs.writeText "wezterm.lua" ''
    local wezterm = require "wezterm"
    local config = {}

    config.font = wezterm.font_with_fallback { "0xProto", "monospace" }
    config.font_size = 12.0
    config.hide_tab_bar_if_only_one_tab = true
    config.window_background_opacity = 1.0
    config.window_close_confirmation = "NeverPrompt"
    config.enable_wayland = true

    config.window_padding = {
      left = 20,
      right = 20,
      top = 20,
      bottom = 20,
    }

    local solarized = {
      base00 = "#fdf6e3",  -- background
      base01 = "#eee8d5",  -- bg highlight
      base02 = "#93a1a1",  -- comments / selection bg
      base03 = "#839496",  -- body text / subtle
      base04 = "#657b83",  -- foreground / default text
      base05 = "#586e75",  -- emphasis / darker text
      base06 = "#073642",  -- dark emphasis
      base07 = "#002b36",  -- darkest / shadows
      base08 = "#dc322f",  -- red / errors
      base09 = "#cb4b16",  -- orange / warnings
      base0A = "#b58900",  -- yellow / highlights
      base0B = "#859900",  -- green / success
      base0C = "#2aa198",  -- cyan / info
      base0D = "#268bd2",  -- blue / links
      base0E = "#6c71c4",  -- violet / keywords
      base0F = "#d33682",  -- magenta / special
    }

    config.colors = {
      foreground = solarized.base04,
      background = solarized.base00,
      cursor_bg = solarized.base04,
      cursor_fg = solarized.base00,
      cursor_border = solarized.base04,
      selection_fg = solarized.base06,
      selection_bg = solarized.base02,

      ansi = {
        solarized.base02,  -- black (gray)
        solarized.base08,  -- red
        solarized.base0B,  -- green
        solarized.base0A,  -- yellow
        solarized.base0D,  -- blue
        solarized.base0E,  -- magenta
        solarized.base0C,  -- cyan
        solarized.base04,  -- white (light gray)
      },

      brights = {
        solarized.base03,  -- bright black
        solarized.base08,  -- bright red
        solarized.base0B,  -- bright green
        solarized.base09,  -- bright yellow (orange)
        solarized.base0D,  -- bright blue
        solarized.base0E,  -- bright magenta
        solarized.base0C,  -- bright cyan
        solarized.base05,  -- bright white
      },
    }

    return config
  '';

  wezterm = pkgs.stdenv.mkDerivation {
    pname = "wezterm-wrapped";
    version = "1.0";

    nativeBuildInputs = [ pkgs.makeWrapper ];
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin

      makeWrapper ${pkgs.wezterm}/bin/wezterm $out/bin/wezterm \
        --prefix PATH : ${path} \
        --set WEZTERM_CONFIG_FILE ${weztermConfig} \
        --add-flags "${extraFlags}"
    '';
  };
in
{
  inherit wezterm;
}
