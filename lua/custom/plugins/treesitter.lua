return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
        "andymass/vim-matchup",
        { "numToStr/Comment.nvim", event = "VeryLazy" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
        { "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" }
    },
    config = function()
        require("custom.treesitter")
    end
}
