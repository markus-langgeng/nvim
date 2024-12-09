local map = vim.keymap.set
local ol = vim.opt_local

-- ol.shiftwidth = 2
-- ol.tabstop = 2
-- ol.softtabstop = 2
-- ol.expandtab = true
-- ol.smartindent = true
-- ol.autoindent = true

map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = "LSP Flutter-tools: Show hover", buffer = true } )
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "LSP Flutter-tools: Jump to definition", buffer = true })
map("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "LSP Flutter-tools: Open code actions using the default lsp UI, if you want to change this please see the plugins above", buffer = true })
map("x", "<leader>ca", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>", { desc = "LSP Flutter-tools: Open code actions for the selected visual range", buffer = true })

map("n", "<localleader>fr", "<Cmd>FlutterRun<CR>", { desc = "Flutter-tools: Run the current project. This needs to be run from within a flutter project.", buffer = true })
map("n", "<localleader>fq", "<Cmd>FlutterQuit<CR>", { desc = "Flutter-tools: Ends a running session.", buffer = true })
map("n", "<localleader>fo", "<Cmd>FlutterOutlineToggle<CR>", { desc = "Flutter-tools: Toggle the outline window showing the widget tree for the given file.", buffer = true })
