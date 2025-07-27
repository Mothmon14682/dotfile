return {
    "JoosepAlviste/palenightfall.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("palenightfall").setup({
            color_overrides = {
                foreground = "#ffffff"
            }
        })
        vim.cmd.colorscheme("palenightfall")
    end
}
