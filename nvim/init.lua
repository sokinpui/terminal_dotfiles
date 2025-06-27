vim.loader.enable()

local user = vim.fn.expand("$USER")
local hostname = vim.fn.hostname()

if user == "so" and hostname == "Mac-Studio" then
	require("setup")
end

if user == "dou" and hostname == "dous-MacBook-Air.local" then
	require("setup")
end
