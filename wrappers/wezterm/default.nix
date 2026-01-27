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

    -- Solarized Dark exact palette
    local solarized = {
      base00 = "#002B36",  -- background
      base01 = "#063C4A",  -- alternative bg / UI elements
      base02 = "#043643",  -- selection bg
      base03 = "#657B83",  -- comments / subtle text
      base04 = "#93A1A1",  -- secondary text
      base05 = "#93A1A1",  -- default foreground
      base06 = "#FDF6E3",  -- emphasis / lighter
      base07 = "#FDF6E3",  -- brightest
      base08 = "#DC322F",  -- red
      base09 = "#B58900",  -- yellow / highlights
      base0A = "#B58900",  -- yellow
      base0B = "#859900",  -- green
      base0C = "#2AA198",  -- cyan
      base0D = "#268BD2",  -- blue
      base0E = "#6C71C4",  -- magenta
      base0F = "#6C71C4",  -- magenta variant
    }

    config.colors = {
      foreground = solarized.base05,
      background = solarized.base00,

      cursor_bg = solarized.base05,
      cursor_fg = solarized.base00,
      cursor_border = solarized.base05,

      selection_fg = solarized.base05,
      selection_bg = solarized.base02,

      ansi = {
        solarized.base03,  -- black
        solarized.base08,  -- red
        solarized.base0B,  -- green
        solarized.base0A,  -- yellow
        solarized.base0D,  -- blue
        solarized.base0E,  -- magenta
        solarized.base0C,  -- cyan
        solarized.base05,  -- white
      },

      brights = {
        solarized.base03,  -- bright black
        solarized.base08,  -- bright red
        solarized.base0B,  -- bright green
        solarized.base09,  -- bright yellow
        solarized.base0D,  -- bright blue
        solarized.base0E,  -- bright magenta
        solarized.base0C,  -- bright cyan
        solarized.base07,  -- bright white
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
