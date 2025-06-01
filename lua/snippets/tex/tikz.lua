---@diagnostic disable: undefined-global

local helper = require("snippets.utils.helper")
local conditions = require("snippets.utils.conditions")

local M = {}

local tikzpicture = function ()
    return s({ trig = "tikzpicture" },
        fmta([[
        \begin{tikzpicture}
        [ % mystyle/.style={(shape),shape aspect=(1),color/draw/fill,text centered,text width=5cm,minimum size/width/height,label={}},
        arrows/.style={thick,->,>=stealth},
        <opts>
        ]
            <content>
        \end{tikzpicture}
        ]], {
                opts = i(1),
                content = i(0)
            }),
        {
            condition = conditions.line_begin
                * conditions.latex.pkg.tikz
                * conditions.latex.pkg.pgfornament
                - conditions.latex.env.tikzpicture,
            show_condition = -conditions.latex.env.tikzpicture
        }
    )
end

-- \pgfkeys{/key family/key/.subkey = {value list} }
local diagram_element_styles = {

}

local corner_decorations = function()
    return s({ trig = "corner_decorations" },
        fmta([[
        \begin{tikzpicture}
        [
        remember picture,overlay,
        corndec/.style={inner sep=5pt}
        ]

            \node[corndec,anchor=north west] (nw) at (current page.north west) {\pgfornament[scale=.4,          ]{63}};
            \node[corndec,anchor=south west] (sw) at (current page.south west) {\pgfornament[scale=.4,symmetry=h]{63}};
            \node[corndec,anchor=north east] (ne) at (current page.north east) {\pgfornament[scale=.4,          ]{64}};
            \node[corndec,anchor=south east] (se) at (current page.south east) {\pgfornament[scale=.4,symmetry=h]{64}};
        \end{tikzpicture}
        ]], {}),
        {
            condition = conditions.line_begin
                * conditions.latex.pkg.tikz
                * conditions.latex.pkg.pgfornament
                - conditions.latex.env.tikzpicture,
            show_condition = -conditions.latex.env.tikzpicture
        }
    )
end
table.insert(M, corner_decorations())


return M
