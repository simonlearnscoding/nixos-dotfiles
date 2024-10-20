local utils = require 'simon.utils'
local is_available = utils.is_available
local ui = require 'simon.utils.ui'
local keymap = vim.keymap
local maps = { i = {}, n = {}, v = {}, t = {} }
local sections = {
  -- f = { desc = '󰍉 Find' },
  u = { desc = ' [u]I' },
  b = { desc = '󰓩 Buffers' },
  bs = { desc = '󰒺 Sort Buffers' },
  d = { desc = ' Debugger' },
  w = { desc = '󰍉  vimwiki' },
  S = { desc = '󱂬 Session' },
  t = { desc = ' Terminal' },
}

--          ╭─────────────────────────────────────────────────────────╮
--          │            Tabbing back and forth in indents            │
--          ╰─────────────────────────────────────────────────────────╯
--
vim.api.nvim_set_keymap('n', '<Tab>', '>>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Tab>', '>>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<<', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>x', ':bprevious | bdelete #<CR>',
  { noremap = true, silent = true, desc = 'Close buffer and keep window' })

vim.api.nvim_set_keymap('n', 'cw', 'ciw', { noremap = true, silent = true, desc = 'change inside word' })
vim.api.nvim_set_keymap('n', 'dw', 'diw', { noremap = true, silent = true, desc = 'change inside word' })

--          ╭─────────────────────────────────────────────────────────╮
--          │              Disable space in normal mode               │
--          ╰─────────────────────────────────────────────────────────╯
--
--
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
if not vim.g.icons_enabled then
  vim.tbl_map(function(opts)
    opts.desc = opts.desc:gsub('^.* ', '')
  end, sections)
end
--
--

--          ╭─────────────────────────────────────────────────────────╮
--          │      makes j and k more intuitive for some reason       │
--          ╰─────────────────────────────────────────────────────────╯
maps.n['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move cursor down' }
maps.n['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move cursor up' }

-- [[ WRITE AND SAVE ]]
maps.n['<leader>q'] = { '<cmd>update<cr><cmd>q<cr>', desc = 'Save and Quit if possible, else just Quit' }

-- maps.n['<leader>c'] = { '<cmd> Bdelete<cr>', desc = 'Try to save and force delete buffer' }
-- maps.n['<leader>C'] = { '<cmd>w | Bdelete<cr>', desc = 'Save and delete buffer' }
-- maps.n['<C-s>'] = { '<cmd>w!<cr>', desc = 'Force write' }

--          ╭─────────────────────────────────────────────────────────╮
--          │                       BUFFERS                       │
--          ╰─────────────────────────────────────────────────────────╯
maps.n['<leader>b'] = sections.b
maps.n['<leader>bp'] = { '<cmd>:BufferLinePick<cr>', desc = '[p]ick ' }
maps.n['<leader>bc'] = { '<cmd>:BufferLinePickClose<cr>', desc = '[c]lose' }
maps.n['<leader>bl'] = { '<cmd>:BufferLineCloseRight<cr>', desc = 'close every buffer to the right' }
maps.n['<leader>bh'] = { '<cmd>:BufferLineCloseLeft<cr>', desc = 'close every buffer to the left' }
maps.n['<leader>ba'] = { '<cmd>:BufferLineCloseOthers<cr>', desc = 'close every buffer except for the current one' }
maps.n['<S-l>'] = { '<cmd>BufferLineCycleNext<cr>', desc = 'Previous Buffer' }
maps.n['<S-h>'] = { '<cmd>BufferLineCyclePrev<cr>', desc = 'Next Buffer' }
maps.n['[b'] = { '<cmd>bprevious<cr>', desc = 'Previous Buffer' }
maps.n[']b'] = { '<cmd>bnext<cr>', desc = 'Next Buffer' }

-- Navigate tabs
maps.n['<leader>N'] = { '<cmd>tabnew<cr>', desc = '[N]ew Tab' }
maps.n[']t'] = {
  function()
    vim.cmd.tabnext()
  end,
  desc = 'Next tab',
}
maps.n['[t'] = {
  function()
    vim.cmd.tabprevious()
  end,
  desc = 'Previous tab',
}

maps.n['|'] = { '<cmd>vsplit<cr>', desc = 'Vertical Split' }
maps.n['\\'] = { '<cmd>split<cr>', desc = 'Horizontal Split' }
maps.n['<leader>M'] = { '<cmd>ZenMode<cr>', desc = 'Zen Mode' }
-- Move Lines
--
maps.n['<A-j>'] = { '<cmd>m .+1<cr>==', desc = 'Move down' }
maps.n['<A-k>'] = { '<cmd>m .-2<cr>==', desc = 'Move up' }
maps.i['<A-j>'] = { '<esc><cmd>m .+1<cr>==gi', desc = 'Move down' }
maps.i['<A-k>'] = { '<esc><cmd>m .-2<cr>==gi', desc = 'Move up' }
maps.v['<A-j>'] = { ":m '>+1<cr>gv=gv", desc = 'Move down' }
maps.v['<A-k>'] = { ":m '<-2<cr>gv=gv", desc = 'Move up' }

-- maps.i['<C-v>'] = { '<C-o>p', desc = 'Paste' }
-- maps.n['<C-c>'] = { '"+y', desc = 'Copy' }
-- maps.v['<C-x>'] = { '"+x', desc = 'Cut' }

maps.n['<leader>.'] = { '<cmd>cd %:p:h<cr>', desc = 'set cwd' }

-- [[ SNIPS ]]
-- maps.n['<leader><leader>s'] = {
--   '<cmd>source ~/.config/nvim/lua/simon/snippets<cr>',
--   desc = 'reload snippets',
-- }
utils.set_mappings(maps)
