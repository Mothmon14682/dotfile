return {
    {   "sitiom/nvim-numbertoggle"  },
    {
        "ya2s/nvim-cursorline",
        config = function ()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    number = false,
                    timeout = 0
                },

                cursorword = {
                    enable = false,
                }
            })
        end
    },
}
