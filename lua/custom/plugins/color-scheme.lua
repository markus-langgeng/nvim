return {
	"thesimonho/kanagawa-paper.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		undercurl = false,
		transparent = true,
		overrides = function(colors)
			local theme = colors.theme
			local palette = colors.palette
			return {
				CursorLine                 = { bg = "none" },
				NormalFloat                = { bg = "none" },
				FloatBorder                = { bg = "none" },
				FloatTitle                 = { bg = "none" },

				TelescopePromptNormal      = { bg = "none" },
				TelescopeResultsNormal     = { bg = "none" },
				TelescopePreviewNormal     = { bg = "none" },
				TelescopePromptBorder      = { bg = "none" },
				TelescopeResultsBorder     = { bg = "none" },
				TelescopePreviewBorder     = { bg = "none" },

				DiagnosticVirtualTextError = { bg = "none" },
				DiagnosticVirtualTextWarn  = { bg = "none" },
				DiagnosticVirtualTextInfo  = { bg = "none" },
				DiagnosticVirtualTextHint  = { bg = "none" },
				DiagnosticVirtualTextOk    = { bg = "none" },

				-- Dark completion (popup) menu
				Pmenu                      = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel                   = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar                  = { bg = theme.ui.bg_m1 },
				PmenuThumb                 = { bg = theme.ui.bg_p2 },

				Whitespace                 = { fg = palette.fujiGray },
			}
		end,
	},
	init = function()
		vim.cmd.colorscheme("kanagawa-paper-ink")
	end
}
