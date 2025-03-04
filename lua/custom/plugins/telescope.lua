return {
    {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" }, --lazy load this when required
            { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" },
            { "nvim-telescope/telescope-smart-history.nvim" },
            { "kkharji/sqlite.lua" },
        },
        config = function()
            require "custom.telescope"
        end
    },
}
