local utils = require 'simon.utils'
local maps = { i = {}, n = {}, v = {}, t = {} }

maps.n[']T'] = {
  '<cmd>lua require("todo-comments").jump_next()<cr>',
  desc = 'Next todo comment',
}
maps.n['[T'] = {
  '<cmd>lua require("todo-comments").jump_prev()<cr>',
  desc = 'Previous todo comment',
}

maps.n['<leader>tb'] = {
  '<cmd>TodoTelescope keywords=FIX<cr>',
  desc = 'Todo Marked Bugs',
}

maps.n['<leader>tt'] = {
  '<cmd>TodoTelescope keywords=NOW,TODO,LATER<cr>',
  desc = 'NOW | TODO | LATER',
}

maps.n['<leader>tr'] = {
  '<cmd>TodoTelescope keywords=REFACTOR<cr>',
  desc = 'Todo Refactors',
}

utils.set_mappings(maps)
