return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = function()
    require('gitsigns').setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
    })
  end,
  config = function(_, opts)
  end,
}
