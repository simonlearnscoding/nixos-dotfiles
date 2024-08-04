local utils = require 'simon.utils'
local maps = { i = {}, n = {}, v = {}, t = {} }

maps.n['<leader>t'] = { desc = 'Toggle..' }
maps.n['<leader>tn'] = {"<cmd>lua require('neotest').summary.toggle()<cr>", desc = '...neotest' }


utils.set_mappings(maps)
