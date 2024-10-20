-- I think this is the thing where the line on the side lights up
return {
  {

    'echasnovski/mini.nvim',
    version = false,

    config = function()
      require('mini.indentscope').setup({
        options = {
          symbol = '|',
        }
      })
    end,
  },
}
