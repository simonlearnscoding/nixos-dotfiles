return {
  event = "VeryLazy",
  'Weissle/persistent-breakpoints.nvim',
  config = function()
    require('persistent-breakpoints').setup {
      load_breakpoints_event = { "BufReadPost" } }
  end
}
