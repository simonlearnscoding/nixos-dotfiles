return {
  "ElPiloto/telescope-vimwiki.nvim",
  event = "VeryLazy",
  config = function()
    require("telescope").load_extension "vimwiki"

    vim.keymap.set("n", "<leader>fv", "<cmd>:Telekasten find_notes<cr>", { desc = 'find vimwiki notes' })
    vim.keymap.set("n", "<leader>wF", "<cmd>:Telekasten find_friends<cr>", { desc = 'find note friends' })
    vim.keymap.set("n", "<leader>wb", "<cmd>:Telekasten show_backlinks<cr>", { desc = 'show note backlinks' })
    vim.keymap.set("n", "<leader>w<leader>W", "<cmd>:Telekasten goto_thisweek<cr>", { desc = 'open week note' })
  end,
}
