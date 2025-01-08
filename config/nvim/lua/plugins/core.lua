return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },
  -- Git and Git Signs
  { 'tpope/vim-fugitive' },
  { 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup({
      current_line_blame = true,
      current_line_blame_opts = { delay = 300 },
    })
  end },

  -- UI Enhancements
  { 'folke/noice.nvim', config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    })
  end },
  { 'MunifTanjim/nui.nvim' },
  { 'rcarriga/nvim-notify', config = function()
    require('notify').setup({
      stages = 'fade',
      timeout = 5000,
      background_colour = '#1e222a',
      text_colour = '#abb2bf',
      icons = {
        ERROR = ' ',
        WARN = ' ',
        INFO = ' ',
        DEBUG = ' ',
        TRACE = '✎ ',
      },
    })
  end },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-abolish' },
  { 'preservim/nerdcommenter' },
  { 'loctvl842/monokai-pro.nvim', config = function()
    require("monokai-pro").setup({
      transparent_background = true,
      terminal_colors = true,
      filter = "spectrum",
    })
    vim.cmd([[colorscheme monokai-pro]])
  end },
  { 'nvim-lualine/lualine.nvim', config = function()
    require('lualine').setup({
      options = { theme = 'monokai-pro' },
    })
  end },

  -- Fuzzy Finder
  { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-lua/plenary.nvim' },

  -- Treesitter for Syntax Highlighting
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { 'vue', 'typescript', 'javascript', 'css', 'scss', 'html' },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = { enable = true },
    })
  end },

  -- File Explorer
  { 'nvim-tree/nvim-tree.lua', config = function()
    require("nvim-tree").setup({
      sort = { sorter = "case_sensitive" },
      view = { width = 30 },
      renderer = { group_empty = true },
      filters = { dotfiles = true },
    })
  end },
  { 'nvim-tree/nvim-web-devicons' },

  -- LSP and Autocompletion
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp', config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      formatting = {
        format = lspkind.cmp_format({
          with_text = false,
          maxwidth = 50,
          ellipsis_char = '…',
        }),
      },
    })
  end },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-path' },
  { 'onsails/lspkind-nvim' },
  { 'L3MON4D3/LuaSnip' },
  { 'luckasRanarison/tailwind-tools.nvim', config = function()
    require("tailwind-tools").setup({ document_color = { kind = 'foreground' } })
  end },

  -- Mason for LSP Management
  { 'williamboman/mason.nvim', config = true },
  { 'williamboman/mason-lspconfig.nvim', config = function()
    require('mason-lspconfig').setup({
      ensure_installed = { 'vuels', 'volar', 'eslint', 'html', 'tailwindcss', 'cssls' },
    })
  end },

  -- AI Assistance
  { 'github/copilot.vim' },

  -- LSP Enhancements
  { 'nvimdev/lspsaga.nvim', config = function()
    require('lspsaga').setup({ folder_level = 2 })
  end },
  { 'windwp/nvim-autopairs', config = function()
    require("nvim-autopairs").setup()
  end },
  { 'windwp/nvim-ts-autotag', config = function()
    require("nvim-ts-autotag").setup()
  end },

  -- Lightbulb Indicator
  { 'kosayoda/nvim-lightbulb', config = function()
    require("nvim-lightbulb").setup({
      priority = 1000,
      autocmd = { enabled = true },
      sign = { text = " " },
    })
  end },
}

