local M = {}

M.vim_modes = {
    ["n"] = "NORMAL",
    ["no"] = "OPERATION PENDING",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

function M.diagnostic_status()
    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local diag_msg = {}
    if num_errors > 0 then
        table.insert(diag_msg, "E=" .. num_errors)
    end

    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
        table.insert(diag_msg, "W=" .. num_warnings)
    end

    local num_info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    if num_info > 0 then
        table.insert(diag_msg, "I=" .. num_info)
    end

    local num_hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    if num_hints > 0 then
        table.insert(diag_msg, "H=" .. num_hints)
    end

    return table.concat(diag_msg, " ")
end

function M.statusline()
    local cur_mode = vim.api.nvim_get_mode().mode
    cur_mode = M.vim_modes[cur_mode] or cur_mode
    local diags = M.diagnostic_status() or ""

    if diags ~= "" then
        diags = string.format("%%(-- %s -- [%s]%%)", cur_mode, diags)
    else
        diags = string.format("%%(-- %s --%%)", cur_mode)
    end

    local left = string.format("%s", diags)
    local right = string.format("[%s] (%d,%d,%d%%%%)", vim.bo.filetype, vim.fn.line('.'), vim.fn.col('.'), vim.fn.line('.') * 100 / vim.fn.line('$'))
    local middle = string.gsub(vim.fn.expand("%:p:h"), vim.fn.expand("$HOME"), "~")
    local wwidth = vim.api.nvim_win_get_width(0)
    local lwidth = vim.fn.strwidth(left)
    local rwidth = vim.fn.strwidth(right)
    local mwidth = vim.fn.strwidth(middle)

    local available_space = wwidth - lwidth - rwidth
    local padding = math.max(0, ( available_space - mwidth ) / 2)

    return string.format(" %s%s%s%s%s",
        left,
        string.rep(" ", math.floor(padding)),
        middle,
        string.rep(" ", math.ceil(padding)),
        right)
end

return M
