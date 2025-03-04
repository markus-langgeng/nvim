local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup
local system = vim.fn.system
local g = vim.g

g.vimtex_view_method = "zathura_simple"
g.vimtex_imaps_enabled = 0
g.vimtex_fold_enabled = 1
g.vimtex_fold_types = {
    preamble = { enabled = 1 },
}
g.vimtex_compiler_latexmk = {
    aux_dir = "aux",
    callback = 1,
    continuous = 1,
    executable = "latexmk",
    hooks = {},
    options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
}
