-- diffview.nvim: side-by-side git diffs.
--
-- Loaded on first use; see the note in oil.lua about vim.pack and lazy loading.

local loaded = false

local function load()
  if loaded then return end
  loaded = true
  vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/sindrets/diffview.nvim',
  }, { confirm = false })
  require('diffview').setup {
    keymaps = {
      view = {
        {
          'n',
          '<down>',
          function()
            vim.cmd.normal { ']c', bang = true }
          end,
          { desc = 'Next diff hunk' },
        },
        {
          'n',
          '<up>',
          function()
            vim.cmd.normal { '[c', bang = true }
          end,
          { desc = 'Previous diff hunk' },
        },
      },
    },
  }
end

vim.keymap.set('n', '<leader>gd', function()
  load()
  vim.cmd.DiffviewOpen()
end, { desc = '[G]it [D]iff View' })

vim.keymap.set('n', '<leader>gc', function()
  -- Nothing to close if diffview was never loaded
  pcall(vim.cmd.DiffviewClose)
end, { desc = '[G]it [D]iff [C]lose' })

vim.keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<CR>', { desc = '[G]it [S]tatus' })
