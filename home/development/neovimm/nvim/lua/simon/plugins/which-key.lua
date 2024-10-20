return

{
  'folke/which-key.nvim',
  event = "VeryLazy",
  config = function()
    vim.o.timeoutlen = 500
    local wk = require("which-key")
    wk.register({
      ['<leader>'] =
      {
        d = {
          name = 'diagnostics'
        },

        C = {
          name = "Color Schemes", -- Group name
          g = "Gruvbox",
          k = "Kanagawa",
          r = "Rose Pine",
          c = "Catppuccin",
          m = "Miramare",
          n = "Nightfox",
          G = "Gruvbox Material",
          s = "Sonokai",
          t = "Tokyonight",
          e = "Everforest",
        },
      }
    })
  end
}
