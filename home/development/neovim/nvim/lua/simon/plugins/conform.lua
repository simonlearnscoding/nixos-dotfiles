return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
  config = function()
    local conform = require 'conform'

    conform.formatters.prettierd = {
      config_file = '~/.config/.prettierrc',
    }
    -- Configuration file for prettierd
    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
      },

      --          ╭─────────────────────────────────────────────────────────╮
      --          │                Formatting on save or not                │
      --          ╰─────────────────────────────────────────────────────────╯
      format_on_save = {
        lsp_fallback = true,
        async = true,
        timeout_ms = 1000,
      },
    }
  end,
}
