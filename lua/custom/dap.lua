local dap = require("dap")
local dapui = require("dapui")
require("nvim-dap-virtual-text").setup()

dapui.setup()

dap.set_log_level("DEBUG")
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-dap",
	name = "lldb"
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		env = function()
			local variables = {}
			for k, v in pairs(vim.fn.environ()) do
				table.insert(variables, string.format("%s=%s", k, v))
			end
			return variables
		end,
	}
}

dap.configurations.c = dap.configurations.cpp


vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

vim.keymap.set("n", "<leader>?", function()
	dapui.eval(nil, { enter = true })
end, { desc = "DAP: eval under cursor" })

vim.keymap.set("n", "<F1>", dap.continue, { desc = "DAP: continue" })
vim.keymap.set("n", "<F2>", dap.step_into, { desc = "DAP: step into" })
vim.keymap.set("n", "<F3>", dap.step_over, { desc = "DAP: step over" })
vim.keymap.set("n", "<F4>", dap.step_out, { desc = "DAP: step out" })
vim.keymap.set("n", "<F5>", dap.step_back, { desc = "DAP: step back" })
vim.keymap.set("n", "<F12>", dap.restart, { desc = "DAP: restart" })

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
