local ol = vim.opt_local
local map = vim.keymap.set

ol.shiftwidth = 2
ol.tabstop = 2
ol.softtabstop = 2
ol.expandtab = true
ol.smartindent = true
ol.autoindent = true

map("n", "<localleader>lv", "<cmd>TypstPreviewToggle<cr>")
