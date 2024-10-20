return
{
  "chrisgrieser/nvim-scissors",
  event = "BufRead",
  dependencies = "nvim-telescope/telescope.nvim", -- optional
  opts = {
    snippetDir = "~/.config/nvim/snippets",
    keymaps = {
      -- jumpBetweenBodyAndPrefix = "<C-Space>",
    }
  },
  config = function()
    vim.keymap.set("n", "<leader>Se", function() require("scissors").editSnippet() end)
    vim.keymap.set({ "n", "x" }, "<leader>Sa", function() require("scissors").addNewSnippet() end)
  end


}
