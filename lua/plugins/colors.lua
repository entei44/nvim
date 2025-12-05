local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return { 
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
	    vim.cmd.colorscheme "catppuccin-mocha"
	end
}
