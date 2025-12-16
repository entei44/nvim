return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",  -- LSP completions
        "hrsh7th/cmp-buffer",    -- buffer words
        "hrsh7th/cmp-path",      -- filesystem paths
        "hrsh7th/cmp-cmdline",   -- command-line completions
        "L3MON4D3/LuaSnip",      -- snippet engine
        "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
        })
    end
}
