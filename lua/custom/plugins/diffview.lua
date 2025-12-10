-- Git diff viewer with side-by-side comparison
return {
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
      { '<leader>gd', ':DiffviewOpen<CR>', desc = '[G]it [D]iff View' },
      { '<leader>gc', ':DiffviewClose<CR>', desc = '[G]it [D]iff [C]lose' },
      { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = '[G]it [S]tatus' },
    },
  },
}