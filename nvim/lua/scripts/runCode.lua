-- run code in split tmux pane depends on the file type

local function run_code()
  vim.cmd('w')
  vim.cmd('silent !tmux splitw -v -l 30')
  local filetype = vim.bo.filetype
  if filetype == 'python' then
    vim.cmd('silent !tmux send-keys -t + "python3 %:p" C-m')
  -- elseif filetype == 'go' then
  --   vim.cmd('w')
  --   vim.cmd('!tmux send-keys -t 1 "go run %:p" C-m')
  end
end

vim.keymap.set("n", '<leader>R', run_code)
