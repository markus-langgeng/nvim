---@diagnostic disable: undefined-global

local helper = require("custom.snippets.utils.helper")
local conditions = require("custom.snippets.utils.conditions")

local M = {}

local headings = {
    ch = [[\chapter]],
    h1 = [[\section]],
    h2 = [[\subsection]],
    h3 = [[\subsubsection]],
}

local styles = {
    tii = [[\textit]],
    tbb = [[\textbf]],
    tss = [[\textsl]],
    tuu = [[\underline]],
    tmm = [[\emph]],
    sps = [[\textsuperscript]],
    sbs = [[\textsubscript]],
}

local cites = {
    tcc = [[\textcite]],
    pcc = [[\parencite]],
}

local files = {
    -- Can be nested,
    -- File extension is optional
    -- File extension is needed when using absolute path
    ipp = { [[\input]], { condition = conditions.line_begin } },
    -- Only in preamble, can't be nested
    -- Forces page break (book chapters)
    -- Can be used with \includeonly{} in preamble
    icc = { [[\include]], { condition = conditions.line_begin * conditions.latex.env.document } },
    -- Use to only include certain files without changing page, label, figure,
    -- or table number
    ico = { [[\includeonly]], { condition = conditions.line_begin * conditions.latex.env.preamble } }
}

local math = {
    ["sqq"] = {
        snp = [[\sqrt{<>}]],
        nodes = { d(1, helper.get_visual) },
        dscr = "Square root"
    },
    ["rm"] = {
        snp = [[\mathrm{<>}]],
        nodes = { d(1, helper.get_visual) },
        dscr = "Remove math formatting (resulting in upright text)"
    },
    ["([%a%d])^^"] = {
        snp = [[<>^{<>}]],
        nodes = { f(function(_, snip) return snip.captures[1] end), d(1, helper.get_visual) },
        dscr = "Superscript"
    },
    ["([%a%d])__"] = {
        snp = [[<>_{<>}]],
        nodes = { f(function(_, snip) return snip.captures[1] end), d(1, helper.get_visual) },
        dscr = "Subscript"
    },
    ["([^%a])ii"] = {
        snp = [[<>\int_{<>}^{<>} <> \,dx]],
        nodes = {
            f(function(_, snip) return snip.captures[1] end),
            i(2, "-\\infty"),
            i(3, "\\infty"),
            d(1, helper.get_visual),
        },
        dscr = "Integral"
    },
    ["([^%a])ss"] = {
        snp = [[<>\sum_{<>}^{<>} <>]],
        nodes = {
            f(function(_, snip) return snip.captures[1] end),
            i(2, "n=1"),
            i(3, "\\infty"),
            d(1, helper.get_visual),
        },
        dscr = "Sum"
    },
    ["([^%a])ll"] = {
        snp = [[<>\lim_{<> \to <>} <>]],
        nodes = {
            f(function(_, snip) return snip.captures[1] end),
            i(2, "x"),
            i(3, "\\infty"),
            d(1, helper.get_visual),
        },
        dscr = "Limit"
    },
    ["([^%a])ff"] = {
        snp = [[\frac{<>}{<>}]],
        nodes = { i(1), i(2) },
        dscr = "Fraction"
    },
}

local mathzone = {
    ["mm"] = {
        snp = [[$<>$]],
        nodes = {
            d(1, helper.get_visual),
        },
        dscr = "Inline mathzone"
    },
    ["MM"] = {
        snp = "\\[ <> \\]",
        nodes = {
            d(1, helper.get_visual),
        },
        dscr = "Display mathzone"
    },
}

for k, v in pairs(headings) do
    local str = string.format(
        [[%s{<>} \label{%s:<>}]],
        v, v:sub(2, 4))
    local snp = function()
        return s({ trig = k, snippetType = "autosnippet" },
            fmta(str, { d(1, helper.get_visual), rep(1) }),
            { condition =
                conditions.line_begin * conditions.latex.env.document - conditions.latex.env.tikzpicture
            })
    end
    table.insert(M, snp())
end

local insert_simple_command = function(cmd)
    for k, v in pairs(cmd) do
        local str = v .. "{<>}"
        local snp = function()
            return s({ trig = k, snippetType = "autosnippet" }, fmta(str, { d(1, helper.get_visual) }))
        end
        table.insert(M, snp())
    end
end

insert_simple_command(styles)
insert_simple_command(cites)

for k, v in pairs(files) do
    local str = v[1] .. "{<>}"
    local snp = function()
        return s({ trig = k, snippetType = "autosnippet" }, fmta(str, { i(1) }), v[2])
    end
    table.insert(M, snp())
