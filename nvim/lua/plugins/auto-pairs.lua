return{
    {
        "andymass/vim-matchup",
        event = { "BufReadPre", "BufNewFile" },
        init = function()
          vim.g.loaded_matchit = 1
        end,
        config = function()
            vim.g.matchup_matchparen_offscreen = {}
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup({
                map_bs = false,
                enable_check_bracket_line = false,
                ignored_next_char = [=[[%(%"%w%%%'%[%"%.%`%$]]=],
            })
            require("plugins.config.nvim-autopairs")
        end
    },

}
