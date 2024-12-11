-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ====== Keybindings ======

-- Helper function for setting keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Clipboard Operations
keymap("n", "<leader>y", '"+y', opts)
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("v", "<leader>p", '"+p', opts)

-- Move Lines Up and Down with Alt/Opt
local move_opts = { noremap = true, silent = true }
keymap("n", "<A-Down>", ":m+1<CR>==", move_opts)
keymap("n", "<A-Up>", ":m-2<CR>==", move_opts)
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", move_opts)
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", move_opts)

keymap("n", "<A-j>", ":m+1<CR>==", move_opts)
keymap("n", "<A-k>", ":m-2<CR>==", move_opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", move_opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", move_opts)

-- Force Quit Without Saving
keymap("n", "<leader>q", ":q!<CR>", opts)

-- Remove Quotes from Keys in an Object
keymap("n", "<leader>dq", [[:%s/['"]\(\w\+\)['"]:/\1:/g<CR>]], opts)
