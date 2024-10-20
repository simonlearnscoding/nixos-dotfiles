return {
  event = "VeryLazy",
  'nvim-telescope/telescope-dap.nvim',
  config = function()
    require('telescope').load_extension('dap')
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope dap list_breakpoints<cr>")
  end

}
