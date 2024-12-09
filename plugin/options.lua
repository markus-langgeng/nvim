local o = vim.opt
local g = vim.g

-- Indenting
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

o.number = true
o.relativenumber = true
o.cursorline = true
o.guicursor = ""
o.signcolumn = "yes"
o.colorcolumn = "80"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.mouse = ""
o.winbar = "%= %t %m %="
o.statusline = [[%!v:lua.require("statusline").statusline()]]
o.laststatus = 3
o.whichwrap:append("<>[]hl")       -- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
o.updatetime = 100                 -- interval for writing swap file to disk, also used by gitsigns
o.shellcmdflag = "-ic"             -- interactive shell
o.hlsearch = false
o.incsearch = true
o.lazyredraw = true
o.inccommand = "split"
o.showmode = false
o.ignorecase = true
o.smartcase = true
o.wrap = false
o.isfname:append("@-@")
o.shortmess:append("c")

-- o.scrolloff = 999
o.scrolloff = 10
vim.keymap.set("n", "<leader>m", function() vim.opt.scrolloff = 999 - vim.o.scrolloff end)

-- treesitter fold
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
-- o.foldlevel = 1
o.foldenable = false -- Disable folding at startup.

-- undofile
-- o.swapfile = true
-- o.backup = false
-- o.undofile = true
-- o.undodir = vim.fn.expand("~/.cache/nvim/undodir")
o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
o.undofile = true

g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

g.c_syntax_for_h = 1
