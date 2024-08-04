return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-hop.nvim',
    -- "natecraddock/telescope-zf-native.nvim",
    'ThePrimeagen/harpoon',
    'nvim-telescope/telescope-project.nvim',
    'jvgrootveld/telescope-zoxide',
    'nvim-telescope/telescope-bibtex.nvim',
    'nvim-lua/plenary.nvim',
    {
      'ahmedkhalf/project.nvim',
      config = function(_, opts)
        require('project_nvim').setup(opts)
      end,
      opts = {
        ignore_lsp = { 'lua_ls' },
      },
    },
  },
  opts = function()
    local actions = require 'telescope.actions'
    local telescope = require 'telescope'
    telescope.load_extension 'bibtex'
    telescope.load_extension 'ui-select'
    telescope.load_extension 'zoxide'
    -- telescope.load_extension "zf-native"
    require('telescope').load_extension 'harpoon'
    local get_icon = require('simon.utils').get_icon

    local delete_buf = function()
      local current_picker = action_state.get_current_picker(prompt_bufnr)
      local multi_selections = current_picker:get_multi_selection()

      if next(multi_selections) == nil then
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_buf_delete(selection.bufnr, { force = true })
      else
        actions.close(prompt_bufnr)
        for _, selection in ipairs(multi_selections) do
          vim.api.nvim_buf_delete(selection.bufnr, { force = true })
        end
      end

      map('i', '<C-x>', delete_buf)
      return true
    end

    local mappings = {
      i = {
        ["<C-r"] = actions.open_qflist,
        ["<C-l>"] = actions.preview_scrolling_down,
        ["<C-h>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.results_scrolling_down,
        ["<C-u>"] = actions.results_scrolling_up,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-q>'] = actions.close,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-x>'] = actions.delete_buffer,
        ['|'] = actions.file_vsplit,
        ['\\'] = actions.file_split,
      },
      n = {
        ['|'] = actions.file_vsplit,
        ['<C-x>'] = actions.delete_buffer,
        ['\\'] = actions.file_split,
        ['<C-l>'] = actions.file_vsplit,
        ['q'] = actions.close,
        ['<leader>q'] = actions.close,

        ['C-x'] = delete_buf,
      },
    }

    for _, key in ipairs { '<CR>', '<C-x>', '<C-v>', '<C-t>', '<C-q>', '<M-q>' } do
      mappings.i[key] = function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>' .. key, true, false, true), 'i', false)
      end
    end
    return {
      defaults = {
        prompt_prefix = string.format('%s ', get_icon 'Search'),
        selection_caret = string.format('%s ', get_icon 'Selected'),
        path_display = { 'truncate' },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = mappings,
      },
    }
  end,
  -- require("telescope").setup({
  --   extensions = {
  --     ["zf-native"] = {
  --       -- options for sorting file-like items
  --       file = {
  --         -- override default telescope file sorter
  --         enable = true,
  --
  --         -- highlight matching text in results
  --         highlight_results = true,
  --
  --         -- enable zf filename match priority
  --         match_filename = true,
  --
  --         -- optional function to define a sort order when the query is empty
  --         initial_sort = nil,
  --
  --         -- set to false to enable case sensitive matching
  --         smart_case = true,
  --       },
  --
  --       -- options for sorting all other items
  --       generic = {
  --         -- override default telescope generic item sorter
  --         enable = true,
  --
  --         -- highlight matching text in results
  --         highlight_results = true,
  --
  --         -- disable zf filename match priority
  --         match_filename = false,
  --
  --         -- optional function to define a sort order when the query is empty
  --         initial_sort = nil,
  --
  --         -- set to false to enable case sensitive matching
  --         smart_case = true,
  --       },
  --     }
  --   },
  -- }),

  -- require("telescope").load_extension("zf-native")


}
