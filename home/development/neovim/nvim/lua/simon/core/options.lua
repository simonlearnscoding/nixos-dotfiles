-- uncomment this if its not what I think it is
vim.opt.iskeyword:append '-'
vim.opt.shortmess:append { s = true, I = true } -- disable startup message

vim.opt.backspace:append { 'nostop' }           -- Don't stop backspace at insert
if vim.fn.has 'nvim-0.9' == 1 then
  vim.opt.diffopt:append 'linematch:60'         -- enable linematch diff algorithm
end
-- vim.opt.viewoptions:remove "curdir" -- disable saving current directory with views
-- local opt = vim.opt

local options = {
  opt = {
    showtabline = 2,                                        -- always display tabline
    report = 1000,
    expandtab = true,                                       -- use space instead of tabs
    swapfile = false,                                       -- disable swapfile
    foldenable = true,                                      -- enable fold for nvim-ufo
    foldlevel = 99,                                         -- set high foldlevel for nvim-ufo
    conceallevel = 2,
    foldlevelstart = 99,                                    -- start with all code unfolded
    foldcolumn = vim.fn.has 'nvim-0.9' == 1 and '1' or nil, -- show foldcolumn in nvim 0.9
    -- foldcolumn = '1',
    history = 100,                                          -- Number of commands to remember in a history table
    number = true,
    completeopt = { 'menuone', 'noselect' },                -- Options for insert mode completion
    relativenumber = true,
    wrap = false,
    ignorecase = true,
    linebreak = true,      -- Wrap lines at 'breakat'
    infercase = true,      -- case sensitive completion
    laststatus = 3,        -- globalstatus
    preserveindent = true, -- Preserve indent structure as much as possible
    pumheight = 10,        -- Height of the pop up menu
    scrolloff = 8,         -- Number of lines to keep above and below the cursor
    shiftwidth = 2,        -- Number of space inserted for indentation
    showmode = true,       -- Disable showing modes in command line
    smartcase = true,
    smartindent = true,    -- Smarter autoindentation
    tabstop = 4,           -- Number of space in a tab
    termguicolors = true,  -- Enable 24-bit RGB color in the TUI
    timeoutlen = 10,       -- Shorten key timeout length a little bit for which-key
    updatetime = 1000,     -- Length of time to wait before triggering the plugin
    virtualedit = 'block', -- allow going past end of line in visual block mode
    signcolumn = 'yes',    -- git signs on the side
    sidescrolloff = 7,     -- Number of columns to keep at the sides of the cursor
    splitright = true,
    splitbelow = true,
    hlsearch = false,
    mouse = 'a',
    clipboard = 'unnamedplus',
    breakindent = true,
    undofile = true,
    fileencoding = 'utf-8',    -- File content encoding for the buffer
    copyindent = true,         -- Copy the previous indentation on autoindenting
    fillchars = { eob = ' ' }, -- Disable `~` on nonexistent lines
    writebackup = false,       -- Disable making a backup before overwriting a file
  },
  g = {

    vimtex_main_file = 'main.tex',
    -- consider disabling this and setting a mapping instead
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    diagnostics_mode = 2,            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true,            -- disable icons in the UI (disable if no nerd font is available)
    codelens_enabled = true,         -- eature provided by some language servers that provides additional information about your code right in your editor    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    highlighturl_enabled = true,     -- highlight URLs by default
    lsp_handlers_enabled = true,     -- enable or disable default vim.lsp.handlers (hover and signatureHelp)

    conceallevel = 2,
    cmp_enabled = true,       -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    mapleader = ' ',          -- set leader key
    maplocalleader = ' ',
  },
  -- consider commenting if it will cause issues
  -- t = vim.t.bufs and vim.t.bufs or { bufs = vim.api.nvim_list_bufs() }, -- initialize buffers for the current tab
}

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
