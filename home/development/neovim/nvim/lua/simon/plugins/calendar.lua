-- TODO: I NEED to remove this one from git
return {
  "itchyny/calendar.vim",
  event = "VeryLazy",
  init = function()
    vim.g.calendar_google_calendar = 1
    vim.g.calendar_google_task = 1
    vim.g.calendar_google_api_key = vim.env.GCAL_API_KEY
    vim.g.calendar_google_client_id = vim.env.GCAL_CLIENT_ID
    vim.g.calendar_google_client_secret = vim.env.GCAL_CLIENT_SECRET
    vim.keymap.set("n", "<leader>cw", "<cmd>Calendar -view=week -split=vertical -width=60<cr>")
    vim.keymap.set("n", "<leader>cd", "<cmd>Calendar -view=day -split=vertical -width=60<cr>")
    vim.keymap.set("n", "<leader>cm", "<cmd>Calendar -view=month -split=vertical -width=60<cr>")
  end,
}
