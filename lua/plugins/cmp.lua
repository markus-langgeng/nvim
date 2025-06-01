return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		init = function()
			local ls = require("luasnip")
			require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets/" } })

			local map = function(lhs, rhs, desc)
				vim.keymap.set({ "i", "s" }, lhs, rhs, { desc = "Luasnip: " .. desc, noremap = true, silent = true })
			end

			local jumpnext = function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end

			local jumpprev = function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end

			local choice = function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end

			local keymaps = {
				["<C-s>"] = { jumpnext, "Expand or Jump to next available snippet item" },
				["<C-h>"] = { jumpprev, "Expand or Jump to prev available snippet item" },
				["<C-l>"] = { choice, "Change choice in choice node snippet" },
			}

			for k, v in pairs(keymaps) do
				map(k, v[1], v[2])
			end
		end,
		opts = {
			exit_roots = false,
			enable_autosnippets = true,
			cut_selection_keys = "<Tab>",
			delete_check_events = "TextChanged",
			update_events = { "TextChanged", "TextChangedI" },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			-- keymap = { preset = "default" },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			completion = {
				documentation = { auto_show = true },
			},
			snippets = { preset = "luasnip" },
			sources = {
				lua = { inherit_defaults = true, 'lazydev' },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			signature = { enabled = true }
		},
	}
}
