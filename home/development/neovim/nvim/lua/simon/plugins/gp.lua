-- lazy.nvim
return {
  "robitx/gp.nvim",
  event = "VeryLazy",
  config = function()
    require("gp").setup({
      openai_api_key = vim.env.GPT_KEY
    })

    -- or setup with your own config (see Install > Configuration in Readme)
    -- require("gp").setup(config)

    -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
  end,
}
