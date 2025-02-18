-- Set leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Disable the leader key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- Clipboard Operations
vim.keymap.set('n', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>p', '"+p', opts)
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('v', '<leader>p', '"+p', opts)

-- move Lines Up and Down with Alt/Option
vim.keymap.set('n', '<M-j>', ':m+1<CR>==', opts)
vim.keymap.set('n', '<M-k>', ':m-2<CR>==', opts)
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", opts)

-- mac specific alt+j/k
vim.keymap.set('n', '∆', ':m+1<CR>==', opts)
vim.keymap.set('n', '˚', ':m-2<CR>==', opts)
vim.keymap.set('v', '∆', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '˚', ":m '<-2<CR>gv=gv", opts)

-- save file
vim.keymap.set('n', '<C-s>', '<cmd>noautocmd w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- force Quit Without Saving
vim.keymap.set('n', '<leader>q', ':q!<CR>', opts)

-- Remove Quotes from Keys in an Object
vim.keymap.set('n', '<leader>dq', [[:%s/['"]\(\w\+\)['"]:/\1:/g<CR>]], opts)

-- delete single character without copying into register
vim.keymap.set('n', '<leader>x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('v', '<leader>wss', function()
  -- Get the selected text
  local s_start = vim.fn.getpos "'<"
  local s_end = vim.fn.getpos "'>"

  -- Convert the selection into a range
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  local selection = table.concat(lines, '\n')

  -- Wrap with <strong> tags
  local wrapped = '<strong>' .. selection .. '</strong>'

  -- Replace selection with wrapped text
  vim.api.nvim_buf_set_text(0, s_start[2] - 1, s_start[3] - 1, s_end[2] - 1, s_end[3], { wrapped })
end, { desc = '[W]rap [S]election in <[S]trong> tags' })
