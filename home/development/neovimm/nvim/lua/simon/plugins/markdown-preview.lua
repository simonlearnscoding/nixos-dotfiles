-- install with yarn or npm
-- TODO: Set keymaps for MarkdownPreviewToggle, MarkdownPreview, MarkdownPreviewStop

local function handle_markdown_enter()
  vim.keymap.set('n', '<leader>m', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true, desc = 'markdown preview' })
end
-- Set up an autocommand that calls set_markdown_keymaps for Markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = handle_markdown_enter,
})
return {
  event = 'VeryLazy',
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm run install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_theme = 'light'
  end,
  ft = { 'markdown' },
}
