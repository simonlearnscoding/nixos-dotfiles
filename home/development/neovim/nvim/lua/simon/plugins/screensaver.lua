-- Packer
return ({
  "folke/drop.nvim",
  event = "VimEnter",
  config = function()
    require("drop").setup({
      filetypes = {}
    })
  end,
})
