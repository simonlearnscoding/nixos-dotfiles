-- SESSION MANAGER SETUP
return {
  commit = 'b552ee8', -- Pinning to the specific commit
  'Shatur/neovim-session-manager',
  config = function()
    require('session_manager').setup {
      autoload_mode = require('session_manager.config').AutoloadMode.Disabled, --  Disabled, CurrentDir, LastSession
      vim.keymap.set({ 'n' }, '<leader>s', require('session_manager').load_session),
    }
  end
}
