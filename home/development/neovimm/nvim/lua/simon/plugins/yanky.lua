local Timeout = 1500
local highlight_on_put = false
local yank_history_keymap = '<C-p>'

----------
return {
  {
    'anuvyklack/hydra.nvim',
  },




  {
    'gbprod/yanky.nvim',
    event = 'VeryLazy',
    config = function()
      require('yanky').setup {
        preserve_cursor_position = {
          enabled = true,
        },
        highlight = {
          on_yank = true,
          on_put = highlight_on_put,
          timer = 100,
        },


      }

      vim.keymap.set("n", yank_history_keymap, ":YankyRingHistory<CR>", { desc = 'open yank register' })


      local hint = [[
      _p_ = cycle back
      _P_ = cycle forward
      ]]

      local Hydra = require('hydra')
      local dap_hydra = Hydra({
        -- hint = hint,
        config = {
          timeout = Timeout,
          on_enter = function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(YankyPutAfter)', true, false, true), 'n', true)
          end,
          invoke_on_body = true,
          hint = {
            position = 'middle-right',
            border = 'rounded'
          },
        },


        name = 'yanky',
        mode = { 'n', 'x' },
        body = 'p',
        heads = {
          { 'p', '<Plug>(YankyCycleForward)',  { silent = true } },
          { 'P', '<Plug>(YankyCycleBackward)', { silent = true } },
        }
      })
    end,
  }
}
