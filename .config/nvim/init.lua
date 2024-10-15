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

vim.call('plug#end')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

-- Set theme
require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = true,
})

vim.cmd([[colorscheme monokai-pro]])
vim.cmd([[set number]])
vim.cmd([[let g:lightline = {'colorscheme': 'monokaipro'}]])

require("telescope")
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'vuels', 'volar', 'eslint', 'prettier', 'tsserver', 'html', 'css', 'json', 'scss', 'tailwindcss' },
})

-- Setup LSP config for Volar
local lspconfig = require('lspconfig')
local coq = require('coq')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({source="always"})<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --vim.keymap.set({ "v", "n" }, "<space>ca", require("actions-preview").code_actions)
  --vim.keymap.set('n', '<leader>h', function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
end

lspconfig.volar.setup(coq.lsp_ensure_capabilities({
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
}))

lspconfig.vuels.setup(coq.lsp_ensure_capabilities({
  filetypes = { 'vue' },
}))

require("nvim-treesitter.configs").setup({
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
