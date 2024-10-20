-- Treesitter
return {

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    version = false, -- last release is way too old and doesn't work on Windows
    -- build = ':TSUpdate',
    event = 'VeryLazy',
    init = function(plugin)
      require('lazy.core.loader').add_to_rtp(plugin)
      require 'nvim-treesitter.query_predicates'
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    keys = {
      { '<c-space>', desc = 'Increment selection' },
      { '<bs>',      desc = 'Decrement selection', mode = 'x' },
    },

    config = function()
      require('nvim-treesitter.configs').setup {

        matchup = {
          enable = true,
        },
        ensure_installed = {
          'bash',
          'diff',
          'html',
          'graphql',
          'javascript',
          'jsdoc',
          'json',
          'jsonc',
          'lua',
          'luadoc',
          'luap',
          -- 'markdown',
          'markdown_inline',
          'python',
          'query',
          'regex',
          'toml',
          'tsx',
          'typescript',
          'yaml',
        },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },

        modules = {},         -- Add modules configuration here if needed
        ignore_install = {},  -- List of parsers to ignore installing

        sync_install = false, -- Whether to install missing parsers synchronously (blocking)

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },

        textobjects = {
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
              -- You can also use captures from other query groups like `locals.scm`
              ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']f'] = '@function.outer',
                [']c'] = { query = '@class.outer', desc = 'Next class start' },
                --
                -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                [']l'] = '@loop.*',
                -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                --
                -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
                [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
              },
              goto_next_end = {
                [']F'] = '@function.outer',
                [']C'] = '@class.outer',
              },
              goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[c'] = '@class.outer',
              },
              goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[C'] = '@class.outer',
              },
              -- Below will go to either the start or the end, whichever is closer.
              -- Use if you want more granular movements
              -- Make it even more gradual by adding multiple queries and regex.
              goto_next = {
                [']i'] = '@conditional.outer',
              },
              goto_previous = {
                ['[i'] = '@conditional.outer',
              },
            },
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = true,
        },
      }
    end,
  },
}
