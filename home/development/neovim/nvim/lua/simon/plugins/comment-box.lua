vim.keymap.set({ "n", "v" }, "<leader>Cb", "<Cmd>CBccbox<CR>", { desc = "Comment box" })
vim.keymap.set({ "n", "v" }, "<leader>Cl", "<Cmd>CBllline<CR>", { desc = "Comment box" })
return {
  "LudoPinelli/comment-box.nvim",
  event = "BufWritePost",
  config = function()
    require("comment-box").setup({
      comment_box_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    })
    -- local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }
  end,

  --          ╭─────────────────────────────────────────────────────────╮
  --          │                         eeeeeee                         │
  --          │                         aeeeeee                         │
  --          ╰─────────────────────────────────────────────────────────╯
  --
  -- ──────────────────────────────── eeee ─────────────────────────────
  --
  -- I am making comments lines here
}
