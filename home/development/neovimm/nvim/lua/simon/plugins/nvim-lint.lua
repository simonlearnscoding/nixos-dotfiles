return {
  'mfussenegger/nvim-lint',
  event = 'BufReadPre',
  -- 'BufNewFile',
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      -- python = { 'pylint' },
    }

    vim.keymap.set('n', '<leader>ll', function()
      require('lint').try_lint()
    end, { silent = true, desc = 'Lint' })
  end,
}
