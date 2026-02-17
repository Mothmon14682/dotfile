---@diagnostic disable: undefined-doc-name
return {
    "saghen/blink.cmp",
    -- dependencies = { 'rafamadriz/friendly-snippets' },

    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = "default",

            ["<C-p>"] = {},
            ["<C-n>"] = {},
            ["<C-y>"] = {},

            ["<Tab>"] = { "accept", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
        },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "normal",
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            documentation = { auto_show = false },
            menu = {
                border = "single",
                draw = {
                    treesitter = {"lsp"},
                    columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description' }, { "kind", gap = 1 } },
                    components = {
                    item_idx = {
                            text = function(ctx)
                                if not ctx.idx then return "" end
                                local idx = ctx.idx == 10 and 0 or ctx.idx
                                return string.format("[%d]", idx)
                            end,
                            highlight = 'BlinkCmpItemIdx',
                        }
                    }
                }
            },
            list = { max_items = 8 },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to opts_extend
        sources = {
            min_keyword_length = 2,
            default = { "lsp", "path", "snippets", "buffer" },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using implementation = "lua" or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using implementation = "prefer_rust"
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
