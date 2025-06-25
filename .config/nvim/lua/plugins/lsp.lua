local mason_opts = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        border = "rounded",
    },
}

local ensure_installed = {
    "pyright",
    "marksman",
    "bashls",
    "ruff",
    "lua_ls",
}

local config = function()

    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
    )


    -- install LSP-servers and tooling
    require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup {
                    capabilities = capabilities
                }
            end,
        }
    })

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-p>"]     = cmp.mapping.select_prev_item(cmp_select),
            ["<C-n>"]     = cmp.mapping.select_next_item(cmp_select),
            ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        }),
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
    })

    -- appearance
    require("lspconfig.ui.windows").default_options.border = "rounded"

    vim.diagnostic.config({
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            header = "",
            prefix = "",
        },
    })

    -- keybindings
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
        desc = "Lsp Actions",
        callback = function(event)
            local map = function (keys, func, desc, mode)
                mode = mode or "n"
                vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc})
            end

            map("K", vim.lsp.buf.hover, "Hover")
            map("<F2>", vim.lsp.buf.rename, "Rename")

            map("<F6>", require("telescope.builtin").lsp_references, "find references")
            map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")

            map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            -- map("gra", vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
            --
            -- Fuzzy find all the symbols in your current workspace.
            --  Similar to document symbols, except searches over your entire project.
            -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

            -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            -- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            -- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            -- vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            -- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
            -- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
            -- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            -- 
            -- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
            -- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
            -- 
            -- vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
            -- vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
            -- vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        end,
    })
end

return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- automatically install LSPs and related tools
            { "williamboman/mason.nvim", opts = mason_opts },
            { "williamboman/mason-lspconfig.nvim" },

            -- useful status updates
            { "j-hui/fidget.nvim", opts = {} },

            -- completions stuff
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-path" },

            -- snippets
            { "L3MON4D3/LuaSnip" },

            -- "saadparwaiz1/cmp_luasnip",
            -- "stevearc/conform.nvim",
        },
        lazy = false,
        config = config,
    },
}
