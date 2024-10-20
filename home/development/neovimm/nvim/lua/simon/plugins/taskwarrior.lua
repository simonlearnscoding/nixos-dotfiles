return {
  'huantrinh1802/m_taskwarrior_d.nvim',
  -- 'simonlearnscoding/m_taskwarrior_d.nvim',
  version = '*',
  dependencies = { 'MunifTanjim/nui.nvim' },
  config = function()
    require('m_taskwarrior_d').setup {}
    -- Optional
    vim.api.nvim_set_keymap('n', '<leader>te', '<cmd>TWEditTask<cr>', { desc = 'TaskWarrior Edit', noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tv', '<cmd>TWView<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tr', '<cmd>TWRun<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tq', '<cmd>TWSavedQueries<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tu', '<cmd>TWUpdateCurrent<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>TWSyncTasks<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>TWToggle<cr>', { silent = true })

    -- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    --   group = vim.api.nvim_create_augroup('TWTask', { clear = true }),
    --   pattern = '*.md,*.markdown', -- Pattern to match Markdown files
    --   callback = function()
    --     vim.cmd 'TWSyncTasks'
    --   end,
    -- })
  end,
}
