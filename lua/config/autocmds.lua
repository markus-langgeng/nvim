local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local system = vim.fn.system

local group_reload_conf = ag("ReloadConfig", { clear = true })
local group_ime = ag("IME", { clear = true })
local group_vimtex = ag("Close vimtex buffer", { clear = true })
local group_nutoggle = ag("Number toggle", { clear = true })
local vcenter_cursor = ag("VCenter Cursor", { clear = true })

au({ "TextYankPost" }, {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 50 })
	end
})

au({ "BufWritePre" }, { -- Delete trailing spaces
	pattern = "*",
	callback = function()
		local curpos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, curpos)
	end
})

-- au({ "BufReadPre" }, {
-- 	pattern = { "*.typ" },
-- 	callback = function()
-- 		local buf = 0
-- 		if vim.fn.filereadable("main.typ") == 1 then
-- 			buf = vim.fn.bufadd("main.typ")
-- 		end
-- 		vim.lsp.buf.execute_command({ command = 'tinymist.pinMain', arguments = { vim.api.nvim_buf_get_name(buf) } })
-- 	end
-- })

-- au({ "BufWritePre" }, {
-- 	pattern = { "*.typ" },
-- 	command = [[silent !typstyle -i %]]
-- })
