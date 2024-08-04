local utils = require 'simon.utils'
local maps = { i = {}, n = {}, v = {}, t = {} }
local is_available = utils.is_available

--          ╭─────────────────────────────────────────────────────────╮
--          │                    FOLDING MAPPINGS                     │
--          ╰─────────────────────────────────────────────────────────╯
if is_available 'nvim-ufo' then
  vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      -- choose one of coc.nvim and nvim lsp
      vim.fn.CocActionAsync('definitionHover')   -- coc.nvim
      vim.lsp.buf.hover()
    end
  end, { noremap = true, silent = true, expr = false })

  maps.n['zR'] = {
    function()
      require('ufo').openAllFolds()
    end,
    desc = 'Open all folds',
  }
  maps.n['zM'] = {
    function()
      require('ufo').closeAllFolds()
    end,
    desc = 'Close all folds',
  }
  maps.n['zn'] = {
    function()
      require('ufo').openFoldsExceptKinds()
    end,
    desc = 'Fold less',
  }
  maps.n['zm'] = {
    function()
      require('ufo').closeFoldsWith()
    end,
    desc = 'Fold more',
  }
  maps.n['zq'] = {
    function()
      require('ufo').peekFoldedLinesUnderCursor()
    end,
    desc = 'Peek fold',
  }
end
utils.set_mappings(maps)
