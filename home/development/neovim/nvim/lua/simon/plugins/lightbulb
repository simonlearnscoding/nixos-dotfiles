return {
  'kosayoda/nvim-lightbulb',

  config = function()
    require('nvim-lightbulb').setup {
      autocmd = {
        enabled = true,
        -- events = { "CursorHold", "CursorHoldI" },
        -- pattern = { "*" },
        -- updatetime = 200, -- This sets how often (in milliseconds) Neovim checks for code actions
      },
      -- float = { enabled = true },
      -- priority = 10,
      status_text = { enabled = true, },

      sign = {
        enabled = true,
        -- Text to show in the sign column.
        -- Must be between 1-2 characters.
        -- text = "+",
        text = "💡",
        -- Highlight group to highlight the sign column text.
        hl = "LightBulbSign",
      },
    }
  end
}
