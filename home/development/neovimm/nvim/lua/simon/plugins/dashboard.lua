return {
    'nvimdev/dashboard-nvim',
    config = function()
        require('dashboard').setup {
            -- config
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {

                    {
                        desc = ' [s]ession ',
                        group = 'Number',
                        action = 'SessionManager load_session',
                        key = 's',
                    },
                    {
                        icon_hl = '@variable',
                        desc = '󱑇 [f]iles',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },

                    {
                        desc = ' [b]ibtex ',
                        group = 'Number',
                        action = 'Telescope bibtex',
                        key = 'b',
                    },
                },
            },

        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
