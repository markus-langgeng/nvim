local hl = vim.api.nvim_set_hl
hl(0, "StlMode",   { fg="#dcd7ba", bg="#363646" })
hl(0, "StlBright", { fg = "#dcd7ba" })

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
        table.insert(diag_msg, string.format("%s%s%s%s", "%##", "E=", num_errors, "%*"))
    end

    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
        table.insert(diag_msg, string.format("%s%s%s%s", "%#DiagnosticWarn#", "I=", num_warnings, "%*"))
    end

    local num_info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    if num_info > 0 then
        table.insert(diag_msg, string.format("%s%s%s%s", "%#DiagnosticInfo#", "I=", num_info, "%*"))
    end

    local num_hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    if num_hints > 0 then
        table.insert(diag_msg, string.format("%s%s%s%s", "%#DiagnosticHint#", "H=", num_hints, "%*"))
    end

    return table.concat(diag_msg, " ")
end

function M.statusline()
    local cur_mode = vim.api.nvim_get_mode().mode
    cur_mode = string.format("%s --%s-- %s", "%#StlMode#", M.vim_modes[cur_mode] or cur_mode, "%*")
    local diags = M.diagnostic_status() ~= "" and string.format(" %s ", M.diagnostic_status()) or ""
    local file_perc = string.format("%s%d%%%%%s", "%#StlBright#", (vim.fn.line('.') * 100 / vim.fn.line('$')), "%*")

    local left = string.format("%s%s", cur_mode, diags)
    local middle = string.format("%s %s %s", "%#StlBright#", string.gsub(vim.fn.expand("%:p:h"), vim.fn.expand("$HOME"), "~"), "%*")
    local right = string.format("[%s] (%d,%d,%s) ", vim.bo.filetype, vim.fn.line('.'), vim.fn.col('.'), file_perc)

    local clean_part = function(s)
        return string.gsub(s, "%%%#%w*%#", ""):gsub("%%%*", ""):gsub("%%%%", "%%")
    end

    local wwidth = vim.o.columns
    local lwidth = string.len(clean_part(left))
    local mwidth = string.len(clean_part(middle))
    local rwidth = string.len(clean_part(right))

    local lpad = math.floor(wwidth / 2) - lwidth - math.floor(mwidth / 2)
    local rpad = math.ceil(wwidth / 2) - rwidth - math.ceil(mwidth / 2)

    return string.format("%s%s%s%s%s",
        left,
        string.rep(" ", lpad),
        middle,
        string.rep(" ", rpad),
        right)
end

return M
