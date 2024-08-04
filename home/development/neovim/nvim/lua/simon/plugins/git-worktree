return {
  'polarmutex/git-worktree.nvim',
  config = function()
    require('git-worktree').setup()
    require('telescope').load_extension('git_worktree')
    vim.keymap.set("n", '<leader>fgwo', '<cmd>lua require("git-worktree").switch_worktree()<CR>',
      { desc = "git worktree" })

    vim.keymap.set("n", '<leader>fgwc', '<cmd>lua require("git-worktree").create_worktree()<CR>',
      { desc = "git worktree" })
  end

}
