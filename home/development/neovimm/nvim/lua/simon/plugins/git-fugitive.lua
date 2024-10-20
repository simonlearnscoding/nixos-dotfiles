return {
  "tpope/vim-fugitive",
  event = "BufRead",
  setup = function()
    vim.g.fugitive_no_maps = 1
  end,

}
