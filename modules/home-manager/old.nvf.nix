{ pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = false;
      vimAlias = true;
      # --- Theme (poimandres) ---
      # nvf doesn't have poimandres built-in, so we load it via extraPlugins
      extraPlugins = {
        poimandres = {
          package = pkgs.vimUtils.buildVimPlugin {
            name = "poimandres-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "olivercederborg";
              repo = "poimandres.nvim";
              rev = "main";
              sha256 = "sha256-c0c0Q1W9Nfen9jYiDUISSlCHOY+XJuNPiBCOw4masUs=";
            };
            nvimSkipModule = "poimandres.highlights";
          };
          setup = ''
            require('poimandres').setup {}
            vim.cmd.colorscheme "poimandres"
          '';
        };
      };

      # --- Options (from options.lua) ---
      options = {
        hlsearch = false;
        incsearch = true;
        number = true;
        relativenumber = true;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        wrap = false;
        mouse = "a";
        clipboard = "unnamedplus";
        breakindent = true;
        undofile = true;
        swapfile = false;
        backup = false;
        ignorecase = true;
        smartcase = true;
        scrolloff = 8;
        signcolumn = "yes";
        updatetime = 50;
        timeoutlen = 300;
        completeopt = "menuone,noselect";
        termguicolors = true;
      };

      globals.mapleader = " ";

      # --- Keymaps (from keymaps.lua) ---
      keymaps = [
        { mode = ["n" "v"]; key = "<Space>"; action = "<Nop>"; silent = true; }

        # Word wrap navigation
        { mode = "n"; key = "k"; action = "v:count == 0 ? 'gk' : 'k'"; expr = true; silent = true; }
        { mode = "n"; key = "j"; action = "v:count == 0 ? 'gj' : 'j'"; expr = true; silent = true; }

        # Diagnostics
        { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; desc = "Go to previous diagnostic"; }
        { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; desc = "Go to next diagnostic"; }
        { mode = "n"; key = "<leader>e"; action = "<cmd>lua vim.diagnostic.open_float()<CR>"; desc = "Open floating diagnostic"; }

        # File operations
        { mode = "n"; key = "<leader>rw"; action = "<cmd>Ex<CR>"; desc = "netrw"; }
        { mode = "n"; key = "<leader>w"; action = ":w<CR>"; }
        { mode = "n"; key = "<leader>q"; action = ":q!<CR>"; }
        { mode = "n"; key = "<leader>z"; action = ":wq<CR>"; }
        { mode = "n"; key = "<leader>f"; action = ":Format<CR>"; }

        # Move lines in visual mode
        { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; }
        { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; }

        # Clipboard
        { mode = "x"; key = "<leader>p"; action = ''"_dP''; }
        { mode = ["n" "v"]; key = "<leader>y"; action = ''"+y''; desc = "Yank to system clipboard"; }
        { mode = "n"; key = "<leader>Y"; action = ''"+Y''; desc = "Yank word to system clipboard"; }

        # Navigation
        { mode = "n"; key = "J"; action = "mzJ`z"; }
        { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
        { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
        { mode = "n"; key = "n"; action = "nzzzv"; }
        { mode = "n"; key = "N"; action = "Nzzzv"; }

        # Replace word under cursor
        { mode = "n"; key = "<leader>s"; action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"; desc = "Replace all current word"; }

        # LSP keymaps
        { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; }
        { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; }
        { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; }
        { mode = "n"; key = "<C-K>"; action = "<cmd>lua vim.lsp.buf.signature_help()<CR>"; }
      ];

      # --- LSP (replaces Mason + mason-lspconfig) ---
      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
          gopls.enable = true;
          cssls.enable = true;
          html.enable = true;
          ts-ls.enable = true;      # tsserver is now ts-ls
          omnisharp.enable = true;
        };
      };

      treesitter = {
        enable = true;
        indent = { enable = true; };
        highlight = { enable = true; };
      };

      autocmds = [
        {
          event = [ "TextYankPost" ];
          callback = lib.generators.mkLuaInline ''
            function()
              vim.highlight.on_yank()
            end
          '';
        }
      ];
    };
  };
}
