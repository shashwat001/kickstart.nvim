-- diffview.nvim: side-by-side git diffs.
--
-- Loaded on first use; see the note in oil.lua about vim.pack and lazy loading.

local loaded = false

-- diffview only works inside a git work tree; warn instead of throwing E5108
local function in_git_repo()
  local name = vim.api.nvim_buf_get_name(0)
  local start = name ~= '' and vim.fs.dirname(name) or vim.fn.getcwd()
  return vim.fs.root(start, '.git') ~= nil
end

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
  if not in_git_repo() then
    vim.notify('Diffview: not inside a git repository', vim.log.levels.WARN)
    return
  end
  load()
  vim.cmd.DiffviewOpen()
end, { desc = '[G]it [D]iff View' })

vim.keymap.set('n', '<leader>gc', function()
  -- Nothing to close if diffview was never loaded
  pcall(vim.cmd.DiffviewClose)
end, { desc = '[G]it [D]iff [C]lose' })

vim.keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<CR>', { desc = '[G]it [S]tatus' })
