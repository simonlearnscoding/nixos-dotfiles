-- "gc" to comment visual regions/lines
return {
  {
    "terrortylor/nvim-comment",
    event = "BufReadPost",

    config = function()
      require('nvim_comment').setup()
      vim.keymap.set("n", "<leader>/", ":CommentToggle<CR>")
    end

  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
      --
      lazy = false,

    }
  }
}
