local f = require("flutter-tools")

f.setup({
    lsp = {
        color = {
            enabled = true,
            background = true,
            foreground = false,
            background_color = { r = 19, g = 17, b = 24}, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            virtual_text = false,
            virtual_text_str = "■",
        }
    }
})
