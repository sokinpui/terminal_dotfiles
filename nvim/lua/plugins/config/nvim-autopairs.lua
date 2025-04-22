local npairs = require'nvim-autopairs'
local Rule   = require'nvim-autopairs.rule'
local cond = require'nvim-autopairs.conds'

-- cmp config
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local ts_utils = require("nvim-treesitter.ts_utils")

local ts_node_func_parens_disabled = {
  -- ecma
  named_imports = true,
  -- rust
  use_declaration = true,
}

local default_handler = cmp_autopairs.filetypes["*"]["("].handler
cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
  local node_type = ts_utils.get_node_at_cursor():type()
  if ts_node_func_parens_disabled[node_type] then
    if item.data then
      item.data.funcParensDisabled = true
    else
      char = ""
    end
  end
  default_handler(char, item, bufnr, rules, commit_character)
end

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)


-- treesitter config
npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')

-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})

require('nvim-autopairs').setup({
  enable_check_bracket_line = false
})



npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp" }
npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))

-- -- Add spaces between parentheses
-- npairs.add_rules {
--     Rule('=', '', {"-zsh","-sh","-conf","-vim","-markdown"})
--     :with_pair(cond.not_inside_quote())
--     :with_pair(function(opts)
--         local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
--         if last_char:match('[%w%=%s]') then
--             return true
--         end
--         return false
--     end)
--     :replace_endpair(function(opts)
--         local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
--         local next_char = opts.line:sub(opts.col, opts.col)
--         next_char = next_char == ' ' and '' or ' '
--         if prev_2char:match('%w$') then
--             return '<bs> =' .. next_char
--         end
--         if prev_2char:match('%=$') then
--             return next_char
--         end
--         if prev_2char:match('=') then
--             return '<bs><bs>=' .. next_char
--         end
--         return ''
--     end)
--     :set_end_pair_length(0)
--     :with_move(cond.none())
--     :with_del(cond.none())
-- }

---- math block in markdown
--npairs.add_rules({
--    Rule("$", "$", "markdown")
--    :with_move(cond.done()),
--})

---- disable in escaped chararcter
--for _, char in ipairs {
--  "'",
--  '"',
--  '`',
--} do
--for _, r in ipairs(npairs.get_rule(char)) do
--  r:with_move(cond.not_before_text('\\'))
--  :with_del(function(opts)
--    local prev_col = vim.api.nvim_win_get_cursor(0)[2] - 1
--    return opts.line:sub(prev_col, prev_col) ~= '\\'
--  end)
--end
--end

-- Insertion with surrounding check
-- generalization of the first rule above
--
-- Before	Insert	After
-- (|)	*	(*|*)
-- (*|*)	space	(* | *)
-- (|)	space	( | )
function rule2(a1,ins,a2,lang)
  npairs.add_rule(
    Rule(ins, ins, lang)
      :with_pair(function(opts) return a1..a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1) end)
      :with_move(cond.none())
      :with_cr(cond.none())
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        return a1..ins..ins..a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
      end)
  )
end

rule2('(','*',')','ocaml')
rule2('(*',' ','*)','ocaml')
rule2('(',' ',')')

npairs.add_rules({
   Rule('\\'.. '\"', ''),
   Rule('\\'.. '[', ''),
   Rule('\\'.. '`', ''),
   Rule('\\'.. '\'', ''),
   Rule('\\'.. '{', ''),
   Rule('\\'.. '(', ''),
})
