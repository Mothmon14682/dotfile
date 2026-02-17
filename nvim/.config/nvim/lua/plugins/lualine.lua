return{
    "nvim-lualine/lualine.nvim",
    config = function ()
        require("lualine").setup({
            themes = "horizon",
            extensions = { "neo-tree", "lazy", "fzf" },
        })
    end
}
