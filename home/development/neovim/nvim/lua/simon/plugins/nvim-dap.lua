local js_based_languages = {
  'typescript',
  'javascript',
  'typescriptreact',
  'javascriptreact',
  'vue',
}

return {
  event = 'VeryLazy',
  { 'nvim-neotest/nvim-nio' },
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.keymap.set('n', '<C-b>', "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>")
      local dap = require 'dap'

      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      dap.adapters.python = {
        type = 'executable',
        command = '/usr/bin/python3',
        args = { '-m', 'debugpy.adapter' },
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'launch main.py',
          program = '${workspaceFolder}/main.py',

          pythonPath = function()
            return '/usr/bin/python3'
          end,
        },

        {
          type = 'python',
          request = 'launch',
          name = 'Launch Current File',
          program = '${file}',
        },
      }
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Debug single nodejs files
          --
          {
            name = 'Next.js server',
            type = 'pwa-node',
            request = 'launch',
            cwd = '${workspaceFolder}',
            runtimeExecutable = 'npm',
            runtimeArgs = { 'run', 'dev' },
            sourceMaps = true,
          },

          {
            name = 'Next.js: debug client port 3000',
            type = 'pwa-chrome',
            request = 'launch',
            url = 'http://localhost:3000',
            webRoot = '${workspaceFolder}',
            sourceMaps = true,
            skipFiles = {
              '<node_internals>/**',
              'webpack:///external-source/**',
              '**/node_modules/**',
            },
          },
          {
            name = 'Next.js: debug client port 8081',
            type = 'pwa-chrome',
            request = 'launch',
            url = 'http://localhost:8081',
            webRoot = '${workspaceFolder}',
            sourceMaps = true,
            skipFiles = {
              '<node_internals>/**',
              'webpack:///external-source/**',
              '**/node_modules/**',
            },
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },

          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch via npm run dev',
            runtimeExecutable = 'npm',
            runtimeArgs = { 'run', 'dev' },
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            -- Ensure that the port matches the port your application runs on if needed
            port = 8081, -- Adjust this to the port your npm script uses, if applicable
            skipFiles = { '<node_internals>/**' }, -- Optional: Skip internal Node.js files while debugging
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },

          -- Debug web applications (client side)
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch & Debug Chrome',
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = 'Enter URL: ',
                  default = 'http://localhost:3000',
                }, function(url)
                  if url == nil or url == '' then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = 'inspector',
            sourceMaps = true,
            userDataDir = false,
          },
          -- Divider for the launch.json derived configs
          {
            name = '----- ↓ launch.json configs ↓ -----',
            type = '',
            request = 'launch',
          },
        }
      end
    end,
    keys = {
      {
        '<leader>dO',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>da',
        function()
          if vim.fn.filereadable '.vscode/launch.json' then
            local dap_vscode = require 'dap.ext.vscode'
            dap_vscode.load_launchjs(nil, {
              ['pwa-node'] = js_based_languages,
              ['chrome'] = js_based_languages,
              ['pwa-chrome'] = js_based_languages,
            })
          end
          require('dap').continue()
        end,
        desc = 'Run with Args',
      },
    },
    dependencies = {
      -- Install the vscode-js-debug adapter
      'Weissle/persistent-breakpoints.nvim',
      {
        'microsoft/vscode-js-debug',
        -- After install, build it and rename the dist directory to out
        build = 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out',
        version = '1.*',
      },
      {
        'mxsdev/nvim-dap-vscode-js',
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require('dap-vscode-js').setup {
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- node_path = "node",

            -- Path to vscode-js-debug installation.
            debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),

            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
            -- debugger_cmd = { "js-debug-adapter" },

            -- which adapters to register in nvim-dap
            adapters = {
              'chrome',
              'pwa-node',
              'pwa-chrome',
              'pwa-msedge',
              'pwa-extensionHost',
              'node-terminal',
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          }
        end,
      },
      {
        'Joakker/lua-json5',
        build = './install.sh',
      },
    },
  },
}
