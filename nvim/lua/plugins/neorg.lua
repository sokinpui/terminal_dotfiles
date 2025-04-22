return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
          ["core.integrations.nvim-cmp"] = {},
          ["core.itero"] = {},
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                task_manager = "~/Task-manage"
              },
            },
          },
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                keybinds.remap_event("norg", "n", "<localleader>nn", "core.dirman.new.note")
              end,
            }
          },
        },
      }
    end,
  },
}

