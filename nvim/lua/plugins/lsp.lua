-- nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        opts = { -- Use opts table for mason-lspconfig directly
          -- Ensure these servers are installed automatically by Mason.
          -- Add any other LSP servers you frequently use here.
          ensure_installed = {
            "lua_ls",
            "ruff", -- Note: Ruff can be both LSP and linter/formatter
            "jdtls",
            "clangd",
            "pyright",
            "bashls",
            -- Linters/Formatters (to be used by conform/nvim-lint, see point 4):
            "prettier", -- Example formatter for web dev
            "eslint",   -- Keep eslint here if you plan to use nvim-lint
          },
          -- Removed automatic_installation = false, let it default or set to true if desired
          -- *** This is the key change: Use handlers ***

          ---@type boolean
          automatic_installation = true,

          handlers = {
            -- Default handler: Sets up servers with lspconfig and capabilities.
            function(server_name)
              require("lspconfig")[server_name].setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                -- Use a single, shared on_attach function (see point 2)
                on_attach = require("plugins.config.lsp").on_attach,
              })
            end,

            -- Add custom handlers for specific servers if needed
            -- ["lua_ls"] = function()
            --   require("lspconfig").lua_ls.setup({
            --     capabilities = require("cmp_nvim_lsp").default_capabilities(),
            --     on_attach = require("plugins.config.lsp").on_attach,
            --     settings = {
            --       Lua = {
            --         completion = { callSnippet = "Replace" },
            --         workspace = { checkThirdParty = false }, -- Example custom setting
            --         telemetry = { enable = false },
            --       },
            --     },
            --   })
            -- end,
            -- Remove jdtls from here if using nvim-jdtls plugin setup
            -- ["jdtls"] = function() ... end,
          }
        },
      },
      -- Keep mason.nvim itself
      {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
        opts = { -- Configure mason directly if needed, e.g., UI settings
          ui = { border = "rounded" }
        },
      },
      -- Keep lsp-format if you still want LSP-based formatting
      {
        'lukas-reineke/lsp-format.nvim',
        -- No need for config function if just using defaults + on_attach hook
      },
    },
    -- No need for a config function here anymore if handlers do the setup
    -- config = function() require("plugins.config.lsp") end -- Remove this line
  },
  -- Consider adding conform.nvim and nvim-lint here (see point 4)
}
