-- Autocompletion
-- TODO: remove snippets in markdown
local cmp_ui = require('simon.core.utils_nvchad').load_config().ui.cmp
local cmp_style = cmp_ui.style

local function border(hl_name)
  return {
    { '╭', hl_name },
    { '─', hl_name },
    { '╮', hl_name },
    { '│', hl_name },
    { '╯', hl_name },
    { '─', hl_name },
    { '╰', hl_name },
    { '│', hl_name },
  }
end
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { 'L3MON4D3/LuaSnip' },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'onsails/lspkind.nvim',
    'gbprod/yanky.nvim',

    --     -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    --     -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },
  config = function()
    -- Here is where you configure the autocompletion settings.
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load {
      paths = { '~/.config/nvim/snippets' },
    }

    require('luasnip.loaders.from_snipmate').lazy_load()
    local lsp_zero = require 'lsp-zero'
    lsp_zero.extend_cmp()

    -- And you can configure cmp even more, if you want to.
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'
    local cmp_action = lsp_zero.cmp_action()
    cmp.setup {
      sources = {
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
      },

      window = {
        completion = {
          side_padding = (cmp_style ~= 'atom' and cmp_style ~= 'atom_colored') and 1 or 0,
          scrollbar = false,
          border = border 'CmpBorder',
        },
        documentation = {
          border = border 'CmpDocBorder',
          winhighlight = 'Normal:CmpDoc',
        },
      },
      -- formatting = lsp_zero.cmp_format(),

      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },

      formatting = {
        format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
      },
      mapping = cmp.mapping.preset.insert {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-f>'] = cmp.mapping.confirm { select = true },
        -- Navigate between snippet placeholder
        ['<C-h>'] = cmp_action.luasnip_jump_backward(),
        ['<C-l>'] = cmp_action.luasnip_jump_forward(),
      },
    }
  end,
}
