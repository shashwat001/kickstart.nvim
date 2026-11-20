-- vim-fugitive + vim-flog: git blame/log and the commit graph browser.
--
-- Loaded on first use; see the note in oil.lua about vim.pack and lazy loading.

local loaded = false

-- fugitive commands only work inside a git work tree
local function in_git_repo()
  local name = vim.api.nvim_buf_get_name(0)
  local start = name ~= '' and vim.fs.dirname(name) or vim.fn.getcwd()
  return vim.fs.root(start, '.git') ~= nil
end

local function load()
  if loaded then return end
  loaded = true
  vim.pack.add({
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/rbong/vim-flog',
  }, { confirm = false })
end

vim.keymap.set('n', '<leader>gb', function()
  if not in_git_repo() then
    vim.notify('Git: not inside a git repository', vim.log.levels.WARN)
    return
  end
  load()
  vim.cmd 'Git blame'
end, { desc = '[G]it [b]lame' })

vim.keymap.set('n', '<leader>gl', function()
  if not in_git_repo() then
    vim.notify('Git: not inside a git repository', vim.log.levels.WARN)
    return
  end
  load()
  vim.cmd 'Git log --oneline -20'
end, { desc = '[G]it [l]og' })

vim.keymap.set('n', '<leader>gL', function()
  if not in_git_repo() then
    vim.notify('Git: not inside a git repository', vim.log.levels.WARN)
    return
  end
  load()
  vim.cmd.Flog()
end, { desc = '[G]it [L]og graph' })
