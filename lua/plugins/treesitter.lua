return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	-- event = { "BufReadPost", "BufNewFile" },
	branch = "main",
	build = ":TSUpdate",
	init = function()
		local types = {
			"markdown", "lua", "vim", "vimdoc", "query", "markdown_inline",
			"typst", "c", "gitcommit", "git_config", "git_rebase", "gitignore",
			"bash", "bibtex", "json", "yaml",
			"html", "css", "scss", "typescript", "javascript", "sql", "dart"
		}
		require("nvim-treesitter").install(types)

		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
			pattern = types,
			callback = function() vim.treesitter.start() end,
		})
	end
	-- dependencies = {
	-- 	{ "andymass/vim-matchup", },
	-- 	{ "numToStr/Comment.nvim",                       event = "VeryLazy" },
	-- 	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
	-- 	{ "nvim-treesitter/nvim-treesitter-context",     event = "VeryLazy" }
	-- },
	-- init = function()
	-- 	vim.g.matchup_override_vimtex = 1
	-- 	vim.g.skip_ts_commentstring_module = true
	--
	-- 	require("ts_context_commentstring").setup({ enable_autocmd = false })
	-- 	require("Comment").setup({
	-- 		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	-- 	})
	-- end,
	-- opts = {
	-- 	ensure_installed = {
	-- 		"markdown", "lua", "vim", "vimdoc", "query", "markdown_inline",
	-- 		"typst", "c", "gitcommit", "git_config", "git_rebase", "gitignore",
	-- 		"bash", "bibtex", "json", "yaml",
	-- 		"html", "css", "scss", "typescript", "javascript", "sql", "dart"
	-- 	},
	-- 	sync_install = false,
	-- 	highlight = { enable = true },
	-- 	matchup = { enable = true },
	-- }
}
