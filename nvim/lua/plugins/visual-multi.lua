return {

--   {
--     "jake-stewart/multicursor.nvim",
--     config = function()
--         local mc = require("multicursor-nvim")
--
--         mc.setup()
--
--         local set = vim.keymap.set
--
--         -- Add or skip cursor above/below the main cursor.
--         set({"n", "v"}, "<up>",
--             function() mc.lineAddCursor(-1) end)
--         set({"n", "v"}, "<down>",
--             function() mc.lineAddCursor(1) end)
--         set({"n", "v"}, "<leader><up>",
--             function() mc.lineSkipCursor(-1) end)
--         set({"n", "v"}, "<leader><down>",
--             function() mc.lineSkipCursor(1) end)
--
--         -- Add or skip adding a new cursor by matching word/selection
--         set({"n", "v"}, "<leader>n",
--             function() mc.matchAddCursor(1) end)
--         set({"n", "v"}, "<leader>s",
--             function() mc.matchSkipCursor(1) end)
--         set({"n", "v"}, "<leader>N",
--             function() mc.matchAddCursor(-1) end)
--         set({"n", "v"}, "<leader>S",
--             function() mc.matchSkipCursor(-1) end)
--
--         -- Add all matches in the document
--         set({"n", "v"}, "<leader>A", mc.matchAllAddCursors)
--
--         -- You can also add cursors with any motion you prefer:
--         -- set("n", "<right>", function()
--         --     mc.addCursor("w")
--         -- end)
--         -- set("n", "<leader><right>", function()
--         --     mc.skipCursor("w")
--         -- end)
--
--         -- Rotate the main cursor.
--         set({"n", "v"}, "<left>", mc.nextCursor)
--         set({"n", "v"}, "<right>", mc.prevCursor)
--
--         -- Delete the main cursor.
--         set({"n", "v"}, "<leader>x", mc.deleteCursor)
--
--         -- Add and remove cursors with control + left click.
--         set("n", "<c-leftmouse>", mc.handleMouse)
--
--         -- Easy way to add and remove cursors using the main cursor.
--         set({"n", "v"}, "<c-q>", mc.toggleCursor)
--
--         -- Clone every cursor and disable the originals.
--         set({"n", "v"}, "<leader><c-q>", mc.duplicateCursors)
--
--         set("n", "<esc>", function()
--             if not mc.cursorsEnabled() then
--                 mc.enableCursors()
--             elseif mc.hasCursors() then
--                 mc.clearCursors()
--             else
--                 -- Default <esc> handler.
--             end
--         end)
--
--         -- bring back cursors if you accidentally clear them
--         set("n", "<leader>gv", mc.restoreCursors)
--
--         -- Align cursor columns.
--         set("n", "<leader>a", mc.alignCursors)
--
--         -- Split visual selections by regex.
--         set("v", "S", mc.splitCursors)
--
--         -- Append/insert for each line of visual selections.
--         set("v", "I", mc.insertVisual)
--         set("v", "A", mc.appendVisual)
--
--         -- match new cursors within visual selections by regex.
--         set("v", "M", mc.matchCursors)
--
--         -- Rotate visual selection contents.
--         set("v", "<leader>t",
--             function() mc.transposeCursors(1) end)
--         set("v", "<leader>T",
--             function() mc.transposeCursors(-1) end)
--
--         -- Jumplist support
--         set({"v", "n"}, "<c-i>", mc.jumpForward)
--         set({"v", "n"}, "<c-o>", mc.jumpBackward)
--
--         -- Customize how cursors look.
--         local hl = vim.api.nvim_set_hl
--         hl(0, "MultiCursorCursor", { link = "Cursor" })
--         hl(0, "MultiCursorVisual", { link = "Visual" })
--         hl(0, "MultiCursorSign", { link = "SignColumn"})
--         hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
--         hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
--         hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
--     end
-- }

  {
    "mg979/vim-visual-multi",
    keys = {
      {"<C-n>"},
      {"<space><C-n>"},
      {"<C-n>",mode = "v"},
      {"<down>"},
      {"<up>"},
      {"u"},
      {"<C-r>"},
    },
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        ['Find Under'] = '<C-n>',
        ['Find Subword Under'] = '<C-n>',
        ['Add Cursor Up'] = '<up>',
        ['Add Cursor Down'] = '<down>',
        ["Undo"] = 'u',
        ["Redo"] = '<C-r>',
        -- ["Find Operator"] = 'm',
        -- ["Run Last Visual"] = '<space><C-n>',
        -- ["Surround"] = 'gs',
      }
      vim.g.VM_quit_after_leaving_insert_mode = 1
      vim.g.VM_highlight_matches = 'red'
      vim.g.VM_highlight_matches = 'hi! Search ctermfg=228 cterm=underline'
      vim.g.VM_custom_remaps = { s = 'c' }
    end,
  },

  -- {
  --   'kevinhwang91/nvim-hlslens',
  --   config = function ()
  --     require('hlslens').setup({
  --       override_lens = function(render, posList, nearest, idx, relIdx)
  --         local sfw = vim.v.searchforward == 1
  --         local indicator, text, chunks
  --         local absRelIdx = math.abs(relIdx)
  --         if absRelIdx > 1 then
  --           indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
  --         elseif absRelIdx == 1 then
  --           indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
  --         else
  --           indicator = ''
  --         end
  --
  --         local lnum, col = unpack(posList[idx])
  --         if nearest then
  --           local cnt = #posList
  --           if indicator ~= '' then
  --             text = ('%s'):format('', idx, cnt)
  --           else
  --             text = ('[%d/%d]'):format(idx, cnt)
  --           end
  --           chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
  --         -- else
  --         --   text = ('[%s]'):format(indicator, idx)
  --         --   chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
  --         end
  --         render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
  --       end
  --     })
  --
  --     local kopts = {noremap = true, silent = true}
  --
  --     vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR>zv<Cmd>lua require('hlslens').start()<CR>]],
  --     kopts)
  --     vim.keymap.set('n', 'N',
  --     [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR>zv<Cmd>lua require('hlslens').start()<CR>]],
  --     kopts)
  --     vim.keymap.set('n', '*', [[*zv<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --     vim.keymap.set('n', '#', [[#zv<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --     vim.keymap.set('n', 'g*', [[g*zv<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --     vim.keymap.set('n', 'g#', [[g#zv<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --
  --     -- vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
  --   end
  -- }

}
