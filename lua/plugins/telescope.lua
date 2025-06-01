return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		{ "nvim-lua/plenary.nvim" }, --lazy load this when required
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
		},
		{ "nvim-telescope/telescope-frecency.nvim" },
	},
	init = function()
		local builtin = require("telescope.builtin")
		local exts = require("telescope").extensions
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { desc = "Telescope: " .. desc, noremap = true })
		end

		local config_files = function()
			return builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end

		local keymaps = {
			["<leader>sr"] = { exts.frecency.frecency, "f[R]equent / [R]ecent" },
			["<leader>sf"] = { builtin.find_files, "[F]iles" },
			["<leader>sh"] = { builtin.help_tags, "[H]elp" },
			["<leader>sm"] = { builtin.man_pages, "[M]an" },
			["<leader>sk"] = { builtin.keymaps, "[K]eymaps" },
			["<leader>sw"] = { builtin.grep_string, "grep [W]ord under cursor" },
			["<leader>sg"] = { builtin.live_grep, "[G]rep text accross files" },
			["<leader>sb"] = { builtin.builtin, "[B]uiltin" },
			["<leader>sl"] = { builtin.highlights, "[H]ighlights" },
			["<leader>so"] = { builtin.vim_options, "[O]ptions" },
			["<leader>sx"] = { builtin.marks, "[M]arks" },
			["<leader>sc"] = { config_files, "open [C]onfig directory" },
		}

		for k, v in pairs(keymaps) do
			map(k, v[1], v[2])
		end

		require("telescope").load_extension "frecency"
		require("telescope").load_extension "fzf"

	end,
	opts = function()
		local actions = require("telescope.actions")

		local ignore_files = {
			"node_modules/.*",
			"vendor/.*",
			".git/",
			"gradle/.*",
			"%.jpg",
			"%.jpeg",
			"%.png",
			"%.otf",
			"%.ttf",
			"%.pdf",
			"%.doc*",
		}

		local defaults = {
			mappings = { i = { ["<ESC>"] = actions.close } },
			dynamic_preview_title = true,
			file_ignore_patterns = ignore_files,
			border = false,
		}

		return defaults
	end
}
