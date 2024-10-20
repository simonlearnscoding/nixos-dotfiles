-- every line should be same width without escaped \
local ascii_art_module = require "simon.plugins.startup-theme.ascii-banners" -- Adjust the path as needed
local selected_art = ascii_art_module.random_ascii_art()

local random_tips = require("simon.plugins.startup-theme.random-tips") -- Adjust the path as needed
local index = math.random(#random_tips.tips)
local selected_tip = (random_tips.tips[index])


local current_dir = vim.fn.getcwd()
local function getScriptPath()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end
local function saveCurrentSessionInfo()
  local script_path = getScriptPath()                    -- Gets the path to the directory containing this script
  local session_file = script_path .. "session_info.txt" -- Construct the full path
  local session_info = { cwd = vim.fn.getcwd() }         -- Ensure this line is inside the function
  local file = io.open(session_file, "w")
  if file then
    file:write(vim.json.encode(session_info))
    file:close()
  end
end

local function readLastSessionInfo()
  local script_path = getScriptPath()
  local session_file = script_path .. "/session_info.txt"

  local file = io.open(session_file, "r")

  if file then
    local content = file:read("*all")
    file:close()
    return vim.json.decode(content)
  end
  return nil
end

local function extractLastTwoPathSegments(fullPath)
  local pattern = "([^/]+)/([^/]+)$"
  local segment1, segment2 = fullPath:match(pattern)
  if segment1 and segment2 then
    return "/" .. segment1 .. "/" .. segment2
  else
    return nil -- or some default value if the path is too short
  end
end


vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = '*',
  callback = saveCurrentSessionInfo
})
-- local last_session_info = readLastSessionInfo()
-- if last_session_info then
-- end

-- local last_session_info = readLastSessionInfo()

-- last_session_info = extractLastTwoPathSegments(last_session_info.cwd)
-- current_session_info = extractLastTwoPathSegments(current_dir)


theme = {
  header = {
    type = "text",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Header",
    margin = 5,
    content = selected_art,
    highlight = "Statement",
    default_color = "",
    oldfiles_amount = 0,
  },
  -- name which will be displayed and command
  footer = {
    type = "mapping",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Basic Commands",
    margin = 5,
    content = {

      { "[L]ast       " .. "Last Session",       ":lua require('session_manager').load_last_session() <CR>",       "l" },
      { "[C]urrent    " .. "Current Session",    ":lua require('session_manager').load_current_dir_session()<CR>", "c" },
      { "[S]essions                           ", ":lua require('session_manager').load_session()<CR>",             "s" },
      { "[P]rojects                           ", ":lua require('telescope').extensions.projects.projects() <CR>",  "p" },
      { "[O]ld Files",                           ":lua require('telescope.builtin').oldfiles()<CR>",               "o" },
      { "[N]ew File",                            "lua require'startup'.new_file()",                                "n" },
      { "[Q]uit ",                               ":q<CR>",                                                         "q" },

      -- { " Find File", "Telescope find_files", "<leader>ff" },
      -- { "󰍉 Find Word", "Telescope live_grep", "<leader>lg" },
      -- { " Recent Files", "Telescope oldfiles", "<leader>of" },
    },
    highlight = "String",
    default_color = "",
    oldfiles_amount = 4,
  },
  body = {
    type = "text",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Footer",
    margin = 5,
    content = selected_tip,
    highlight = "Number",
    default_color = "",
    oldfiles_amount = 0,
  },

  options = {
    mapping_keys = true,
    cursor_column = 0.5,
    empty_lines_between_mappings = true,
    disable_statuslines = true,
    paddings = { 1, 3, 3, 0 },
  },
  mappings = {
    execute_command = "<CR>",
    open_file = "o",
    open_file_split = "<c-o>",
    open_section = "<TAB>",
    open_help = "?",
  },
  colors = {
    background = "#1f2227",
    folded_section = "#56b6c2",
  },
  parts = { "header", "body", "footer" },
}
return theme
