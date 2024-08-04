-- TODO: see if I get it now
local refactoring_keybinds = {
    {
        key = '<leader>rm',
        command = '<Cmd>lua require("refactoring").refactor("Extract Function")<CR>',
        description = 'Extract Method'
    },
    {
        key = '<leader>rv',
        command = '<Cmd>lua require("refactoring").refactor("Extract Variable")<CR>',
        description = 'Extract Variable'
    },
    {
        key = '<leader>ri',
        command = '<Cmd>lua require("refactoring").refactor("Inline Variable")<CR>',
        description = 'Inline Variable'
    },


    {
        key = '<leader>rf',
        command = '<Cmd>lua require("refactoring").refactor("Extract File")<CR>',
        description = 'Extract to File'
    },
    -- {
    --     key = '<leader>rr',
    --     command = '<Cmd>lua require("refactoring").select_refactor()<CR>',
    --     description = 'select refactor'
    -- },

}


return {
    'ThePrimeagen/refactoring.nvim',
    requires = { -- Changed 'dependencies' to 'requires' as it's the correct keyword
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    event = 'VeryLazy',
    config = function()
        require('refactoring').setup {


        }
        for _, keybind in ipairs(refactoring_keybinds) do
            vim.keymap.set({ 'n', 'v' }, keybind.key, keybind.command,
                { silent = true, noremap = true, desc = keybind.description })
        end


        require("telescope").load_extension("refactoring")

        vim.keymap.set(
            { "n", "x" },
            "<leader>rr",
            function() require('telescope').extensions.refactoring.refactors() end
        )
    end,
}
