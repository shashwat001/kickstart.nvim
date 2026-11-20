-- vim-fugitive + vim-flog: git blame/log and the commit graph browser.
--
-- Loaded on first use; see the note in oil.lua about vim.pack and lazy loading.

local loaded = false

local function load()
  if loaded then return end
  loaded = true
  vim.pack.add({
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/rbong/vim-flog',
  }, { confirm = false })
end

vim.keymap.set('n', '<leader>gb', function()
  load()
  vim.cmd 'Git blame'
end, { desc = '[G]it [b]lame' })

vim.keymap.set('n', '<leader>gl', function()
  load()
  vim.cmd 'Git log --oneline -20'
end, { desc = '[G]it [l]og' })

vim.keymap.set('n', '<leader>gL', function()
  load()
  vim.cmd.Flog()
end, { desc = '[G]it [L]og graph' })
