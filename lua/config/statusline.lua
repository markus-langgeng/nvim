local dget = vim.diagnostic.get
local dsev = vim.diagnostic.severity
local hlset = vim.api.nvim_set_hl
hlset(0, "StlMode", { fg = "#dcd7ba", bg = "#363646", bold = true })
hlset(0, "StlBright", { fg = "#363646", bg = "#dcd7ba", bold = true })

local M = {}

local modes = {
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

local hl_part = function(hl, s)
    return string.format("%s%s%s", string.format("%s%s%s", "%#", hl, "#"), table.concat(s, ""), "%*")
end

local clean_part = function(s)
    return (string.gsub(s, "%%%#%w*%#", ""):gsub("%%%*", ""):gsub("%%%%", "%%"))
end

local dgetall = function()
    local d = {}
    local num_e = #dget(0, { severity = dsev.ERROR })
    local num_w = #dget(0, { severity = dsev.WARN })
    local num_i = #dget(0, { severity = dsev.INFO })
    local num_h = #dget(0, { severity = dsev.HINT })

    if num_e > 0 then table.insert(d, hl_part("DiagnosticError", { "E=", num_e })) end
    if num_w > 0 then table.insert(d, hl_part("DiagnosticWarn", { "W=", num_w })) end
    if num_i > 0 then table.insert(d, hl_part("DiagnosticInfo", { "I=", num_i })) end
    if num_h > 0 then table.insert(d, hl_part("DiagnosticHint", { "H=", num_h })) end

    return table.concat(d, " ")
end

function M.statusline()
    local mode = hl_part("StlMode", { " --", modes[vim.api.nvim_get_mode().mode], "-- " })
    local diags = dgetall() ~= "" and string.format(" %s", dgetall()) or ""
    local howfarl = hl_part("StlMode", { vim.fn.line('.'), "/", vim.fn.line('$') })
    local howfarp = hl_part("StlMode", { math.floor(vim.fn.line('.') * 100 / vim.fn.line('$')), "%%" })

    local w = vim.o.columns
    local l = string.format("%s%s", mode, diags)
    local m = hl_part("StlBright", { " ", (string.gsub(vim.fn.expand("%:p:h"), vim.fn.expand("$HOME"), "~")), " " })
    local r = string.format("[%s] (%s,%s) ", vim.bo.filetype, howfarl, howfarp)

    local lw = string.len(clean_part(l))
    local mw = string.len(clean_part(m))
    local rw = string.len(clean_part(r))

    local lp = string.rep(" ", math.floor(w / 2) - lw - math.floor(mw / 2))
    local rp = string.rep(" ", math.ceil(w / 2) - rw - math.ceil(mw / 2))

    return string.format("%s%s%s%s%s", l, lp, m, rp, r)
end

return M
