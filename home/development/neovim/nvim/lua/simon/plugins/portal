return {
  dependencies = {
    'cbochs/grapple.nvim',
    'ThePrimeagen/harpoon'
  },
  'cbochs/portal.nvim',
  config = function()
    vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
    vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
    -- vim.keymap.set("n", "<leader>p", require("portal.builtin").grapple.tunnel())
    require('portal').setup({

      escape = {
        ["q"] = true,
      },
      window_options = { height = 5 }
    })

    -- require("portal.builtin").grapple.tunnel()
  end
}
