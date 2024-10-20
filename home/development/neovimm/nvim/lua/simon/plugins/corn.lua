return {
  'RaafatTurki/corn.nvim',
  event = "BufWritePost",
  config = function()
    require 'corn'.setup({
      -- TODO: replace with my icons file
      icons = {
        error = "",
        warn = "",
        hint = "",
        info = "",
      },

      item_preprocess_func = function(item)
        return item
      end,
      on_toggle = function()
        local current_config = vim.diagnostic.config()
        print("Virtual text diagnostics " .. (current_config.virtual_text and "enabled" or "disabled"))
        vim.diagnostic.config({ virtual_text = not current_config.virtual_text })
      end
    })
    vim.keymap.set("n", "<leader>dc", ":Corn scope_cycle<CR>")
    vim.keymap.set("n", "<leader>dt", ":Corn toggle<CR>")
  end
}
