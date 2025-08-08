return {
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters = {
                    prettier = {
                        command = "prettier",
                        args = { "--config", ".prettierrc" }
                    },
                },
                formatters_by_ft = {
                    javascript = { 'eslint_d' },
                    typescript = { 'eslint_d' },
                    css = { 'prettier' },
                    html = { 'prettier' },
                    json = { 'eslint_d' },
                    svelte = { 'prettier' },
                    ["_"] = { 'eslint_d' },
                },
            })

           vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
           vim.api.nvim_create_autocmd("BufWritePre", {
                group = "FormatOnSave",
                pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.scss", "*.json", "*.html", "*.svelte" },
                callback = function()
                    require('conform').format()
                end,
            })
       end,
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                php = { },
            },
        },
    }
}
