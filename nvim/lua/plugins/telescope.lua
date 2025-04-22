return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
        init = function()
            --vim.keymap.set("n", "<leader>u", "<Cmd>Telescope undo<cr><esc>", { noremap = true, silent = true })
        end,
        config = function()
            require("telescope").setup({
                extensions = {
                    undo = {
                        side_by_side = true,
                        layout_config = {
                            preview_width = 0.7,
                            horizontal = { width = 0.95, height = 0.99}
                        },
                    },
                },
            })
            require("telescope").load_extension("undo")
        end,
    },
}
