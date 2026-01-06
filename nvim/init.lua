vim.loader.enable()

local user = vim.fn.expand("$USER")
local hostname = vim.fn.hostname()

-- table of user and hostname
local allow_plugins = {
	["dou"] = "MacBookAir",
	["so"] = "Mac-Studio",
}

for u, h in pairs(allow_plugins) do
	if user == u and hostname == h then
		require("setup")
	end
end
