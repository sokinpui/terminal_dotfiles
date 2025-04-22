return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    init = function()
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_open_to_the_world = false
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = "8888"
      vim.g.mkdp_browser = "/usr/bin/chromium-browser"
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_page_title = "${name}"
    end,
  },
  {
    "preservim/vim-markdown",
    config = function()
      vim.opt.conceallevel = 0
      vim.g.vim_markdown_folding_disabled        = 1
      vim.g.vim_markdown_no_default_key_mappings = 1
      vim.g.vim_markdown_conceal_code_blocks     = 1
      vim.g.vim_markdown_math                    = 1
      vim.g.tex_conceal = "abmgs"
      vim.g.vim_markdown_conceal = 1
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_follow_anchor = 0
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_strikethrough = 0
    end,
  },
  {
    "postfen/clipboard-image.nvim",
    ft = "markdown",
    config = function()
      require'clipboard-image'.setup {
        -- Default configuration for all filetype
        default = {
          img_dir = {"%:p:h", "img"}, -- Use table for nested dir (New feature form PR #20)
          img_name = function ()
            vim.fn.inputsave()
            local name = vim.fn.input('Name: ')
            vim.fn.inputrestore()
            return name
          end,
          affix = "<\n  %s\n>" -- Multi lines affix
        },
        -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
        -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
        -- Missing options from `markdown` field will be replaced by options from `default` field
        markdown = {
          img_dir = {"%:p:h", "img"}, -- Use table for nested dir (New feature form PR #20)
          img_name = function ()
            vim.fn.inputsave()
            local name = vim.fn.input('Name: ')
            vim.fn.inputrestore()
            return name
          end,
          img_handler = function(img)
            vim.cmd("normal! f[") -- go to [
            vim.cmd("normal! a" .. img.name) -- append text with image name
          end,
          affix = "![](%s)",
        }
      }
    end
  },
  --{
  --  "lervag/lists.vim",
  --  ft = "markdown",
  --  config = function()
  --    vim.cmd("ListsEnable")
  --  end,
  --},
  {
    "coachshea/vim-textobj-markdown",
    dependencies = {
      "kana/vim-textobj-user"
    },
    ft = "markdown",
    config = function()
      vim.g.textobj_markdown_no_default_key_mappings = 1
    end
  },

  --{
  --  "AckslD/nvim-FeMaco.lua",
  --  cmd = "FeMaco",
  --  config = function()
  --    require("femaco").setup()
  --  end
  --},

  {
    "sokinpui/open-in-obsidian.nvim",
    cmd = "Obsidian",
    config = function()
      require("obs")
    end,
  },
  {
    'jghauser/follow-md-links.nvim',
    ft = "markdown",
  }
}
