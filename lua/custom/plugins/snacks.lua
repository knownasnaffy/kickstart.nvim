---@diagnostic disable: undefined-global, undefined-doc-name
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<M-`>',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle terminal',
      mode = { 'n', 't' },
    },
    {
      '<leader>gb',
      function()
        Snacks.gitbrowse()
      end,
      desc = '[B]rowse file in git remote',
    },
    {
      '<M-q>',
      function()
        if vim.fn.getreg '/' ~= '' then
          -- Clear search highlighting:
          vim.cmd 'nohlsearch'
          -- Optionally clear the search register to fully reset
          vim.fn.setreg('/', '')
        else
          Snacks.bufdelete()
        end
      end,
      desc = 'Delete current buffer',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
  },
  config = function()
    require('snacks').setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      buffdelete = { enabled = true },
      dashboard = {
        preset = {

          header = [[
   ███╗   ██╗ █████╗ ███████╗███████╗██╗   ██╗
   ████╗  ██║██╔══██╗██╔════╝██╔════╝╚██╗ ██╔╝
  ██╔██╗ ██║███████║█████╗  █████╗   ╚████╔╝
 ██║╚██╗██║██╔══██║██╔══╝  ██╔══╝    ╚██╔╝
██║ ╚████║██║  ██║██║     ██║        ██║
   ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝        ╚═╝   ]],
        },
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
        },
      },
      indent = { enabled = true },
      -- notifier = { enabled = true },
      quickfile = { enabled = true },
      -- scroll = { enabled = true },
      statuscolumn = {
        enabled = true,
      },
      -- words = { enabled = true },
      terminal = {},
    }
    vim.api.nvim_create_autocmd({ 'TermOpen', 'TermEnter' }, {
      pattern = '*',
      callback = function()
        vim.wo.winbar = ''
      end,
    })
  end,
}
