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
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "brenoprata10/nvim-highlight-colors",
      config = function ()
          require('nvim-highlight-colors').setup({
              render = 'virtual',
              virtual_symbol_prefix = ' ',
              virtual_symbol_suffix = '',
              virtual_symbol = '■',
              virtual_symbol_position = 'eow',
          })
      end
    },
}
