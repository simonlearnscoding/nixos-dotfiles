return {
  'folke/trouble.nvim',
  event = "VeryLazy",

  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    require("trouble").setup {
      vim.keymap.set("n", "<leader>df", "<cmd>TroubleToggle document_diagnostics<cr>"),
      vim.keymap.set("n", "<leader>dd", ':Trouble diagnostics<cr>', { desc = ' [d]iagnostic' }),
    }
  end
}
