return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
    {
      'mxsdev/nvim-dap-vscode-js',
      run = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    },
    'leoluz/nvim-dap-go',
  },
  config = function()
    require('dap-vscode-js').setup {
      debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug', -- Path to vscode-js-debug installation.
      adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node',
        'chrome' },
    }
    local js_based_languages = { 'typescript', 'javascriptreact', 'javascript', 'typescriptreact' }
    for _, language in ipairs(js_based_languages) do
      require('dap').configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch with npm run dev',
          program = '${workspaceFolder}/node_modules/.bin/npm',
          args = { 'run', 'dev' },
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Start Chrome with "localhost"',
          url = 'http://localhost:8081',
          webRoot = '${workspaceFolder}',
          userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir',
        },
      }
    end
    require('dapui').setup {}
  end,
}