end

local new_env = function()
    local str = [[
    \begin{<>}
        <>
    \end{<>}
    ]]
    return s({ trig = "nn", }, fmta(str, { i(1), i(0), rep(1) }),
        {
            condition = conditions.line_begin * conditions.latex.env.document,
            show_condition = conditions.latex.env.document
        }
    )
end
table.insert(M, new_env())

for k, v in pairs(math) do
    local snp = function()
        return s({ trig = k, dscr = v.dscr, snippetType = "autosnippet", wordTrig = false, regTrig = true },
            fmta(v.snp, v.nodes),
            { condition = conditions.latex.env.mathzone })
    end
    table.insert(M, snp())
end

for k, v in pairs(mathzone) do
    local snp = function()
        return s({ trig = k, dscr = v.dscr }, fmta(v.snp, v.nodes), {
            condition = -conditions.latex.env.mathzone,
            show_condition = -conditions.latex.env.mathzone
        })
    end
    table.insert(M, snp())
end

local pkg = function()
    local str = [[\usepackage<>{<>}]]
    return s({ trig = "pkg", snippetType = "autosnippet" },
        fmta(str, {
            c(2, {
                t(""),
                sn(1, { t("["), i(1), t("]") }),
            }),
            i(1)
        }),
        { condition = conditions.line_begin * conditions.latex.env.preamble })
end
table.insert(M, pkg())

local item = function ()
    return s({ trig = "ii", snippetType = "autosnippet"},
        t([[\item]]),
        { condition = conditions.line_begin * conditions.latex.env.lists_env }
    )
end
table.insert(M, item())

local empty = function()
    return s({ trig = "empty" },
        fmta([[
        <engine>
        \documentclass{<class>}

        \title{<title>}
        \author{<author>}
        \date{\today}

        \begin{document}

        <content>

        \end{document}
        ]],
            {
                engine = c(1, {
                    t({ "%! TEX TS-program = xelatex", "" }),
                    t({ "%! TeX program = lualatex", "" }),
                }),
                title = i(2, ""),
                author = i(3, "Full Name"),
                class = i(4, "extarticle"),
                content = i(0, "")
            }
        ),
        {
            condition = conditions.line_begin * conditions.first_line,
            show_condition =  conditions.first_line
        })
end
table.insert(M, empty())

local makalah = function()
    return s({ trig = "makalah" },
        fmta([[
        <engine>
        \documentclass[a4paper,12pt]{extreport}

        \usepackage{graphicx}
        \graphicspath{{img}}
        \usepackage{import}
        \import{packages/}{makalah.tex}

        \begin{document}
        \maketitle
        \subimport{body/makalah/}{body.tex}
        \end{document}
        ]],
            {
                engine = c(1, {
                    t({ "%! TEX TS-program = xelatex", "" }),
                    t({ "%! TeX program = lualatex", "" }),
                }),
            }
        ),
        {
            condition = conditions.line_begin * conditions.first_line,
            show_condition =  conditions.first_line
        })
end
table.insert(M, makalah())

local catatan = function()
    return s({ trig = "catatan" },
        fmta([[
        <engine>
        \documentclass[a4paper,10pt]{extarticle}

        \usepackage{graphicx}
        \graphicspath{{img}}
        \usepackage{import}
        \import{packages/}{catatan.tex}

        \begin{document}
        \maketitle
        \subimport{body/catatan/}{body.tex}
        \end{document}
        ]],
            {
                engine = c(1, {
                    t({ "%! TEX TS-program = xelatex", "" }),
                    t({ "%! TeX program = lualatex", "" }),
                }),
            }
        ),
        {
            condition = conditions.line_begin * conditions.first_line,
            show_condition =  conditions.first_line
        })
end
table.insert(M, catatan())

local cv = function()
    return s({ trig = "cv" },
        fmta([[
        <engine>
        \documentclass[a4paper,10pt]{extarticle}

        \usepackage{graphicx}
        \graphicspath{{img}}
        \usepackage{import}
        \import{packages/}{cv.tex}

        \begin{document}
        \maketitle

        \end{document}
        ]],
            {
                engine = c(1, {
                    t({ "%! TEX TS-program = xelatex", "" }),
                    t({ "%! TeX program = lualatex", "" }),
                }),
            }
        ),
        {
            condition = conditions.line_begin * conditions.first_line,
            show_condition =  conditions.first_line
        })
end
table.insert(M, cv())

return M
