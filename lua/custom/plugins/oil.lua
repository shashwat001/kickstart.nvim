-- oil.nvim: edit the filesystem like a buffer.
--
-- vim.pack has no lazy-loading specs, so the plugin is added on first use
-- instead of at startup. `confirm = false` skips the install prompt.

local loaded = false

local function load()
  if loaded then return end
  loaded = true
  vim.pack.add({ 'https://github.com/stevearc/oil.nvim' }, { confirm = false })
  require('oil').setup { view_options = { show_hidden = true } }
end

vim.keymap.set('n', '-', function()
  load()
  vim.cmd.Oil()
end, { desc = 'Open parent directory' })
