return {
  "lewis6991/hover.nvim",
  event = "VeryLazy",
  config = function()
    require("hover").setup {
      init = function()
        -- Require providers
        require("hover.providers.lsp")
        require('hover.providers.gh')
        require('hover.providers.gh_user')
        -- require('hover.providers.jira')
        require('hover.providers.man')
      end,

      preview_opts = {
        border = 'single'
      },
      -- Whether the contents of a currently open hover window should be moved
      -- to a :h preview-window when pressing the hover keymap.
      preview_window = false,
      title = true,
      mouse_providers = {
        'LSP'
      },
      mouse_delay = 1000
    }

    -- Setup keymaps
    vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
    vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end,
      { desc = "hover.nvim (previous source)" })
    vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end,
      { desc = "hover.nvim (next source)" })

    -- Mouse support
    vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
    vim.o.mousemoveevent = true

    local cursor_moved_timer = nil
    local delay_ms = 1500 -- Delay in milliseconds

    -- Function to trigger hover
    local function trigger_hover()
      require("hover").hover()
    end

    -- Function to handle cursor movement
    local function on_cursor_moved()
      if cursor_moved_timer then
        cursor_moved_timer:stop() -- Stop the existing timer
      end

      -- Start a new timer
      cursor_moved_timer = vim.defer_fn(function()
        trigger_hover()
      end, delay_ms)
    end

    -- Set up autocommands for cursor movement
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      callback = on_cursor_moved,
    })
  end,
}
