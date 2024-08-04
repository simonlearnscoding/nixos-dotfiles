return {
  'tools-life/taskwiki',
  -- name = 'taskwikiwarrior',
  event = 'BufRead',
  dependencies = {
    'powerman/vim-plugin-AnsiEsc',
    -- 'taskwiki/vim-taskwiki',
    'majutsushi/tagbar',
    -- 'farsees90718/vim-taskwarrior',
  },
  -- config = function()
  --   require('taskwiki').setup {}
  -- end,
}
