return {
    "b0o/incline.nvim",
    config = function()
        require("incline").setup({
            window = { margin = { horizontal = 0} },
            -- highlight = {
            --     groups = {
            --         InclineNormal = { guibg = "none" },
            --         InclineNormalNC = { guibg = "none" },
            --     },
            -- },
        })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
}
