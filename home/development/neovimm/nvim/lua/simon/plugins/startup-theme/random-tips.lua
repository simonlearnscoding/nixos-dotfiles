local M = {}
M.tips = {
  { "With Yanky, pressing `p` multiple times cycles through the yank history, allowing you to paste earlier yanked items." },
  { "Press `<leader>u` to open UndoTree, a visual representation of your edits, making it easy to navigate your undo history." },
  { "To save a file in Neovim, use `:w` in normal mode." },
  { "Press `s` followed by two characters to quickly jump to any word on the screen (Leap plugin)." },
  { "Leap's `S` command lets you move backwards quickly; great for correcting recent navigation errors." },
  { "Press `Esc` to return to normal mode from insert or visual mode." },
  { "Use `:q` to quit Neovim. Add `!` to force quit without saving, like `:q!`." },
  { "To copy text, enter visual mode with `v`, select text, and press `y` to yank." },
  { "Paste text with `p` in normal mode." },
  { "Undo changes with `u` and redo with `Ctrl + r` in normal mode." },
  { "Use `:help` followed by a command or topic to get help within Neovim." },
  { "Split windows with ` | ` for horizontal and ` \\ ` for vertical splits." },
  { "Navigate between splits using `Ctrl + hjkl` " },
  { "To close a split window, focus on it and type `:q`." },
  { "Use `gg` to jump to the beginning and `G` to jump to the end of a file." },
  { "Find and replace text using `:%s/old/new` - `old` is the text to find, `new` is its replacement." },
  -- { "Comment a line by entering insert mode and adding your language's comment symbol." },
  { "Use `0` to move to the start of a line and `$` to move to the end in normal mode." },
  { "To delete a line, press `dd` in normal mode." },
  { "Open a new line below with `o` or above with `O` in normal mode." },
  { "Move through text using `h`, `j`, `k`, `l` keys for left, down, up, right respectively." },
  { "Use `:%s/old/new/gc` to find and replace with confirmation." },
  -- { "For a vertical split, use `Ctrl+w v`. For horizontal, use `Ctrl+w s`." },
  { "Use `jj` as an alternative to `Esc`." },
  { "Use `x` to delete a character under the cursor." },
  -- { "For quick file navigation, install a plugin like NERDTree or use `:Explore`." },
  { "Use `>>` to indent a line right, and `<<` to indent left in normal mode." },
  { "To copy a line, press `yy` and to paste it press `p` in normal mode." },
  { "To open a file at a specific line, use `:e filename +line_number`." },
  { "In visual mode, use `>` or `<` to indent multiple lines." },
  -- { "Use `:noh` to remove search highlighting." },
  { "To delete from the cursor to the end of the line, use `D`." },
  { "Search for a word in the file using `/word` and navigate matches with `n` (next) and `N` (previous)." },
  { "Enable line numbers with `:set number`." },
  { "To move a line up or down, use `dd` then `p` or `P`." },
  { "Use `Ctrl+o` to jump back to the previous cursor position, and `Ctrl+i` to go forward." },
  { "Use `Ctrl+v` to enter visual block mode, allowing column text selection." },
  { "In visual block mode, use `I` to insert before the block or `A` to append after." },
  -- { "Use `:set relativenumber` for relative line numbers, helpful for jumping around with `j` and `k`." },
  -- { "Use `:set hlsearch` to highlight search results." },
  { "For advanced text manipulation, learn about the `ex` commands." },
  { "Use `:set nowrap` to prevent text wrapping." },
  -- { "To open a file at the last position you edited, use `:e + filename`." },
  -- { "Learn about registers (`:help registers`) for advanced yank and put operations." },
  -- { "Use `:set ignorecase` and `:set smartcase` for case-insensitive and smart case searches." },
  -- { "Use `:set spell` for spell checking and `]s`/`[s` to navigate errors." },
  { "Understand the difference between buffers, windows, and tabs in Neovim." },
  -- { "Use `:set autoindent` for maintaining the indentation of the current line." },
  -- { "Install a plugin manager like vim-plug, Vundle, or Dein for easy plugin management." },
  -- { "Learn about Vimscript to customize Neovim to your liking." },
  { "Use `:autocmd` to automate tasks based on specific events." },
  { "Use `:set cursorline` to highlight the current line." },
  { "Use `:set cursorcolumn` to highlight the current column." },
  -- { "Use `:set background=dark` or `:set background=light` to optimize color schemes." },
  -- { "Use `gf` in normal mode to jump to a file under the cursor." },
  { "Use `:set softtabstop=4` and `:set shiftwidth=4` for tab settings." },
  { "Use `:LspInfo` to see the status of connected language servers." },
  { "Hover over a symbol and use `Shift K` to see its documentation." },
  -- Vim-Commentary
  { "Quickly comment out lines or blocks of code with vim-commentary." },
  { "Use `gcc` to comment out a line and `gc` in visual mode to comment out a selection." },

  -- { "Use `:syntax on` to enable syntax highlighting." },
  -- { "For project-wide search and replace, consider a plugin like `fzf` and `ripgrep`." },
  { "Use `zz` to center the screen on the cursor line." },
  { "Use `Ctrl+u` and `Ctrl+d` to scroll the window up and down." },
  { "Learn about 'folding' with `:help folding` for better code navigation." },
  { "Learn about 'macros' for recording and executing a sequence of commands." },
  { "Learn about Vim's 'text objects' for efficient editing." },
  { "Use `Ctrl+g` to display information about the file and cursor position." },
  { "Use `~` to toggle case, lowercase / uppercase." },
  { "Use `:set noswapfile` to disable swap files." },
  { "Press `gd` to navigate to the definition of the symbol under the cursor (LSP functionality)." },
  { "Use `gr` to list all references of the symbol under the cursor, great for understanding code usage (LSP feature)." },
  -- Existing tips here...
  { "Use `b` to move backward one word in normal mode." },
  { "Press `e` to move to the end of the current word." },
  { "Use `E` to move to the end of the current WORD (delimited by whitespace)." },
  { "Press `w` to move forward one word." },
  { "Use `W` to move forward one WORD (delimited by whitespace)." },
  { "Press `B` to move backward one WORD (delimited by whitespace)." },
  { "Press `a` to append text after the cursor." },
  { "Use `A` to append text at the end of the line." },
  { "Press `I` to insert text at the beginning of the line." },
  { "Use `q` followed by a letter to record a macro." },
  { "Press `r` followed by a character to replace the character under the cursor." },
  { "Use `R` to enter replace mode." },
  { "Press `t` followed by a character to move before the next occurrence of the character." },
  { "Use `T` followed by a character to move after the previous occurrence of the character." },
  { "Press `i` to insert text before the cursor." },
  { "Use `I` to insert text at the start of the line." },
  { "Press `o` to open a new line below the cursor." },
  { "Use `O` to open a new line above the cursor." },
  { "Press `p` to paste after the cursor." },
  { "Use `P` to paste before the cursor." },
  { "Press `s` to delete a character and enter insert mode (requires Leap plugin for advanced functionality)." },
  { "Use `f` followed by a character to jump to the next occurrence of that character on the line." },
  { "Press `F` followed by a character to jump to the previous occurrence of that character on the line." },
  { "Use a number followed by `gg` to go to that line number." },
  { "Press `;` to repeat the last `f`, `F`, `t`, or `T` command." },
  { "Use `zo` to open a fold at the cursor." },
  { "Press `zc` to close a fold at the cursor." },
  { "Use `X` to delete the character before the cursor in normal mode." },
  { "Press `c` followed by a motion to change (delete and enter insert mode) text defined by the motion." },
  { "Use `C` to change (delete to the end of the line and enter insert mode)." },
  { "Press `cc` to change (delete) the entire line and start insert mode." },
  { "Use `V` to enter visual line mode." },
  { "Press `n` after searching to move to the next occurrence." },
  { "Use `N` after searching to move to the previous occurrence." },
  { "Press `*` to search for the word under the cursor." },
  { "Use `^` to move to the first non-blank character of the line." },
  { "Press `%` to move to the matching bracket (parenthesis, brace, etc.)." },
  { "Use `@` followed by a letter to execute a recorded macro." },
  { "Press `{` to move backward to the start of the previous paragraph or block of text." },
  { "Use `}` to move forward to the start of the next paragraph or block of text." },
  { "Press `[` or `]` with various combinations to navigate through different text structures (like `[m` for start of the previous method)." },
  { "Use `ib` to select inside a word boundary (word without surrounding whitespace)." },
  { "Press `ab` to select around a word boundary (word with surrounding whitespace)." },
  { "Use `iB` to select inside a WORD boundary (WORD without surrounding whitespace, WORDs are delimited by spaces)." },
  { "Press `aB` to select around a WORD boundary (WORD with surrounding whitespace)." },
  { "Use `iw` to select inside a word (word under the cursor)." },
  { "Press `aw` to select around a word (word under the cursor and a trailing space)." },
  { "Use `is` for inside a sentence, selecting the text of the current sentence without the surrounding punctuation." },
  { "Press `as` to select around a sentence, including its trailing punctuation." },
  { "Use `ip` for inside a paragraph, selecting the text of the current paragraph without surrounding blank lines." },
  { "Press `ap` to select around a paragraph, including the surrounding blank lines." },
  { "Use `i'` to select inside single quotes." },
  { "Press `a'` to select around single quotes, including the quotes themselves." },
  { "Use `i\"` to select inside double quotes." },
  { "Press `a\"` to select around double quotes, including the quotes themselves." },
  -- More tips can be added as needed...

  -- Existing tips here...
  { "To create a custom SnipMate snippet, navigate to your snippets folder (often `~/.vim/snippets/` or a similar path)." },
  { "Snippets are filetype-specific in SnipMate, so create or edit a file named after the filetype, like `python.snippets` for Python." },
  { "A basic snippet starts with `snippet`, followed by the trigger text, then the snippet body. For example, `snippet hw` for a 'Hello, World!' snippet." },
  { "In the snippet body, use `${1:placeholder}` for placeholders you can jump to with `Tab`. For instance, `Hello, ${1:World}!`." },
  { "You can create a snippet with multiple placeholders. Use `Tab` to jump between them in the order they're defined." },


  -- Existing tips here...
  { "Open or close the NeoTree file explorer using `:Neotree` command." },
  { "In NeoTree, use `j` and `k` to navigate up and down the file list." },
  { "Press `Enter` in NeoTree to open the file or directory under the cursor." },
  { "Press `s` in NeoTree to open the file in a split window." },
  { "Use `A` in NeoTree to create a new file or directory." },
  { "Press `D` in NeoTree to delete the file or directory under the cursor." },
  { "Use `r` in NeoTree to rename the file or directory under the cursor." },
  { "In NeoTree, use `C` to copy the file or directory under the cursor." },
  { "Press `?` in NeoTree to display the help menu with all keybindings and commands." },
  { "Use `H` in NeoTree to toggle displaying of dotfiles (hidden files)." },
  -- More tips can be added as needed...



}


-- Seed the random number generator with the current time
-- math.randomseed(os.time())


-- function M.random_tip()
--   local index = math.random(#M.tips)
--   return M.tips[1]
-- end

return M