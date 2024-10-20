return {
  "vague2k/huez.nvim",
  branch = "stable",
  event = "UIEnter",
  config = function()
    require("huez").setup({})

    vim.keymap.set('n', '<leader>co', '<cmd>Huez<CR>', {})
  end,
}
