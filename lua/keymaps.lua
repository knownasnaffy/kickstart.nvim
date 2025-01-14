-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Git keymaps
require 'custom.keymaps.git'

-- Tab management keymaps
map('n', '<M-w>w', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
map('n', '<M-w>q', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
map('n', '<M-w>l', '<cmd>tabnext<CR>', { desc = 'Go to next tab' })
map('n', '<M-w>h', '<cmd>tabprevious<CR>', { desc = 'Go to previous tab' })

-- Buffer management keymaps
require 'custom.keymaps.buffers'

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
require 'custom.keymaps.windows'
