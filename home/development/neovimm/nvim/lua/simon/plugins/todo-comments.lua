return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = "BufRead",
  opts = {
    keywords = {
      FIX = { icon = ' ', color = 'error', priority = 1 },
      TODO = { icon = '󰄸 ', color = 'info', priority = 2 },
      NOW = { icon = '󱈸 ', color = 'warning', priority = 3 },
      LATER = { icon = '󱞷 ', color = 'hint', priority = 4 },
      REFACTOR = { icon = '󱎝 ', color = 'hint', priority = 5 },
      TEST = { icon = '󰙨 ', color = 'test', priority = 6 },
    },
    merge_keywords = true,
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
