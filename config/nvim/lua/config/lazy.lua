-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = " ,"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Basic Options
vim.opt.tabstop = 2               -- Set tab width for display
vim.opt.shiftwidth = 2            -- Number of spaces for (auto)indent
vim.opt.expandtab = true          -- Convert tabs to spaces
vim.bo.softtabstop = 2            -- Number of spaces a Tab press inserts
vim.opt.scrolloff = 10            -- Always keep 10 lines in view
vim.opt.ignorecase = true         -- Ignore case in searches
vim.opt.smartcase = true          -- Override ignorecase if uppercase is used
vim.opt.number = true             -- Show line numbers
vim.opt.termguicolors = true      -- Enable 24-bit colour

-- Support WSL2
--vim.g.clipboard = {
--  name = "WslClipboard",
--  copy = {
--    ["+"] = "clip.exe",
--    ["*"] = "clip.exe",
--  },
--  paste = {
--    ["+"] = function()
--      return vim.fn.systemlist("powershell.exe -Command Get-Clipboard | tr -d '\r'")
--    end,
--    ["*"] = function()
--      return vim.fn.systemlist("powershell.exe -Command Get-Clipboard | tr -d '\r'")
--
--    end,
--  },
--  cache_enabled = 0,
--}

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
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

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
vim.keymap.set("n", "<leader>o", ":Neotree toggle <CR>")
