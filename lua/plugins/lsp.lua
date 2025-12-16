---@diagnostic disable: undefined-global

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- Mason setup
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", -- lua LSP
                    "pyright", -- Python LSP
                    "rust_analyzer", -- Rust LSP
                    "html", -- html LSP
                    "cssls", -- css LSP
                    "emmet_ls", -- emmet LSP
                    "jsonls", -- json LSP
                },
                automatic_installation = true,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- on_attach function to map keys after LSP attaches to buffer
            local on_attach = function(_, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local keymap = vim.keymap.set

                keymap("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
                keymap("n", "gr", vim.lsp.buf.references, opts) -- go to references
                keymap("n", "gi", vim.lsp.buf.implementation, opts) -- go to implementation
                keymap("n", "K", vim.lsp.buf.hover, opts) -- hover
                keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) -- rename
                keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- code action
                keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts) -- previous diagnostic
                keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts) -- next diagnostic
                keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts) -- format
            end

            -- Lua LSP
            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", "stylua.toml", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } }, -- recognize the `vim` global
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false, -- disable annoying warnings for third-party libraries
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            -- Python LSP (Pyright)
            vim.lsp.config.pyright = {
                -- Mason puts 'pyright-langserver' in your path, but we must explicitly define it here
                cmd = { "pyright-langserver", "--stdio" },
                filetypes = { "python" },
                -- Common root markers for Python projects
                root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        },
                    },
                },
            }

            -- Rust LSP
            vim.lsp.config.rust_analyzer = {
                cmd = { "rust-analyzer" },
                filetypes = { "rust" },
                root_markers = { "Cargo.toml", "rust-project.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true,
                        },
                        checkOnSave = true,
                        check = {
                            command = "clippy",
                        },
                    },
                },
            }

            -- HTML LSP
            vim.lsp.config.html = {
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html", "erb" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- CSS LSP
            vim.lsp.config.cssls = {
                cmd = { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- Emmet LSP
            vim.lsp.config.emmet_ls = {
                cmd = { "emmet-ls", "--stdio" },
                filetypes = { "html", "css", "scss", "erb" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- JSON LSP
            vim.lsp.config.jsonls = {
                cmd = { "vscode-json-language-server", "--stdio" },
                filetypes = { "json", "jsonc" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- diagnostics config with modern sign configuration
            vim.diagnostic.config({
                virtual_text = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '✘',
                        [vim.diagnostic.severity.WARN] = '▲',
                        [vim.diagnostic.severity.HINT] = '⚑',
                        [vim.diagnostic.severity.INFO] = '»',

                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },
}
