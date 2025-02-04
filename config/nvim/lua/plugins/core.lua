return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000, 
    config = function()
      require("monokai-pro").setup({
        transparent_background = true,
        terminal_colors = true,
        filter = "spectrum",
      })
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },
  -- Git and Git Signs
  { 'tpope/vim-fugitive' },
  { 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup({
      current_line_blame = true,
    }) end 
  },

  -- UI Enhancements
  { 'MunifTanjim/nui.nvim' },
  { 'nvim-lualine/lualine.nvim', config = function()
    require('lualine').setup({
      options = { theme = 'monokai-pro' },
    }) end 
  },

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
  { 'nvim-neo-tree/neo-tree.nvim', opts = {
    sources = { "filesystem", "buffers", "git_status" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<space>"] = "none",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
        ["O"] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      git_status = {
        symbols = {
          unstaged = "󰄱",
          staged = "󰱒",
        },
      },
    },
  }},
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

