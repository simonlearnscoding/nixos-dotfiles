vim.keymap.set("n", "<leader>Li", ":luafile ~/.config/nvim/init.lua<CR>",
  { noremap = true, silent = true, desc = 'source init file' })
vim.keymap.set("n", "<leader>Lc", ":luafile %<CR>", { noremap = true, silent = true, desc = 'source current file' })

return {

  'folke/which-key.nvim',
  config = function()
    local wk = require("which-key")

    wk.register({
      ["<leader>L"] = {
        name = 'source config file file'
      }
    })
  end,
}
