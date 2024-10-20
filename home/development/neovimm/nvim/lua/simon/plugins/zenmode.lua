return
{
  {
    'folke/zen-mode.nvim',
    event = "VeryLazy",
    opts = {
      window = {
        width = 0.8, -- width will be 85% of the editor width
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        options = {
          signcolumn = 'no',      -- disable signcolumn
          number = false,         -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false,     -- disable cursorline
          cursorcolumn = false,   -- disable cursor column
          foldcolumn = '0',       -- disable fold column
          list = false,           -- disable whitespace characters
        },
      },
    },
  },




  -- Lua
  {
    'folke/twilight.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      dimming = {
        alpha = 0.2,     -- amount of dimming
      },
      context = 12,      -- amount of lines we will try to show around the current line
      treesitter = true, -- use treesitter when available for the filetype
    },
  }

}
