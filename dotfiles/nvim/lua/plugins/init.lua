return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- VimTeX
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = "output",
        out_dir = "output"
      }
    end
  },
  -- R
  {
      "R-nvim/R.nvim",
       -- Only required if you also set defaults.lazy = true
      ft = { "r" },
      lazy = false,
      -- R.nvim is still young and we may make some breaking changes from time
      -- to time (but also bug fixes all the time). If configuration stability
      -- is a high priority for you, pin to the latest minor version, but unpin
      -- it and try the latest version before reporting an issue:
      -- version = "~0.1.0"
      config = function()
          -- Create a table with the options to be passed to setup()
          ---@type RConfigUserOpts
          local opts = {
              hook = {
                  on_filetype = function()
                      vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
                      vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
                  end
              },
              R_args = {"--quiet", "--no-save"},
              min_editor_width = 72,
              rconsole_width = 78,
              objbr_mappings = { -- Object browser keymap
                  c = 'class', -- Call R functions
                  ['<localleader>gg'] = 'head({object}, n = 15)', -- Use {object} notation to write arbitrary R code.
                  v = function()
                      -- Run lua functions
                      require('r.browser').toggle_view()
                  end
              },
              disable_cmds = {
                  "RClearConsole",
                  "RCustomStart",
                  "RSPlot",
                  "RSaveClose",
              },
          }
          -- Check if the environment variable "R_AUTO_START" exists.
          -- If using fish shell, you could put in your config.fish:
          -- alias r "R_AUTO_START=true nvim"
          if vim.env.R_AUTO_START == "true" then
              opts.auto_start = "on startup"
              opts.objbr_auto_start = true
          end
          require("r").setup(opts)
      end,
  },
  -- -- Autocompletion for R.Nvim
  -- {
  --   "R-nvim/cmp-r",
  --   {
  --       "hrsh7th/nvim-cmp",
  --       config = function()
  --           require("cmp").setup({ sources = {{ name = "cmp_r" }}})
  --           require("cmp_r").setup({})
  --       end,
  --   },
  -- },
  -- Docker
  {
      'krisajenkins/telescope-docker.nvim',
      event = 'VeryLazy',
      dependencies = {
          'nvim-telescope/telescope.nvim',
      },
      config = function()
          require('telescope').load_extension('telescope_docker')
          require('telescope_docker').setup {}
      end,

      -- Example keybindings. Adjust these to suit your preferences or remove
      --   them entirely:
      keys = {
          {
              '<Leader>dv',
              ':Telescope telescope_docker docker_volumes<CR>',
              desc = '[D]ocker [V]olumes',
          },
          {
              '<Leader>di',
              ':Telescope telescope_docker docker_images<CR>',
              desc = '[D]ocker [I]mages',
          },
          {
              '<Leader>dp',
              ':Telescope telescope_docker docker_ps<CR>',
              desc = '[D]ocker [P]rocesses',
          },
      },
  },
  -- Mason for LSP server config
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "texlab", -- LSP for LaTeX
        "pyright", -- LSP for Python
        "black", -- Autoformatting for Python
      },
    },
  },
-- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
  },
}
