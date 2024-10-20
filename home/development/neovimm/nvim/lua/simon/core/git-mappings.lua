local utils = require 'simon.utils'
local maps = { i = {}, n = {}, v = {}, t = {} }
-- GitSigns
maps.n['<leader>g'] = { desc = '󰊢 [g]it' }
-- maps.n['<leader>gs'] = {
--   desc = '󰊢 [s]tage',
-- }
maps.n[']g'] = {
  function()
    require('gitsigns').next_hunk()
  end,
  desc = 'Next Git hunk',
}


maps.n['<leader>gc'] = {
  "<cmd> Git commit<CR>",
  desc = '󰊢 [c]ommit',
}

maps.n['[g'] = {
  function()
    require('gitsigns').prev_hunk()
  end,
  desc = 'Previous Git hunk',
}
maps.n['<leader>gb'] = {
  function()
    require('gitsigns').blame_line()
  end,
  desc = '󰊢 [b]lame',
}

maps.n['<leader>gP'] = {
  "<cmd> Git push<CR>",
  desc = '󰊢 [p]ush',
}

maps.n['<leader>gv'] = {
  function()
    require('gitsigns').preview_hunk()
  end,
  desc = '󰊢 [v]iew hunk',
}
maps.n['<leader>grh'] = {
  function()
    require('gitsigns').reset_hunk()
  end,
  desc = '󰊢 [r]eset [h]unk',
}
maps.n['<leader>grb'] = {
  function()
    require('gitsigns').reset_buffer()
  end,
  desc = '󰊢 [r]eset [b]uffer',
}
maps.n['<leader>gh'] = {
  function()
    require('gitsigns').stage_hunk()
  end,
  desc = '󰊢 [h]unk stage',
}
maps.n['<leader>ga'] = {
  function()
    require('gitsigns').stage_buffer()
  end,
  desc = '󰊢 stage buffer',
}
maps.n['<leader>gu'] = {
  function()
    require('gitsigns').undo_stage_hunk()
  end,
  desc = '󰊢 [u]nstage hunk',
}
maps.n['<leader>gd'] = {
  function()
    require('gitsigns').diffthis()
  end,
  desc = '󰊢 [d]iff',
}
utils.set_mappings(maps)
