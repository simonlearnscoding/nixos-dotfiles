-- TODO: how does this work? how can I set it up?
-- TODO: can I deactivate cmp in comments?
return {
  "piersolenski/wtf.nvim",

  event = "VeryLazy",
  config = function()
    require("wtf").setup({
      -- your configuration
      openai_api_key = vim.env.GPT_KEY
    })
  end

}
