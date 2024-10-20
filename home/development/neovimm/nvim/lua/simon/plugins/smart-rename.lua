return {
  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    config = function()
      require("dressing").setup {
        input = {
          override = function(conf)
            conf.col = -1
            conf.row = 0
            return conf
          end,
        },
      }
    end
  },
  {
    'smjonas/inc-rename.nvim',
    config = function()
      vim.keymap.set("n", "<leader>rn", ":IncRename ")
      vim.keymap.set("n", "<leader>lr", ":IncRename ", { desc = "Rename the current word under the cursor" })
      require('inc_rename').setup({
        input_buffer_type = "dressing",
      })
    end,
  }

}
