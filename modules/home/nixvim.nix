{ config, lib, pkgs, inputs, ... }:
{
  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      colorschemes = {
        gruvbox = {
          enable = true;
          darkMode = true;
        };
      };

      opts = {
        number = true;
        relativenumber = true;
        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
        smartindent = true;
        wrap = false;
        undofile = true;
        hlsearch = false;
        incsearch = true;
        scrolloff = 8;
        signcolumn = "yes";
        colorcolumn = "80";
      };

      globals = {
        mapleader = " ";
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>w";
          action = ":write<CR>";
          options = { desc = "Save"; };
        }
        {
          mode = "n";
          key = "<leader>q";
          action = ":quit<CR>";
          options = { desc = "Quit"; };
        }
        {
          mode = "n";
          key = "<leader>h";
          action = ":nohlsearch<CR>";
          options = { desc = "Clear search"; };
        }
      ];

      plugins = {
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
          };
        };

        which-key = {
          enable = true;
        };

        treesitter = {
          enable = true;
          settings = {
            highlight = {
              enable = true;
            };
            indent = {
              enable = true;
            };
          };
        };

        lsp = {
          enable = true;
          servers = {
            nil_ls.enable = true;
            rust_analyzer.enable = true;
            tsserver.enable = true;
            lua_ls.enable = true;
          };
        };

        luasnip = {
          enable = true;
        };

        cmp = {
          enable = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
          };
        };

        cmp-nvim-lsp = {
          enable = true;
        };

        cmp-luasnip = {
          enable = true;
        };

        cmp-path = {
          enable = true;
        };

        cmp-buffer = {
          enable = true;
        };
      };
    };
  };
}
