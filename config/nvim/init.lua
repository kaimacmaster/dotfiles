local vim = vim
local Plug = vim.fn['plug#']

-- Set keybinds
vim.g.mapleader = ',';
vim.g.maplocalleader = ',';

-- System clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>p', '"+p')

-- Move lines up and down with Alt/Opt
vim.keymap.set('n', '<A-Down>', ':m+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Up>', ':m-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set('n', '<A-j>', ':m+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':m-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Force quit without saving
vim.keymap.set('n', '<leader>q', ':q!<CR>', { noremap = true, silent = true })

-- Remove quotes from keys in an object
vim.keymap.set('n', '<leader>dq', [[:%s/['"]\(\w\+\)['"]:/\1:/g<CR>]], { noremap = true, silent = true })

-- Set tab width for the visual appearance of tab characters
vim.opt.tabstop = 2

-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Set the number of spaces a Tab key press inserts
vim.bo.softtabstop = 2

-- Ensure there are always 10 lines in view
vim.opt.scrolloff = 10

-- Ignore case when searching, unless an uppercase letter is used
vim.opt.ignorecase = true
vim.opt.smartcase = true


vim.call('plug#begin')

Plug('loctvl842/monokai-pro.nvim')
Plug('itchyny/lightline.vim')
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
Plug('nvim-lua/plenary.nvim')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' }) 
Plug('edkolev/tmuxline.vim')
Plug('neovim/nvim-lspconfig')
Plug('ms-jpq/coq_nvim', { branch = 'coq' })
Plug('ms-jpq/coq.artifacts', { branch = 'artifacts' })
Plug('ms-jpq/chadtree')
Plug('nvim-lua/popup.nvim')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('github/copilot.vim')
Plug('dense-analysis/ale')
Plug('kosayoda/nvim-lightbulb')
Plug('tris203/hawtkeys.nvim')

vim.call('plug#end')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

-- Set theme
require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = false,
  filter = "spectrum",
})

vim.cmd([[colorscheme monokai-pro]])
vim.cmd([[set number]])
vim.cmd([[let g:lightline = {'colorscheme': 'monokaipro'}]])

require("telescope")
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'vuels', 'volar', 'eslint', 'html', 'tailwindcss', 'cssls' },
})

-- Setup Hawtkeys
require('hawtkeys').setup({
  default_keymap = {
    ['<leader>'] = {
      ['f'] = 'Find files',
      ['g'] = 'Live grep',
      ['o'] = 'Open file tree',
      ['lp'] = 'Fix linting errors',
      ['ac'] = 'Auto close empty tags',
      ['dq'] = 'Remove quotes from keys in an object',
    },
    ['<A-j>'] = 'Move line down',
    ['<A-k>'] = 'Move line up',
    ['<leader>q'] = 'Force quit without saving',
    ['<leader>y'] = 'Copy to system clipboard',
    ['<leader>p'] = 'Paste from system clipboard',
  }
})

vim.keymap.set('n', '<leader>,', ':HawtkeysAll<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', ':Hawtkeys<CR>', { noremap = true, silent = true })
-- Setup LSP config for Volar
local lspconfig = require('lspconfig')
local coq = require('coq')

-- Use an on_attach function to only map the following keys
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
end

lspconfig.vuels.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  filetypes = { 'vue' },
}))

lspconfig.volar.setup(coq.lsp_ensure_capabilities({
  filetypes = { 'vue' },
}))

lspconfig.ts_ls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  filetypes = { 'typescript', 'javascript','vue' },
}))

lspconfig.tailwindcss.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  filetypes = { 'vue' },
}))

lspconfig.cssls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  filetypes = { 'vue', 'css', 'scss', 'less' },
}))

lspconfig.html.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  filetypes = { 'html' },
}))

require("nvim-treesitter.configs").setup({
  ensure_installed = { 'vue', 'typescript', 'javascript', 'css', 'scss', 'html' },
  highlight = {
    enable = true,
  }
})

require("nvim-lightbulb").setup({
  priority = 1000,
  autocmd = { enabled = true },
  sign = { text = "C"}
});

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
});

--vim.cmd([[CHADopen]])
--open chattree with <leader>o
vim.keymap.set('n', '<leader>o', ':CHADopen<CR>', { noremap = true, silent = true })

-- ALE
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

vim.keymap.set('n', '<leader>lp', ':ALEFix<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>lp', ':ALEFix<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>sv', ':vnew<CR>' , { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sh', ':split<CR>' , { noremap = true, silent = true })
vim.keymap.set('n', '<leader>st', ':tabnew<CR>' , { noremap = true, silent = true })
vim.keymap.set('n', '<leader>so', ':only<CR>' , { noremap = true, silent = true })

-- Auto close empty tags ></div> or ></span> etc by replacing with /> and moving cursor inside the tag
--vim.keymap.set('n', '<leader>ac', ':%s/<\/\(\w\+\)>/<\1\/>/g<CR>:%s/<\(\w\+\)\/>/<<\1\/>><CR>:%s/<\(\w\+\)\/>><CR>')
--vim.keymap.set('n', '<leader>ac', ':%s { noremap = true, silent = true })

