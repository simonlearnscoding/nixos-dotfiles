return {

  event = "VeryLazy",
  'rcarriga/nvim-dap-python',
  ft = 'python',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function()
    local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3'
    require('dap-python').setup(path)
  end,
}
