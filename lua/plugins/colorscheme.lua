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
				CursorLine                  = { bg = "none" },
				NormalFloat                 = { bg = "none" },
				FloatBorder                 = { fg = palette.oniViolet, bg = "none" },
				FloatTitle                  = { bg = "none" },
				LineNr                      = { fg = palette.oniViolet },

				TelescopePromptNormal       = { bg = "none" },
				TelescopeResultsNormal      = { bg = "none" },
				TelescopePreviewNormal      = { bg = "none" },
				-- TelescopeBorder             = { fg = "none", bg = "none" },
				-- TelescopePromptBorder       = { link = "FloatBorder" },
				-- TelescopeResultsBorder      = { link = "FloatBorder" },
				-- TelescopePreviewBorder      = { link = "FloatBorder" },

				DiagnosticVirtualTextError  = { bg = "none" },
				DiagnosticVirtualTextWarn   = { bg = "none" },
				DiagnosticVirtualTextInfo   = { bg = "none" },
				DiagnosticVirtualTextHint   = { bg = "none" },
				DiagnosticVirtualTextOk     = { bg = "none" },

				-- -- Dark completion (popup) menu
				-- Pmenu                      = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
				-- PmenuSel                   = { fg = "NONE", bg = theme.ui.bg_p2 },
				-- PmenuSbar                  = { bg = theme.ui.bg_m1 },
				-- PmenuThumb                 = { bg = theme.ui.bg_p2 },

				-- Dark completion (popup) menu
				Pmenu                       = { bg = "none" }, -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel                    = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar                   = { bg = theme.ui.bg_m1 },
				PmenuThumb                  = { bg = theme.ui.bg_p2 },
				BlinkCmpMenuBorder          = { link = "FloatBorder" },
				BlinkCmpDocBorder           = { link = "FloatBorder" },
				BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },

				Whitespace                  = { fg = palette.fujiGray },
			}
		end,
	},
	init = function()
		vim.cmd.colorscheme("kanagawa-paper-ink")
	end
}
