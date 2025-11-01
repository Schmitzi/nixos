return require("lazy").setup({
    -- File Finder (Telescope with FZF)
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" }, 
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git", "dist", "build" },
                    mappings = {
                        i = { 
                            ["<C-u>"] = false, 
                            ["<C-d>"] = false,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        },
                    },
                    layout_config = {
                        horizontal = {
                            preview_width = 0.55,
                        },
                    },
                },
                pickers = {
                    find_files = { 
                        hidden = true,
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    }, 
                    live_grep = { 
                        additional_args = function() return { "--hidden" } end,
                    },
                }
            })

            -- Keybindings for Telescope
            vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List Buffers" })
            vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
            vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
            vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find Word" })
            vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
            vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
        end
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("fzf")
        end
    },

    -- File Explorer (NvimTree)
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 35,
                    side = "left",
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        show = {
                            git = true,
                            folder = true,
                            file = true,
                            folder_arrow = true,
                        },
                    },
                },
                filters = {
                    dotfiles = false,
                    custom = { "^.git$" },
                },
                git = {
                    enable = true,
                    ignore = false,
                },
            })
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
            vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<cr>", { desc = "Focus File Explorer" })
        end
    },

    -- Treesitter (Better Syntax Highlighting)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "json", "markdown", "bash", "yaml" },
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<BS>",
                    },
                },
            })
        end
    },

    -- LSP (Language Server Protocol)
    "neovim/nvim-lspconfig",

    -- Auto-completion (nvim-cmp)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim", -- VSCode-like pictograms
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            
            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                    })
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" }
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end
    },

    -- Statusline (Lualine) with Git integration
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = { 
                    theme = "auto",
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
            })
        end
    },

    -- Bufferline (Tab bar like VSCode)
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    diagnostics = "nvim_lsp",
                    separator_style = "thin",
                    show_buffer_close_icons = true,
                    show_close_icon = false,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true,
                        }
                    },
                },
            })
            -- Buffer navigation keymaps
            vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
            vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
            vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close Buffer" })
            vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })
        end
    },

    -- Git Integration (Gitsigns)
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { text = '│' },
                    change = { text = '│' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    
                    -- Navigation
                    vim.keymap.set('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, buffer=bufnr, desc="Next Hunk"})
                    
                    vim.keymap.set('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, buffer=bufnr, desc="Previous Hunk"})
                    
                    -- Actions
                    vim.keymap.set('n', '<leader>gs', gs.stage_hunk, {buffer=bufnr, desc="Stage Hunk"})
                    vim.keymap.set('n', '<leader>gr', gs.reset_hunk, {buffer=bufnr, desc="Reset Hunk"})
                    vim.keymap.set('n', '<leader>gp', gs.preview_hunk, {buffer=bufnr, desc="Preview Hunk"})
                    vim.keymap.set('n', '<leader>gb', gs.blame_line, {buffer=bufnr, desc="Blame Line"})
                end
            })
        end
    },

    -- Git Commands (Fugitive)
    "tpope/vim-fugitive",

    -- Which-key (Keybinding help like VSCode's command palette)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({
                preset = "modern",
            })
            
            -- Register key groups
            wk.add({
                { "<leader>f", group = "Find" },
                { "<leader>g", group = "Git" },
                { "<leader>b", group = "Buffer" },
                { "<leader>c", group = "Code" },
                { "<leader>t", group = "Terminal/Trouble" },
            })
        end
    },

    -- Trouble (Better diagnostics list like VSCode's problems panel)
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup()
            vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
            vim.keymap.set("n", "<leader>tq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix List (Trouble)" })
        end
    },

    -- Terminal (Toggleterm)
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                direction = 'horizontal',
                close_on_exit = true,
                shell = vim.o.shell,
            })
            
            -- Terminal keymaps
            function _G.set_terminal_keymaps()
                local opts = {buffer = 0}
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            end
            
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end
    },

    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
            -- Integration with nvim-cmp
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end
    },

    -- Comment.nvim (Easy commenting like VSCode)
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
        end
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "│",
                },
                scope = {
                    enabled = true,
                    show_start = true,
                    show_end = true,
                },
            })
        end
    },

    -- Colorscheme (Catppuccin)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    telescope = true,
                    which_key = true,
                }
            })
            vim.cmd("colorscheme catppuccin-mocha")
        end
    }, 

    -- Discord Rich Presence (Cord)
    {
        'vyfor/cord.nvim',
        build = ':Cord update',
        event = "VeryLazy",
        opts = {
            usercmds = true,                     -- Enable user commands
            log_level = 'error',                 -- Only show errors
            timer = {
                interval = 1500,                 -- Update interval in ms (1.5 seconds)
                reset_on_idle = false,           -- Don't reset timer when idle
                reset_on_change = false,         -- Don't reset timer when switching files
            },
            editor = {
                image = nil,                     -- Use default Neovim logo
                client = 'neovim',               -- Editor name
                tooltip = 'The Superior Text Editor', -- Tooltip text
            },
            display = {
                show_time = true,                -- Show elapsed time
                show_repository = true,          -- Show Git repository name
                show_cursor_position = false,    -- Don't show cursor position (can be noisy)
                swap_fields = false,             -- Don't swap state/details fields
                swap_icons = false,              -- Don't swap large/small icons
                workspace_blacklist = {},        -- No workspace blacklist
            },
            lsp = {
                show_problem_count = false,      -- Don't show LSP diagnostic count
                severity = 1,                    -- Minimum severity to show
                scope = 'workspace',             -- Show workspace diagnostics
            },
            idle = {
                enable = true,                   -- Show idle status
                show_status = true,              -- Show status when idle
                timeout = 300000,                -- Idle timeout (5 minutes)
                disable_on_focus = true,         -- Disable idle when focused
                text = 'Idling',                 -- Idle text
                tooltip = '💤',                  -- Idle tooltip
            },
            -- Let Cord use its default text formatting (it handles filenames automatically)
            buttons = {
                {
                    label = 'View Repository',
                    url = 'https://github.com/Schmitzi',
                },
            },
        },
        config = function(_, opts)
            require('cord').setup(opts)
            
            -- Note: Cord manages presence automatically once setup
            -- It will show your activity as soon as you start editing
            -- To temporarily disable, restart Neovim or modify the config
        end
    },
    
    -- Mason LSP Installer
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    
    -- Mason LSP Configuration (must load after mason.nvim)
    {
        "williamboman/mason-lspconfig",
        dependencies = { 
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local mason_lspconfig = require('mason-lspconfig')
            
            -- Setup mason-lspconfig
            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",        -- Lua
                    "pyright",       -- Python
                    "ts_ls",         -- TypeScript/JavaScript
                },
                automatic_installation = true,
            })
            
            -- LSP keybindings (applied when LSP attaches to a buffer)
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, noremap = true, silent = true }
                
                -- Navigation
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                
                -- Documentation
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                
                -- Code actions
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
                
                -- Diagnostics
                vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                
                -- Formatting
                vim.keymap.set('n', '<leader>cf', function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
            end
            
            -- Configure capabilities for nvim-cmp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            
            -- Configure Lua Language Server (lua_ls) with modern API
            vim.lsp.config.lua_ls = {
                cmd = { 'lua-language-server' },
                filetypes = { 'lua' },
                root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            }
            
            -- Configure Pyright (Python)
            vim.lsp.config.pyright = {
                cmd = { 'pyright-langserver', '--stdio' },
                filetypes = { 'python' },
                root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
                on_attach = on_attach,
                capabilities = capabilities,
            }
            
            -- Configure TypeScript/JavaScript Language Server
            vim.lsp.config.ts_ls = {
                cmd = { 'typescript-language-server', '--stdio' },
                filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
                root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
                on_attach = on_attach,
                capabilities = capabilities,
            }
            
            -- Enable the LSP servers
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('ts_ls')
        end
    },
})
