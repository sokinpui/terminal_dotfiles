return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
            -- This setting has no relation with the `automatic_installation` setting.
            ---@type string[]
            ensure_installed = {
              "lua_ls",
              "ruff",
              "jdtls",
              "eslint",
            },

            -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
            -- This setting has no relation with the `ensure_installed` setting.
            -- Can either be:
            --   - false: Servers are not automatically installed.
            --   - true: All servers set up via lspconfig are automatically installed.
            --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
            ---@type boolean
            automatic_installation = false,

            -- See `:h mason-lspconfig.setup_handlers()`
            ---@type table<string, fun(server_name: string)>?
            handlers = nil,
          })
        end
      },
    },
    config = function()
      require("plugins.config.lsp")
    end
  },
  {
    'lukas-reineke/lsp-format.nvim',
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
      },
    },
    config = function()
      require("lsp-format").setup {}
      require("lspconfig").gopls.setup { on_attach = require("lsp-format").on_attach }
    end
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",    -- AstroNvim extension here as well
      "MasonUpdateAll", -- AstroNvim specific
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = "java",
    config = function()
      local config = {
        cmd = { '/home/so/.local/share/nvim/mason/bin/jdtls' },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      }
      require('jdtls').start_or_attach(config)
    end
  },

  -- {
  --   "saecki/live-rename.nvim",
  --   config = function()
  --     -- default config
  --     require("live-rename").setup({
  --       -- Send a `textDocument/prepareRename` request to the server to
  --       -- determine the word to be renamed, can be slow on some servers.
  --       -- Otherwise fallback to using `<cword>`.
  --       prepare_rename = true,
  --       --- The timeout for the `textDocument/prepareRename` request and final
  --       --- `textDocument/rename` request when submitting.
  --       request_timeout = 1500,
  --       -- Make an initial `textDocument/rename` request to gather other
  --       -- occurences which are edited and use these ranges to preview.
  --       -- If disabled only the word under the cursor will have a preview.
  --       show_other_ocurrences = true,
  --       -- Try to infer patterns from the initial `textDocument/rename` request
  --       -- and use these to show hopefully better edit previews.
  --       use_patterns = true,
  --       keys = {
  --         submit = {
  --           { "n", "<cr>" },
  --           { "v", "<cr>" },
  --           { "i", "<cr>" },
  --         },
  --         cancel = {
  --           { "n", "<esc>" },
  --           { "n", "q" },
  --         },
  --       },
  --       hl = {
  --         current = "CurSearch",
  --         others = "Search",
  --       },
  --     })
  --   end
  -- },
}
