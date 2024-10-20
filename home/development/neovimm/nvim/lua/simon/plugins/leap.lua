return {
  'ggandor/leap.nvim',
  event = 'VeryLazy',
  config = function()
    require('leap').add_default_mappings()
    vim.keymap.set("n", "s", "<Plug>(leap-forward)", { silent = true })
    vim.keymap.set("n", "S", "<Plug>(leap-backward)", { silent = true })
  end,
}
