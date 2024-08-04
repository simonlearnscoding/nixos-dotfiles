-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    -- 'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup {
      views = {
        cmdline_popup = {
          border = {
            style = 'none',
            padding = { 2, 3 },
          },
          -- position = {
          --   row = 30, -- This is an example; adjust as needed
          --   col = '50%',
          -- },
          filter_options = {},
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
        popupmenu = {
          relative = 'editor',
          position = {
            row = 27,
            col = '50%',
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = 'none',
            padding = { 2, 3 },
          },
          win_options = {
            winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
          },
        },
      },
    }
  end,
}
