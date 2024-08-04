local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'mrjones2014/smart-splits.nvim',
  -- {
  -- makes it easy to extend the functionality of a keymap (appearently??)
  -- 'anuvyklack/keymap-amend.nvim',
  -- },
  -- icons for nvim

  'nvim-tree/nvim-web-devicons',
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
  },
  -- Detect tabstop and shiftwidth automatically
  'famiu/bufdelete.nvim',
  'tpope/vim-sleuth',
  -- Useful plugin to show you pending keybinds.

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  --
  { import = 'simon.plugins' },
}
