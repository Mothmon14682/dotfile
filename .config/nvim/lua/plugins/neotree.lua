return{
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
      },
      lazy = false,
      opts = {},
      config = function()
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = {
                    enable = true
                }
            },
            close_if_last_window = true;
        })
        vim.keymap.set("n", "<leader>o", ":Neotree filesystem reveal left<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>co", ":Neotree close filesystem<CR>", { noremap = true, silent = true })
      end
}
