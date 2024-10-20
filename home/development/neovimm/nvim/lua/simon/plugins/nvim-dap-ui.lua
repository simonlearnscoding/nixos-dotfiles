return {

  {

    event = 'VeryLazy',
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'folke/neodev.nvim', 'nvim-neotest/nvim-nio', 'Weissle/persistent-breakpoints.nvim' },
    config = function()
      -- set up persistent breakpoints

      vim.keymap.set('n', '<C-b>', "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>")

      local dap, dapui = require 'dap', require 'dapui'
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      require('neodev').setup { library = { plugins = { 'nvim-dap-ui' }, types = true } }
      -- vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red', linehl = '', numhl = '' })
      dap.listeners.before.event_exited['dapui_config'] =
        function()
          -- dapui.close()
        end, require('dapui').setup {
          layouts = {
            {
              elements = { {
                id = 'repl',
                size = 0.45,
              }, {
                id = 'scopes',
                size = 0.45,
              }, {
                id = 'watches',
                size = 0.1,
              } },
              position = 'bottom',
              size = 10,
            },
          },
          mappings = { expand = '<leader>' },
        }
      local Hydra = require 'hydra'
      local hint = [[
      _<M-j>_: step into   _<C-x>_: Clear Breakpoints
      _<M-l>_: step over   _<CR>_: Continue/Start
      _<M-k>_: step out
        _K_: Eval          _q_: exit
       _C-c_: to cursor      _C_: console
       _$_: stack _B_: breakpoints
       _<C-w>_: add watch     _<C-f>_: find BP
      _?_: eval expression 
      ]]

      local dap_hydra = Hydra {
        -- hint = hint,
        config = {
          on_enter = function()
            require('dapui').toggle()
          end,
          on_exit = function()
            require('dapui').toggle()
            require('dap').close()
          end,
          color = 'pink',
          -- offset = 20,
          invoke_on_body = true,
          hint = {
            position = 'top-right',
            border = 'rounded',
          },
        },

        name = 'debug',
        mode = { 'n', 'x' },
        body = '<leader>db',
        heads = {
          {
            '<M-l>',
            dap.step_over,
            { silent = true },
          },
          {
            '<M-j>',
            dap.step_into,
            { silent = true },
          },
          {
            '<M-k>',
            dap.step_out,
            { silent = true },
          },
          {
            '<C-c>',
            dap.run_to_cursor,
            { silent = true },
          },
          {
            '<C-CR>',
            dap.continue,
            { silent = true },
          },
          -- {
          --   '?',
          --   "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>",
          --   { silent = true },
          -- },
          {
            '<C-x>',
            "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",
            { silent = true },
          },
          {
            '<C-f>',
            '<cmd>Telescope dap list_breakpoints<cr>',
            { silent = true },
          },
          {
            '?',
            ":lua require('dapui').eval()<CR>",
            { silent = true },
          },

          {
            '<leader>h',
            ":lua require('dap.ui.widgets').hover()<CR>",
            { silent = true },
          },
          {
            '<C-w>',
            ":lua require('dapui').float_element('watches', { enter = true, position = 'center', width = 80, height = 20 })<CR>",
            { silent = true },
          },
          {
            '$',
            ":lua require('dapui').float_element('stacks')<CR>",
            { silent = true },
          },
          {
            'q',
            nil,
            { exit = true, nowait = true },
          },
          {
            '<leader>q',
            nil,
            { exit = true, nowait = true },
          },
          {
            '<leader>db',
            nil,
            { exit = true, nowait = true },
          },
        },
      }
    end,
  },
}
