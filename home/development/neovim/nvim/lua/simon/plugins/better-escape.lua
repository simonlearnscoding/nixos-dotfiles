return {
  event = 'BufEnter',
  'max397574/better-escape.nvim',
  config = function()
    require('better_escape').setup {
      mapping = { 'jk', 'jj' }, -- a table with mappings to use
      timeout = 200,            -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    }
  end,
}
