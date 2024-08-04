return {
  "gaoDean/autolist.nvim",
  event = "BufRead",
  ft = {
    "markdown",
    "text",
    "tex",
    "plaintex",
    "norg",
  },
  config = function()
    require("autolist").setup()

    vim.keymap.set("i", "<Tab>", "<cmd>AutolistTab<cr>")
    vim.keymap.set("i", "<s-Tab>", "<cmd>AutolistShiftTab<cr>")
    vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
    vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
    vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
    vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
    vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
  end,
}
