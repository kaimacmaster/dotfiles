-- ==========================
-- Neovim Lua Configuration
-- ==========================

-- ====== General Settings ======
local vim = vim

-- Set leader keys
vim.g.mapleader = ','
vim.g.maplocalleader = ','

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
Plug('itchyny/lightline.vim')

-- Fuzzy Finder
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
Plug('nvim-lua/plenary.nvim')

-- Treesitter for Syntax Highlighting
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' }) 

-- Tmux Integration
Plug('edkolev/tmuxline.vim')

-- LSP and Autocompletion
Plug('neovim/nvim-lspconfig')
Plug('ms-jpq/coq_nvim', { branch = 'coq' })
Plug('ms-jpq/coq.artifacts', { branch = 'artifacts' })
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-path')
Plug('onsails/lspkind-nvim')
Plug('L3MON4D3/LuaSnip')

-- File Explorer
Plug('ms-jpq/chadtree')
Plug('nvim-lua/popup.nvim')

-- Mason for LSP Management
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

-- AI Assistance
Plug('github/copilot.vim')

-- LSP Enhancements
Plug('nvimdev/lspsaga.nvim')

-- Code Analysis
Plug('dense-analysis/ale')

-- Lightbulb Indicator
Plug('kosayoda/nvim-lightbulb')

vim.call('plug#end')

-- ====== Plugin Configurations ======

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
  symbol_in_winbar = {
    file_formatter = function(opts, _, _)
      -- Get the file icon and highlight group
      local file_icon, hl_group = require('lspsaga.symbolwinbar').get_file_icon()
      -- Return the formatted string with a space after the icon
      return file_icon .. ' ' .. opts.filename
    end
  },
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
-- Already have keybindings set above

-- ====== Theme ======
require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = false,
  filter = "spectrum",
})
vim.cmd([[colorscheme monokai-pro]])

-- Lightline Configuration
vim.cmd([[let g:lightline = {'colorscheme': 'monokaipro'}]])

-- ====== Mason ======
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'vuels', 'volar', 'eslint', 'html', 'tailwindcss', 'cssls' },
})

-- ====== Treesitter ======
require("nvim-treesitter.configs").setup({
  ensure_installed = { 'vue', 'typescript', 'javascript', 'css', 'scss', 'html' },
  highlight = {
    enable = true,
  }
})

-- ====== Nvim Lightbulb ======
require("nvim-lightbulb").setup({
  priority = 1000,
  autocmd = { enabled = true },
  sign = { text = " " }, -- Changed to a more visible icon
})

-- ====== CHADTree ======
vim.api.nvim_set_var('chadtree_settings', {
    options = {
        follow = true,
    },
    theme = {
        icon_glyph_set = 'devicons',
    },
    view = {
        width = 32
    },
    keymap = {
        h_split = {'h'},
        v_split = {'v'},
    }
})
-- Open CHADTree with <leader>o already set above

-- ====== ALE (Asynchronous Lint Engine) ======
vim.g.ale_enabled = 1
vim.g.ale_linters_explicit = 1
vim.g.ale_fixers = {
  vue = { 'prettier' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  css = { 'prettier' },
  scss = { 'prettier' },
  less = { 'prettier' },
  html = { 'prettier' },
}

-- ====== LSP Configuration ======
local Path = require('plenary.path')
local lspconfig = require('lspconfig')
local coq = require('coq')
-- ====== LSP Configuration ======

-- Initialize the list of LSP servers
local servers = { 'ts_ls', 'tailwindcss', 'cssls', 'html', 'vuels', 'volar' }

-- Define a helper function for consistent keybindings within LSP's on_attach
local function on_attach(client, bufnr)
  local opts = { noremap=true, silent=true }
  local keymap = vim.api.nvim_buf_set_keymap

  -- Define LSP-related keybindings
  keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

-- Setup each LSP server
for _, server in ipairs(servers) do
  -- Define filetypes consistently as arrays
  local ft = {}
  if server == 'volar' or server == 'vuels' then
    ft = { 'vue' }
  elseif server == 'tsserver' then
    ft = { 'typescript', 'javascript', 'vue' }
  elseif server == 'tailwindcss' then
    ft = { 'vue' }
  elseif server == 'cssls' then
    ft = { 'vue', 'css', 'scss', 'less' }
  elseif server == 'html' then
    ft = { 'html' }
  end

  -- Setup the LSP server with COQ and custom on_attach
  lspconfig[server].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    filetypes = ft,
  }))
end

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

-- Protected call to ensure 'cmp' is available
local status_cmp, cmp = pcall(require, 'cmp')
if not status_cmp then
  return
end

-- Protected call to ensure 'lspkind' is available
local status_lspkind, lspkind = pcall(require, 'lspkind')
if not status_lspkind then
  return
end

-- Protected call to ensure 'luasnip' is available
local status_luasnip, luasnip = pcall(require, 'luasnip')
if not status_luasnip then
  return
end

-- Load friendly snippets (optional, if you have any)
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- Use LuaSnip for snippet expansion
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4), -- Scroll docs down
    ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Scroll docs up
    ['<C-Space>'] = cmp.mapping.complete(),   -- Trigger completion
    ['<C-e>'] = cmp.mapping.close(),          -- Close completion menu
    ['<CR>'] = cmp.mapping.confirm({         -- Confirm selection
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 90 }, -- LSP completions
    { name = 'luasnip', priority = 80 },  -- Snippets
    { name = 'buffer', priority = 70 },   -- Buffer completions
    { name = 'path', priority = 100, options = { trailing_slash = true } },     -- Path completions
  }),
  formatting = {
    format = lspkind.cmp_format({ -- Use lspkind for formatting
      with_text = false,
      maxwidth = 50,
      ellipsis_char = '...',
    }),
  },
})

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

-- Open CHADTree
keymap('n', '<leader>o', ':CHADopen<CR>', opts)

-- Telescope Keybindings
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, opts)
keymap('n', '<leader>fg', builtin.live_grep, opts)

-- ALE Fix Keybindings
keymap('n', '<leader>lp', ':ALEFix<CR>', opts)
keymap('v', '<leader>lp', ':ALEFix<CR>', opts)

-- Split and Tab Management
keymap('n', '<leader>sv', ':vnew<CR>', opts)
keymap('n', '<leader>sh', ':split<CR>', opts)
keymap('n', '<leader>st', ':tabnew<CR>', opts)
keymap('n', '<leader>so', ':only<CR>', opts)

-- Lspsaga keybindings
keymap('n', 'ca', ':Lspsaga code_action<CR>', opts)
--vim.keymap.set({'n','t', '<A-d>', '<cmd>Lspsaga term_toggle'})
keymap('n', 'gt', ':Lspsaga term_toggle<CR>', opts)

-- ==========================
-- End of Configuration
-- ==========================

