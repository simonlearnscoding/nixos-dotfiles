local utils = require 'simon.utils'
local maps = { i = {}, n = {}, v = {}, t = {} }
-- local wk = require 'which-key'

--          ╭─────────────────────────────────────────────────────────╮
--          │                        TELESCOPE                        │
--          ╰─────────────────────────────────────────────────────────╯

local prefix = '<leader>f'

local wk = require("which-key")

local mappings = {
  f = {
    name = "󰍉 [f]ind..", -- Group name

    n = { '<cmd>Telekasten find_notes<cr>', ' [n]otes' },
    t = { '<cmd>TodoTelescope<CR>', '󰱑 [t]asks' },
    g = { desc = ' [g]it..' },
    gr = { desc = ' [r]eset..' },
    gb = { '<cmd>Telescope git_branches<CR>', ' [b]ranches' },
    gc = { '<cmd>Telescope git_commits<CR>', ' [c]ommits' },
    gs = { '<cmd>Telescope git_status<CR>', ' [s]tatus' },
    gf = { '<cmd>Telescope git_files<CR>', ' [f]iles' },
    d = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", ' [d]iagnostics' },
    l = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", ' [l]sp' },
    w = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", ' [w]ord' },
    o = { function() require('telescope.builtin').oldfiles() end, ' [o]ld files' },
    f = { function() require('telescope.builtin').find_files() end, ' [f]iles', },
    -- r = { function()
    --   a = { function()
    --     local cwd = vim.fn.expand '~' -- use the home directory as the working directory
    --     require('telescope.builtin').find_files {
    --       cwd = cwd,
    --       hidden = true,
    --       no_ignore = true,
    --     }
    --   end,
    --     ' [a]ll files',
    --   },
    --   local cwd = vim.fn.expand '~/react-components' -- use the home directory as the working directory
    --   require('telescope.builtin').find_files {
    --     cwd = cwd,
    --     hidden = true,
    --     no_ignore = true,
    --   }
    -- end,
    --   ' [r]eact',
    -- },
    z = { '<cmd>Telescope zoxide list<cr>', ' [z]oxide' },
    b = { '<cmd>Telescope bibtex<cr>', ' [b]ibliography' },
    p = {
      function()
        require('telescope').extensions.projects.projects {}
      end,
      ' [p]rojects',
    }
  }

}



vim.keymap.set("n", "<leader><Tab>", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
wk.register(mappings, { prefix = "<leader>" })
-- maps.n[prefix] = { desc = '󰍉 Find..' }

-- utils.set_mappings(maps)
