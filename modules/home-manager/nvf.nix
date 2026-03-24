{ pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = false;
      vimAlias = true;

      # --- Theme (poimandres) ---
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

        vim-fugitive = {
          package = pkgs.vimPlugins.vim-fugitive;
        };

        vim-rhubarb = {
          package = pkgs.vimPlugins.vim-rhubarb;
        };

        harpoon = {
          package = pkgs.vimPlugins.harpoon2;
          setup = ''
            require('harpoon'):setup {}
          '';
        };

        undotree = {
          package = pkgs.vimPlugins.undotree;
        };

        zen-mode = {
          package = pkgs.vimPlugins.zen-mode-nvim;
        };

        none-ls = {
          package = pkgs.vimPlugins.none-ls-nvim;
          setup = ''
            local null_ls = require("null-ls")
            null_ls.setup({
              sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettierd,
              },
            })
          '';
        };
      };

      # --- Options ---
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

      # --- Keymaps ---
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
        { mode = "n"; key = "<leader>f"; action = "<cmd>lua vim.lsp.buf.format()<CR>"; desc = "Format"; }

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

        # Harpoon
        { mode = "n"; key = "<leader>a"; action = "<cmd>lua require('harpoon'):list():add()<CR>"; desc = "Harpoon file"; }
        { mode = "n"; key = "<C-e>"; action = "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>"; desc = "Harpoon quick menu"; }
        { mode = "n"; key = "<C-h>"; action = "<cmd>lua require('harpoon'):list():select(1)<CR>"; desc = "Harpoon file 1"; }
        { mode = "n"; key = "<C-j>"; action = "<cmd>lua require('harpoon'):list():select(2)<CR>"; desc = "Harpoon file 2"; }
        { mode = "n"; key = "<C-k>"; action = "<cmd>lua require('harpoon'):list():select(3)<CR>"; desc = "Harpoon file 3"; }
        { mode = "n"; key = "<C-l>"; action = "<cmd>lua require('harpoon'):list():select(4)<CR>"; desc = "Harpoon file 4"; }

        # Undotree
        { mode = "n"; key = "<leader>u"; action = "<cmd>UndotreeToggle<CR>"; desc = "Undotree"; }

        # Zen mode
        { mode = "n"; key = "<leader>zz"; action = "<cmd>lua require('zen-mode').setup({ window = { width = 90, options = {} } }); require('zen-mode').toggle(); vim.wo.wrap = false; vim.wo.number = true; vim.wo.rnu = true<CR>"; desc = "Zen mode (wide)"; }
        { mode = "n"; key = "<leader>zZ"; action = "<cmd>lua require('zen-mode').setup({ window = { width = 80, options = {} } }); require('zen-mode').toggle(); vim.wo.wrap = false; vim.wo.number = false; vim.wo.rnu = false; vim.opt.colorcolumn = '0'<CR>"; desc = "Zen mode (narrow)"; }

        # Telescope
        { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; desc = "[F]ind [F]iles"; }
        { mode = "n"; key = "<leader>gf"; action = "<cmd>Telescope live_grep<CR>"; desc = "[G]rep [F]iles"; }

        # Debug (DAP)
        { mode = "n"; key = "<F5>"; action = "<cmd>lua require('dap').continue()<CR>"; desc = "Debug: Start/Continue"; }
        { mode = "n"; key = "<F1>"; action = "<cmd>lua require('dap').step_into()<CR>"; desc = "Debug: Step Into"; }
        { mode = "n"; key = "<F2>"; action = "<cmd>lua require('dap').step_over()<CR>"; desc = "Debug: Step Over"; }
        { mode = "n"; key = "<F3>"; action = "<cmd>lua require('dap').step_out()<CR>"; desc = "Debug: Step Out"; }
        { mode = "n"; key = "<F7>"; action = "<cmd>lua require('dapui').toggle()<CR>"; desc = "Debug: See last session result"; }
        { mode = "n"; key = "<leader>b"; action = "<cmd>lua require('dap').toggle_breakpoint()<CR>"; desc = "Debug: Toggle Breakpoint"; }
        { mode = "n"; key = "<leader>B"; action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"; desc = "Debug: Set Breakpoint"; }

        # Gitsigns
        { mode = "n"; key = "<leader>hs"; action = "<cmd>lua require('gitsigns').stage_hunk()<CR>"; desc = "Git stage hunk"; }
        { mode = "v"; key = "<leader>hs"; action = "<cmd>lua require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })<CR>"; desc = "Git stage hunk"; }
        { mode = "n"; key = "<leader>hr"; action = "<cmd>lua require('gitsigns').reset_hunk()<CR>"; desc = "Git reset hunk"; }
        { mode = "v"; key = "<leader>hr"; action = "<cmd>lua require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })<CR>"; desc = "Git reset hunk"; }
        { mode = "n"; key = "<leader>hS"; action = "<cmd>lua require('gitsigns').stage_buffer()<CR>"; desc = "Git stage buffer"; }
        { mode = "n"; key = "<leader>hu"; action = "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>"; desc = "Undo stage hunk"; }
        { mode = "n"; key = "<leader>hR"; action = "<cmd>lua require('gitsigns').reset_buffer()<CR>"; desc = "Git reset buffer"; }
        { mode = "n"; key = "<leader>hp"; action = "<cmd>lua require('gitsigns').preview_hunk()<CR>"; desc = "Preview git hunk"; }
        { mode = "n"; key = "<leader>hb"; action = "<cmd>lua require('gitsigns').blame_line({ full = false })<CR>"; desc = "Git blame line"; }
        { mode = "n"; key = "<leader>hd"; action = "<cmd>lua require('gitsigns').diffthis()<CR>"; desc = "Git diff against index"; }
        { mode = "n"; key = "<leader>hD"; action = "<cmd>lua require('gitsigns').diffthis('~')<CR>"; desc = "Git diff against last commit"; }
        { mode = "n"; key = "<leader>tb"; action = "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>"; desc = "Toggle git blame line"; }
        { mode = "n"; key = "<leader>td"; action = "<cmd>lua require('gitsigns').toggle_deleted()<CR>"; desc = "Toggle git show deleted"; }
        { mode = ["o" "x"]; key = "ih"; action = ":<C-U>Gitsigns select_hunk<CR>"; desc = "Select git hunk"; }
      ];

      # --- LSP ---
      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
          gopls.enable = true;
          cssls.enable = true;
          html.enable = true;
          ts-ls.enable = true;
          omnisharp.enable = true;
        };
      };

      # --- Treesitter ---
      treesitter = {
        enable = true;
        indent.enable = true;
        highlight.enable = true;
      };

      # --- Statusline ---
      statusline.lualine = {
        enable = true;
        # Your lualine.lua used 'dracula' but poimandres is your theme now.
        # "auto" picks up the current colorscheme automatically.
        theme = "auto";
      };

      # --- Autopairs ---
      autopairs.nvim-autopairs.enable = true;

      # --- Autocomplete ---
      autocomplete.nvim-cmp = {
        enable = true;
        setupOpts = {
          window = {
            completion = lib.generators.mkLuaInline "require('cmp').config.window.bordered()";
            documentation = lib.generators.mkLuaInline "require('cmp').config.window.bordered()";
          };
        };
      };

      # --- Snippets (replaces LuaSnip + friendly-snippets manual setup) ---
      snippets.luasnip.enable = true;

      # --- Telescope ---
      telescope.enable = true;

      # --- Git ---
      git = {
        enable = true;
        gitsigns = {
          enable = true;
          setupOpts.signs = {
            add.text = "+";
            change.text = "~";
            delete.text = "_";
            topdelete.text = "‾";
            changedelete.text = "~";
          };
        };
      };

      # --- DAP (Debugger) ---
      # Note: mason-nvim-dap is not available in NVF; delve for Go is installed
      # via the gopls language module. Add other DAP adapters via extraPlugins if needed.
      debugger.nvim-dap = {
        enable = true;
        ui.enable = true;
      };

      # --- Autocmds ---
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
