return {
  "tiagovla/scope.nvim",
  config = function()
    -- init.lua
    require("scope").setup({})

    -- init.lua
    vim.opt.sessionoptions = { -- required
      "buffers",
      "tabpages",
      "globals",
    }
    require("scope").setup({})
    require("telescope").load_extension("scope")

    vim.keymap.set("n", "<leader><Tab>", "<cmd>Telescope scope buffers<CR>", { desc = 'Find buffers', })

    vim.api.nvim_set_keymap('n', '<C-S-l>', ':tabnext<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C-S-h>', ':tabprevious<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>b1', '<cmd>ScopeMoveBuf1<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>b2', '<cmd>ScopeMoveBuf2<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>b3', '<cmd>ScopeMoveBuf3<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>b4', '<cmd>ScopeMoveBuf4<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>tabn 1<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>2', '<cmd>tabn 2<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>3', '<cmd>tabn 3<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>4', '<cmd>tabn 4<CR>', { noremap = true, silent = true })

    -- local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {}) -- A global group for all your config autocommands
    -- vim.api.nvim_create_autocmd({ 'User' }, {
    --   pattern = "SessionLoadPost",
    --   group = config_group,
    --   callback = function()
    --     -- Toggle Nvim Tree
    --
    --     -- Open 4 tabs
    --     for i = 1, 3 do
    --       vim.api.nvim_command('tabnew')
    --     end
    --   end,
    -- })
  end

}
