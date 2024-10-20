return {
  event = 'BufReadPre',
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      headings = { '󰋇', '󰫣', '󰌶', '󰲧', '󰲩', '󰲫' },
      highlights = {
        heading = {
          -- Used for rendering heading line backgrounds
          backgrounds = { 'DiffAdd', 'DiffChange', 'DiffDelete' },
          -- Used for rendering the foreground of the heading character only
          foregrounds = {
            'markdownH1',
            'markdownH2',
            'markdownH3',
            'markdownH4',
            'markdownH5',
            'markdownH6',
          },
        },
      },
    })
  end,
}
