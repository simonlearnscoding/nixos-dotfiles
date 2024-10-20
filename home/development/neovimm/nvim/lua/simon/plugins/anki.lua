return {
  -- "52617365/nvimanki",
  'rolf-stargate/ankifly.nvim',
  event = 'VeryLazy',
  init = function()
    vim.keymap.set('n', '<leader>A', '<cmd>Anki<cr>')
  end,
}
