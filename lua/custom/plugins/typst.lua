-- return {}

return {
	"chomosuke/typst-preview.nvim",
	lazy = false, -- or ft = "typst"
	version = "1.*",
	config = function ()
		require("typst-preview").setup({
			dependencies_bin = {
				["tinymist"] = "/usr/bin/tinymist",
				["websocat"] = "/usr/bin/websocat",
			},
			-- invert_colors = [[{"rest": "always", "image": "never"}]],
		})
	end
}
