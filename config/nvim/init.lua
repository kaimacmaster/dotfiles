-- Author: Kai Macmaster

-- ==========================
-- Neovim Lua Configuration
-- ==========================

-- ====== General Settings ======
local vim = vim

-- Set leader keys
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.loaded_netrw = 1 
vim.g.loaded_netrwPlugin = 1 

-- Basic Options
vim.opt.tabstop = 2               -- Set tab width for display
vim.opt.shiftwidth = 2            -- Number of spaces for (auto)indent
vim.opt.expandtab = true          -- Convert tabs to spaces
vim.bo.softtabstop = 2            -- Number of spaces a Tab press inserts
vim.opt.scrolloff = 10            -- Always keep 10 lines in view
vim.opt.ignorecase = true         -- Ignore case in searches
vim.opt.smartcase = true          -- Override ignorecase if uppercase is used
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Completion options
vim.opt.number = true             -- Show line numbers
vim.opt.termguicolors = true      -- Enable 24-bit colour 

-- Disable Esc from exiting insert mode
vim.api.nvim_set_keymap('i', '<Esc>', '<Nop>', { noremap = true, silent = true })

-- ====== Plugin Management ======

-- Initialize vim-plug
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Git and Git Signs
Plug('tpope/vim-fugitive')
Plug('lewis6991/gitsigns.nvim')

-- UI Enhancements
Plug('folke/noice.nvim')
Plug('MunifTanjim/nui.nvim')
Plug('rcarriga/nvim-notify')
Plug('tpope/vim-surround')
Plug('tpope/vim-repeat')
Plug('tpope/vim-abolish')
Plug('preservim/nerdcommenter')
Plug('loctvl842/monokai-pro.nvim')
Plug('nvim-lualine/lualine.nvim')

-- Fuzzy Finder
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
Plug('nvim-lua/plenary.nvim')

-- Treesitter for Syntax Highlighting
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' }) 

-- File Explorer
Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-tree/nvim-web-devicons')

-- LSP and Autocompletion
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-path')
Plug('onsails/lspkind-nvim')
Plug('L3MON4D3/LuaSnip')
Plug('luckasRanarison/tailwind-tools.nvim')

-- File Explorer
Plug('nvim-lua/popup.nvim')

-- Mason for LSP Management
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

-- AI Assistance
Plug('github/copilot.vim')

-- LSP Enhancements
Plug('nvimdev/lspsaga.nvim')
Plug('windwp/nvim-autopairs')
Plug('windwp/nvim-ts-autotag')

-- Lightbulb Indicator
Plug('kosayoda/nvim-lightbulb')

vim.call('plug#end')

-- ====== Keybindings ======

-- Helper function for setting keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Clipboard Operations
keymap('n', '<leader>y', '"+y', opts)
keymap('n', '<leader>p', '"+p', opts)
keymap('v', '<leader>y', '"+y', opts)
keymap('v', '<leader>p', '"+p', opts)

-- Move Lines Up and Down with Alt/Opt
local move_opts = { noremap = true, silent = true }
keymap('n', '<A-Down>', ':m+1<CR>==', move_opts)
keymap('n', '<A-Up>', ':m-2<CR>==', move_opts)
keymap('v', '<A-Down>', ":m '>+1<CR>gv=gv", move_opts)
keymap('v', '<A-Up>', ":m '<-2<CR>gv=gv", move_opts)

keymap('n', '<A-j>', ':m+1<CR>==', move_opts)
keymap('n', '<A-k>', ':m-2<CR>==', move_opts)
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", move_opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", move_opts)

-- Force Quit Without Saving
keymap('n', '<leader>q', ':q!<CR>', opts)

-- Remove Quotes from Keys in an Object
keymap('n', '<leader>dq', [[:%s/['"]\(\w\+\)['"]:/\1:/g<CR>]], opts)

-- Telescope Keybindings
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, opts)
keymap('n', '<leader>fg', builtin.live_grep, opts)
keymap('n', '<leader>fb', builtin.buffers, opts)
keymap('n', '<leader>fh', builtin.help_tags, opts)

-- Split and Tab Management
keymap('n', '<leader>sv', ':vnew<CR>', opts)
keymap('n', '<leader>sh', ':split<CR>', opts)
keymap('n', '<leader>st', ':tabnew<CR>', opts)
keymap('n', '<leader>so', ':only<CR>', opts)

-- Lspsaga keybindings
keymap('n', 'ca', ':Lspsaga code_action<CR>', opts)
keymap('n', 'gt', ':Lspsaga term_toggle<CR>', opts)

-- Cheeky save
keymap('n', '<C-s>', ':w<CR>', opts)

-- File Explorer
vim.keymap.set("n", "<leader>o", ":NvimTreeToggle path=%:p:h <CR>")

-- ====== Plugin Configurations ======

-- ====== NvimTree ======
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- ====== GitSigns ======
require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 300,
  },
})

-- ====== LSPSaga ======
require('lspsaga').setup({
  folder_level = 2,
})

-- ====== Noice ======
require("noice").setup({
  lsp = {
    -- Override markdown rendering to use Treesitter
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- Requires hrsh7th/nvim-cmp
    },
  },
  presets = {
    bottom_search = true,      -- Classic bottom cmdline for search
    command_palette = true,    -- Position cmdline and popupmenu together
    long_message_to_split = true, -- Send long messages to a split
    inc_rename = false,        -- Disable input dialog for inc-rename.nvim
    lsp_doc_border = false,    -- No border for hover docs and signature help
  },
})

-- ====== Telescope ======
require("telescope").setup({})

-- ====== Autopairs and Autotag ======
require("nvim-ts-autotag").setup()
require("nvim-autopairs").setup()

-- ====== Theme ======
require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = true,
  filter = "spectrum",
})
vim.cmd([[colorscheme monokai-pro]])

-- Lualine Configuration
require('lualine').setup({
    options = { theme = 'monokai-pro' },
})

-- ====== Mason ======
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'vuels', 'volar', 'eslint', 'html', 'tailwindcss', 'cssls' },
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Define LSP server list
local servers = { 'volar', 'ts_ls', 'vuels', 'tailwindcss' }

-- Setup each server with a loop
for _, server in ipairs(servers) do
    lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            -- Optional: Add custom LSP-related keymaps here
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        end,
    })
end

-- ====== Treesitter ======
require("nvim-treesitter.configs").setup({
  ensure_installed = { 'vue', 'typescript', 'javascript', 'css', 'scss', 'html' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
  }
})

-- ====== Nvim Lightbulb ======
require("nvim-lightbulb").setup({
  priority = 1000,
  autocmd = { enabled = true },
  sign = { text = " " }, -- Changed to a more visible icon
})

-- ====== Nvim-Notify ======
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

-- ====== nvim-cmp (Autocompletion) ======
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

-- ===== tailwind-tools =====

require("tailwind-tools").setup({
  -- your configuration
  document_color = {
    kind = 'foreground'
  }
})


-- ==========================
-- End of Configuration
-- ==========================

