return{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local configs = require("nvim-treesitter")

        configs.setup({
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
