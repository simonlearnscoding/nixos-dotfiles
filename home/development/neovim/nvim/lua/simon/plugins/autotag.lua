-- TODO: see if I have to change this
return {
  event = 'VeryLazy',
  'windwp/nvim-ts-autotag',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('nvim-ts-autotag').setup {
      enable_close_on_slash = false,
    }

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = {
        spacing = 5,
        severity = { min = vim.diagnostic.severity.WARN },
      },
      update_in_insert = true,
    })

    -- require('nvim-treesitter.configs').setup({
    --   autotag = {
    --     enable = true,
    --     enamle_rename = true,
    --     filetypes = { 'html', 'javascript', 'vue' },
    --     enable_close = true,
    --     enable_close_all = false,
    --   }
    -- })
  end,
}
