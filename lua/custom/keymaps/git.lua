local map = vim.keymap.set

-- ==============================
-- Git Workflow Keymaps
-- ==============================

-- Commit Changes
map('n', '<leader>gc', function()
  local message = vim.fn.input 'Enter commit message: '
  if message ~= '' then
    vim.cmd('G commit -m ' .. vim.fn.shellescape(message))
  else
    print 'Commit canceled.'
  end
end, { desc = 'Git [C]ommit with message' })

map('n', '<leader>gC', function()
  vim.cmd 'G commit --amend --no-edit'
  print 'Amended last commit (without changing message).'
end, { desc = 'Git [C]ommit amend last' })

-- Staging Files
map('n', '<leader>ga', function()
  vim.cmd 'silent! G add %'
  print('File staged: ' .. vim.fn.expand '%')
end, { desc = 'Git [A]dd current file' })

map('n', '<leader>gA', function()
  vim.cmd 'silent! G add .'
  print 'All changes staged.'
end, { desc = 'Git stage [A]ll changes' })

map('n', '<leader>gu', function()
  vim.cmd 'silent! G reset %'
  print('Changes unstaged: ' .. vim.fn.expand '%')
end, { desc = 'Git [U]nstage current file' })

-- Push & Pull
map('n', '<leader>gp', function()
  local git_root = vim.fn.FugitiveWorkTree() -- Get the Git root directory
  if git_root == '' then
    print 'Not in a Git repository'
    return
  end

  vim.system({ 'git', 'push' }, { cwd = git_root, text = true }, function(obj)
    if obj.code == 0 then
      print 'Pushed changes to remote.'
    else
      print('Git push failed: ' .. obj.stderr)
    end
  end)
end, { desc = 'Git [P]ush changes to remote (async)' })

map('n', '<leader>gP', function()
  local git_root = vim.fn.FugitiveWorkTree() -- Get the Git root directory
  if git_root == '' then
    print 'Not in a Git repository'
    return
  end

  vim.system({ 'git', 'pull' }, { cwd = git_root, text = true }, function(obj)
    if obj.code == 0 then
      print 'Pulled changes from remote.'
    else
      print('Git pull failed: ' .. obj.stderr)
    end
  end)
end, { desc = 'Git [P]ull changes from remote' })

-- Git Status (Telescope)
map('n', '<leader>gs', function()
  vim.cmd 'Telescope git_status'
end, { desc = 'Git [S]tatus (Telescope)' })

-- Branch Navigation
map('n', '<leader>gb', function()
  vim.cmd 'Telescope git_branches'
end, { desc = 'Git [B]ranches' })

-- File History
map('n', '<leader>gf', function()
  vim.cmd 'Telescope git_bcommits'
end, { desc = 'Git [F]ile history' })

-- Git Log (Compact View)
map('n', '<leader>gl', function()
  vim.cmd 'Flogsplit -date=relative -auto-update -all'
end, { desc = 'Git [L]og (compact)' })

-- Merge Conflict Navigation
map('n', ']x', '/^<<<<<<<\\|=======\\|>>>>>>>\\n', { desc = 'Next merge conflict' })
map('n', '[x', '?^<<<<<<<\\|=======\\|>>>>>>>\\n', { desc = 'Previous merge conflict' })
map('n', '<leader>gm', function()
  vim.cmd 'G mergetool'
end, { desc = 'Git [M]ergetool for conflicts' })

-- Discard Changes (Prompt Before Execution)
map('n', '<leader>gd', function()
  vim.ui.input({ prompt = 'Discard changes in current file? (y/n): ' }, function(input)
    if input and input:lower() == 'y' then
      vim.cmd 'G checkout -- %'
      print('Changes discarded: ' .. vim.fn.expand '%')
    else
      print 'Discard canceled.'
    end
  end)
end, { desc = 'Git [D]iscard changes in current file' })

-- Git explorer
map('n', '<leader>ge', '<Cmd>Neotree reveal git_status<CR>', { desc = 'Open git [E]xplorer' })
