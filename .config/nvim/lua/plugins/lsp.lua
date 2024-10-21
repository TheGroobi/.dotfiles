return {
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "prettier",
                "luacheck",
                "shellcheck",
                "shfmt",
                "tailwindcss-language-server",
                "typescript-language-server",
                "vtsls",
                "css-lsp",
                "svelte-language-server",
                "eslint_d",
                "gopls",
                "gofumpt",
                "gomodifytags",
                "impl",
                "goimports",
                "intelephense",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = {
                enabled = false,
            },

            servers = {
                cssls = {},
                tailwindcss = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(...)
                    end,
                },
                gopls = {},
                tsserver = {
                    enabled = false,
                },
                vtsls = {
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "javascript.jsx",
                        "typescript",
                        "typescriptreact",
                        "typescript.tsx",
                    },
                    settings = {
                        complete_function_calls = true,
                        vtsls = {
                            enableMoveToFileCodeAction = true,
                            autoUseWorkspaceTsdk = true,
                        },
                        typescript = {
                            updateImportsOnFileMove = { enabled = "always" },
                            suggest = {
                                completeFunctionCalls = true,
                            },
                        },
                    },
                },
                svelte = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern("package.json", ".git")(...)
                    end,
                    filetypes = { "svelte" },
                    cmd = { "svelteserver", "--stdio" },
                    on_attach = function(client, bufnr)
                        if client.server_capabilities.documentFormattingProvider then
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                callback = function()
                                    vim.lsp.buf.format({ bufnr = bufnr })
                                end,
                            })
                        end
                    end,
                },
                html = {},
                lua_ls = {
                    single_file_support = true,
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                workspaceWord = true,
                                callSnippet = "Both",
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable",
                            },
                            doc = {
                                privateName = { "^_" },
                            },
                            type = {
                                castNumberToInteger = true,
                            },
                            diagnostics = {
                                disable = { "incomplete-signature-doc", "trailing-space" },
                                groupSeverity = {
                                    strong = "Warning",
                                    strict = "Warning",
                                },
                                groupFileStatus = {
                                    ["ambiguity"] = "Opened",
                                    ["await"] = "Opened",
                                    ["codestyle"] = "None",
                                    ["duplicate"] = "Opened",
                                    ["global"] = "Opened",
                                    ["luadoc"] = "Opened",
                                    ["redefined"] = "Opened",
                                    ["strict"] = "Opened",
                                    ["strong"] = "Opened",
                                    ["type-check"] = "Opened",
                                    ["unbalanced"] = "Opened",
                                    ["unused"] = "Opened",
                                },
                                unusedLocalExclude = { "_*" },
                            },
                            format = {
                                defaultConfig = {
                                    indent_style = "tab",
                                    indent_size = "4",
                                    continuation_indent_size = "4",
                                },
                            },
                        },
                    },
                },
            },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji"
        },
        opts = function(_, opts)
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                }, {
                    { name = 'path' },
                })
            })

            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline('?', {
                sources = {
                    { name = 'buffer' }
                }
            })
        end
    }
}
