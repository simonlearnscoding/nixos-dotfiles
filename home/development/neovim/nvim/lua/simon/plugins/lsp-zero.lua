return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      -- vim.g.lsp_zero_extend_cmp = 0
      -- vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      -- { 'williamboman/mason.nvim' },
      -- { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp = require 'lsp-zero'
      lsp.extend_lspconfig()
      lsp.set_sign_icons { error = ' ', warn = ' ', hint = '', info = '' }

      -- Ensure no node modules are in the list
      local function filter(arr, fn)
        if type(arr) ~= 'table' then
          return arr
        end

        local filtered = {}
        for k, v in pairs(arr) do
          if fn(v, k, arr) then
            table.insert(filtered, v)
          end
        end

        return filtered
      end

      local function filterReactDTS(value)
        return string.match(value.filename, 'react/index.d.ts') == nil
      end

      local function on_list(options)
        local items = options.items
        if #items > 1 then
          items = filter(items, filterReactDTS)
        end

        vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
        vim.api.nvim_command 'cfirst' -- or maybe you want 'copen' instead of 'cfirst'
      end
      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set('n', 'gd', function()
          vim.lsp.buf.definition { on_list = on_list }
        end, opts)
        vim.keymap.set('n', '<leader>gi', function()
          vim.lsp.buf.incoming_calls { on_list = on_list }
        end, opts)
        vim.keymap.set('n', '<leader>go', function()
          vim.lsp.buf.incoming_calls { on_list = on_list }
        end, opts)
        vim.keymap.set('n', 'K', function()
          vim.lsp.buf.hover()
        end, opts) -- this one works pretty good
        vim.keymap.set('n', '<leader>F', function()
          vim.lsp.buf.format()
        end, { desc = 'format file' }) -- this one works pretty good

        vim.keymap.set('n', '<leader>fr', function()
          require('telescope.builtin').lsp_references()
        end, opts)

        local function goto_definition_split()
          -- Split the window horizontally and then jump to the definition
          vim.cmd 'vsplit'
          vim.lsp.buf.definition()
        end
        vim.keymap.set('n', 'gs', goto_definition_split, { silent = true })
        vim.keymap.set('n', '<leader>gs', goto_definition_split, { silent = true })
      end)

      -- require('mason').setup {
        -- ensure_installed = { 'debugpy' },
      -- } --TODO: I wasnt able to add debugpy to the ensure installed list

      -- ──────────────────────────────────────────────────────────────────────
      -- require('mason-lspconfig').setup {
      --   ensure_installed = { 'lua_ls', 'graphql', 'emmet_ls', 'texlab' }, --  'pylyzer' 'eslint' 'emmet_ls'  'tsserver'
      --   handlers = {
      --     lsp.default_setup,
      --   },
      -- }

      require('lspconfig').tsserver.setup {
        handlers = {
          ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
            if result.diagnostics == nil then
              return
            end

            -- ignore some tsserver diagnostics
            local idx = 1
            while idx <= #result.diagnostics do
              local entry = result.diagnostics[idx]

              local formatter = require('format-ts-errors')[entry.code]
              entry.message = formatter and formatter(entry.message) or entry.message

              -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
              if entry.code == 80001 then
                -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
                table.remove(result.diagnostics, idx)
              else
                idx = idx + 1
              end
            end

            vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
          end,
          root_dir = function(fname)
            return require('lspconfig').util.root_pattern 'tsconfig.json'(fname)
              or require('lspconfig').util.find_git_ancestor(fname)
              or require('lspconfig').util.path.dirname(fname)
          end,
        },

        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_dir = function(...)
          return require('lspconfig.util').root_pattern '.git'(...)
        end,
      }
      require('lspconfig').pylsp.setup {
        settings = {

          pylsp = {
            -- root_dir = function()
            -- 	root_pattern('pyproject.toml', 'requirements.txt', '.git')
            -- end,
            plugins = {

              -- formatter options
              black = { enabled = true },
              -- autopep8 = { enabled = false },
              -- yapf = { enabled = false },
              -- -- linter options
              -- -- pylint = { enabled = true, executable = "pylint" },
              pyflakes = { enabled = false },
              pycodestyle = {
                enabled = true,
                ignore = { 'E501' }, -- Option 1: Ignore E501
                maxLineLength = 120, -- Option 2: Set a longer maximum line length
              },
              -- -- type checker
              -- pylsp_mypy = { enabled = true },
              -- -- auto-completion options
              jedi_completion = { fuzzy = true },
              -- -- import sorting
              pyls_isort = { enabled = true },
            },
          },
        },
      }

      -- require('lspconfig').mypy.setup({
      -- 	filetypes = { 'python' },
      -- })
      -- require('lspconfig').tsserver.setup({
      -- 	update_insert_text = false
      -- filetypes = { 'lua', 'python' }
      -- })
      require('lspconfig').tailwindcss.setup {
        -- root_dir = {}
      }
      -- require('lspconfig').eslint.setup {
      --   -- root_dir = {}
      -- }

      -- require('lspconfig').pylyzer.setup({
      -- 	-- root_dir = function() vim.fn.getcwd() end,
      -- 	settings = {
      -- 		pylyzer = {
      -- 			single_file_mode = false
      -- 		}
      -- 	}
      -- 	filetypes = { 'python' },
      -- })
      --
      require('lspconfig').pyright.setup {
        pythonPath = '~/code/discord/habit_tracker/venv/bin/python',
      }
      require('lspconfig').texlab.setup {

        -- filetypes = {}
      }

      -- require('lspconfig').emmet_ls.setup({
      --
      -- })
    end,
  },
}
