return {
  'nvimdev/lspsaga.nvim',
  event = "VeryLazy",
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  config = function()
    require('lspsaga').setup {
      layout = 'normal',
      ui = {
        code_action = '',
      },
      symbol_in_winbar = {
        folder_level = 0,
      },
      code_action = {
        extend_gitsigns = true,
      },
      outline = {
        keys = {
          toggle_or_jump = '<CR>',
          jump = 'e',
        },
      },
      definition = {
        keys = {
          edit = '<CR>',
          vsplit = '|',
          split = '\\',
          quit = 'q',
        },
      },
    }

    -- Set up key bindings
    vim.keymap.set('n', '<leader>h', ':Lspsaga peek_definition<CR>',
      { noremap = true, silent = true, desc = 'Preview Definition' })
    vim.keymap.set('n', '<leader>lt', ':Lspsaga goto_type_definition<CR>',
      { noremap = true, silent = true, desc = 'Preview Definition' })
    vim.keymap.set('n', '<C-e>', ':Lspsaga outline<CR>', { noremap = true, silent = true, desc = 'Preview Definition' })

    vim.keymap.set('n', '[d', ':Lspsaga diagnostic_jump_prev<CR>', { desc = 'next error message' })

    vim.keymap.set('n', ']d', ':Lspsaga diagnostic_jump_next<CR>', { desc = 'previous error message' })
  end,
}
