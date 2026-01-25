{
  pkgs,
  lib ? pkgs.lib,
  extraPlugins ? [],
  extraLuaFiles ? [],
  extraRC ? "",
  ...
}:

let
  nvimConfig = pkgs.stdenvNoCC.mkDerivation {
    name = "nvim-config";
    src = ./.;

    installPhase = ''
      mkdir -p $out/lua
      cp ${lib.concatStringsSep " " ([
        ./init.lua
        ./blink-cmp.lua
        ./ccc.lua
        ./conform.lua
        ./ibl.lua
        ./mini-bufremove.lua
        ./mini-statusline.lua
        ./telescope.lua
        ./treesitter.lua
        ./mini-tabline.lua
      ] ++ extraLuaFiles)} $out/lua/
    '';
  };

  plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    lazygit-nvim
    mini-statusline
    mini-bufremove
    mini-tabline
    telescope-nvim
    (nvim-treesitter.withPlugins (p: with p; [
      rust
      nix
      lua
      java
      vim
      regex
      bash
      markdown
      markdown_inline
    ]))
    conform-nvim
    indent-blankline-nvim
    blink-cmp
    ccc-nvim
    plenary-nvim
    cord-nvim
  ] ++ extraPlugins;

  nvimWrapped = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
    configure = {
      customRC = ''
        set runtimepath^=${nvimConfig}
        lua require('init')
        ${extraRC}
      '';

      packages = {
        all = {
          start = plugins;
          opt = [];
        };
      };
    };
  };

  neovim = pkgs.runCommand "neovim-wrapped" {
    inherit (nvimWrapped) meta;
  } ''
    mkdir -p $out/bin

    ln -s ${nvimWrapped}/bin/nvim $out/bin/nvim
    ln -s $out/bin/nvim $out/bin/vim
    ln -s $out/bin/nvim $out/bin/vi

    for dir in ${nvimWrapped}/*; do
      if [ "$(basename "$dir")" != "bin" ]; then
        ln -s "$dir" $out/
      fi
    done
  '';
in
{
  neovim = neovim;
}
