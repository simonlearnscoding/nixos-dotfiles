-- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text. It extends vim's % key to language-specific words instead of just single characters.
return {
  event = 'BufWinEnter',
  'andymass/vim-matchup',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  setup = function()
    vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  end,
}
