local oil = require("oil")
local opts = {confirm = false}

function save_and_close()
  oil.save(opts)
  oil.close()
end

vim.keymap.set('n', 'q', save_and_close, { silent = true, noremap = true, buffer = true })


