local utils = require 'simon.utils'
local is_available = utils.is_available
local maps = { i = {}, n = {}, v = {}, t = {} }
--          ╭─────────────────────────────────────────────────────────╮
--          │                       REFACTORING                       │
--          ╰─────────────────────────────────────────────────────────╯
--
maps.n['<leader>r'] = { desc = ' Refactor...' }
--
maps.n['<leader>rr'] = { ':IncRename ', desc = 'smart rename' }
maps.v['<leader>re'] = { ':Refactor extract<CR>', desc = 'Refactor Extract' }
maps.v['<leader>rf'] = { ':Refactor extract_to_file<CR>', desc = 'Refactor Extract' }
maps.v['<leader>rv'] = { ':Refactor extract_variable<CR>', desc = 'Refactor Extract' }


utils.set_mappings(maps)
