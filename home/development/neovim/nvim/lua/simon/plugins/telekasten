return {
  'renerocksai/telekasten.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  event = 'VeryLazy',
  init = function()
    require('telekasten').setup {
      home = vim.fn.expand '~/projects/pages/',
      -- uuid_sep = "-",
    }
    -- vim.keymap.set("n", "<leader>wt", "<cmd>Telekasten goto_today<cr>")
  end,
}
