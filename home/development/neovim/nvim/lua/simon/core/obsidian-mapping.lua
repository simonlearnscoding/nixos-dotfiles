local wk = require 'which-key'

local prefix = '<leader>o'

-- Register the Obsidian mappings under the <leader> prefix
-- wk.register(obsidianMappings, { prefix = '<leader>' })

local mappings = {
  o = {
    name = '󱁉 [o]bsidian..',
    o = { '<cmd>ObsidianOpen<CR>', '󱁉 [o]pen vault' },
    i = { ':e ~/projects/pages/index.md <CR>', ' [i]ndex note' },
    y = { '<cmd>ObsidianDailies<CR>', '󰃮 [d]ailies' },
    n = { '<cmd>ObsidianNew<CR>', ' [n]ew note' },
    e = { '<cmd>ObsidianExtractNote<CR>', ' [e]xtract note' },
    f = { '<cmd>ObsidianQuickSwitch<CR>', '󰍉 [f]ind' },
    T = { '<cmd>ObsidianTemplate<CR>', '󱁉 [T]emplates' },
    t = { '<cmd>ObsidianTags<CR>', '󰓹 [t]ags' },
    g = { '<cmd>ObsidianPasteImg<CR>', ' [p]aste image' },
    r = { '<cmd>ObsidianRename<CR>', '󱁉 [r]ename' },
    w = { '<cmd>ObsidianSearch<CR>', ' [w]ord', noremap = true, silent = true },
    l = { '<cmd>ObsidianLinks<CR>', '󱁉 [l]inks' },
    d = { '<cmd>ObsidianToday<CR>', '󰃮 to[d]ay' },
    m = { '<cmd>ObsidianTomorrow<CR>', '󰃮 to[m]orrow' },
  },
}
-- Function to set keymaps specifically for Markdown files
-- TODO: wrap word with brackets function.
function WrapWordWithBrackets()
  vim.cmd 'normal! viw' -- Select the current word
  vim.cmd 'ObsidianLinkNew'
  -- Move to the end of the word and insert `]]`
end

function ObsidianAction()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- Lua is 1-indexed
  -- Use a pattern to capture the word under the cursor
  -- This pattern looks for [[, any characters, and ]]
  local pattern = '%[(.-)%]'
  local word_start, word_end, captured = string.find(line, pattern, 1)

  -- Check if the cursor is within the bounds of a word that matches the pattern
  if word_start and word_end and col >= word_start and col <= word_end then
    -- The cursor is on a word that starts with [[ and ends with ]]
    -- Replace this with the actual function or command to follow the link
    print 'Following link'
    vim.cmd 'ObsidianFollowLink'
  else
    -- Not on a link, wrap the current word with [[ ]]
    -- vim.cmd('normal! viw')
    -- vim.cmd('normal! I[[')
    -- vim.cmd('normal! `>a]]')
    print 'Not a link'
    WrapWordWithBrackets()
  end
end

local function handle_markdown_enter()
  local markdownMappings = {
    ['<BS>'] = { '<cmd>ObsidianBacklinks<CR>', 'Backlinks', noremap = true, silent = true },
    -- ["<CR>"] = { "<cmd>ObsidianFollowLink<CR>", "Follow Link", noremap = true, silent = true },
    ['<CR>'] = { ':lua ObsidianAction()<CR>', 'Follow Link', noremap = true, silent = true },
    ['<leader><leader>'] = { '<cmd>ObsidianLinks<CR>', '󱁉 links', noremap = true, silent = true },
  }
  -- Register Markdown-specific mappings without a prefix, or with a specific one if needed
  wk.register(markdownMappings, { mode = 'n', buffer = vim.api.nvim_get_current_buf() })

  -- Go to next Markdown link
  vim.api.nvim_set_keymap('n', '<Tab>', '/\\[.*\\]<CR>zz', { noremap = true, silent = true })
  -- Go to previous Markdown link
  vim.api.nvim_set_keymap('n', '<S-Tab>', '?\\[.*\\]<CR>zz', { noremap = true, silent = true })
end

-- Set up an autocommand that calls set_markdown_keymaps for Markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = handle_markdown_enter,
})

wk.register(mappings, { prefix = '<leader>' })
