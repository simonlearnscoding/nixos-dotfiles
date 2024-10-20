return ({
  "dnlhc/glance.nvim",
  event = 'VeryLazy',
  config = function()
    require('glance').setup({
      vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>'),
      vim.keymap.set('n', 'gt', '<CMD>Glance type_definitions<CR>'),
      vim.keymap.set('n', 'gi', '<CMD>Glance implementations<CR>'),
      vim.keymap.set('n', '<leader>gr', '<CMD>Glance references<CR>'),
      vim.keymap.set('n', '<leader>gt', '<CMD>Glance type_definitions<CR>'),
      vim.keymap.set('n', '<leader>gi', '<CMD>Glance implementations<CR>')
    })
  end,
})
