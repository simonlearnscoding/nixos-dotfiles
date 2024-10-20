return {

  'onsails/lspkind.nvim',
  event = 'VeryLazy',
  config = function()
    local lspkind = require 'lspkind'
    local cmp = require('cmp')
    cmp.setup {
      formatting = {
        format = lspkind.cmp_format {
          maxwidth = 50,
          ellipsis_char = '...',
        },
      }
    }
  end
}
