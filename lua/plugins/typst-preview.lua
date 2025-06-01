-- return {}

return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	config = function ()
		require("typst-preview").setup({
			debug = true,
			dependencies_bin = {
				["tinymist"] = "/usr/bin/tinymist",
				["websocat"] = "/usr/bin/websocat",
			},
			-- invert_colors = [[{"rest": "always", "image": "never"}]],
		})
	end
}
