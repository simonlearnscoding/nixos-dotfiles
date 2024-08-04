--          ╭─────────────────────────────────────────────────────────╮
--          │                      Smart Splits                       │
--          ╰─────────────────────────────────────────────────────────╯
--

local utils = require 'simon.utils'
local maps = { i = {}, n = {}, v = {}, t = {} }

maps.n['<C-h>'] = {
  function()
    require('smart-splits').move_cursor_left()
  end,
  desc = 'Move to left split',
}
maps.n['<C-j>'] = {
  function()
    require('smart-splits').move_cursor_down()
  end,
  desc = 'Move to below split',
}
maps.n['<C-k>'] = {
  function()
    require('smart-splits').move_cursor_up()
  end,
  desc = 'Move to above split',
}
maps.n['<C-l>'] = {
  function()
    require('smart-splits').move_cursor_right()
  end,
  desc = 'Move to right split',
}
maps.n['<C-Up>'] = {
  function()
    require('smart-splits').resize_up()
  end,
  desc = 'Resize split up',
}
maps.n['<C-Down>'] = {
  function()
    require('smart-splits').resize_down()
  end,
  desc = 'Resize split down',
}
maps.n['<C-Left>'] = {
  function()
    require('smart-splits').resize_left()
  end,
  desc = 'Resize split left',
}
maps.n['<C-Right>'] = {
  function()
    require('smart-splits').resize_right()
  end,
  desc = 'Resize split right',
}

maps.n['<M-h>'] = { '<Left>', noremap = false, desc = 'Left' }
maps.n['<M-j>'] = { '<Down>', noremap = false, desc = 'Down' }
maps.n['<M-k>'] = { '<Up>', noremap = false, desc = 'Up' }
maps.n['<M-l>'] = { '<Right>', noremap = false, desc = 'Right' }


utils.set_mappings(maps)
