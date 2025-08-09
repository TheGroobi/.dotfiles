vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.showmode = false

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.clipboard = "unnamedplus"
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.scrolloff = 10
vim.opt.expandtab = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "node_modeles/*, .git/*" })
vim.opt.splitkeep = "cursor"
vim.opt.formatoptions:append({ "r" })

-- We use neo-tree instead of netrw
vim.g.netrw_hide = 1

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 20
vim.o.confirm = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Coc keybinds
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set("n", "K", "<Cmd>call CocActionAsync('doHover')<CR>", { silent = true, desc = "Hover (Coc)" })

-- NeoTree toggle
vim.keymap.set("n", "<leader>h", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

---@diagnostic disable-next-line: duplicate-set-field
_G.check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 then return true end
    local line = vim.fn.getline('.')
    return line:sub(col, col):match('%s') ~= nil
end

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set({ 'n', 'x' }, '<leader>=', '<Plug>(coc-format-selected)', { desc = '[F]ormat' })
vim.keymap.set("i", "<Tab>",
    'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()',
    opts)


vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        opts = {
            delay = 0,
            icons = {
                mappings = vim.g.have_nerd_font,
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ',
                    Down = '<Down> ',
                    Left = '<Left> ',
                    Right = '<Right> ',
                    C = '<C-…> ',
                    M = '<M-…> ',
                    D = '<D-…> ',
                    S = '<S-…> ',
                    CR = '<CR> ',
                    Esc = '<Esc> ',
                    ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ',
                    NL = '<NL> ',
                    BS = '<BS> ',
                    Space = '<Space> ',
                    Tab = '<Tab> ',
                    F1 = '<F1>',
                    F2 = '<F2>',
                    F3 = '<F3>',
                    F4 = '<F4>',
                    F5 = '<F5>',
                    F6 = '<F6>',
                    F7 = '<F7>',
                    F8 = '<F8>',
                    F9 = '<F9>',
                    F10 = '<F10>',
                    F11 = '<F11>',
                    F12 = '<F12>',
                },
            },

            spec = {
                { '<leader>s', group = '[S]earch' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
            },
            performance = {
                rtp = {
                    disabled_plugins = {
                        "gzip", "matchit", "matchparen", "netrwPlugin",
                        "tarPlugin", "tohtml", "tutor", "zipPlugin",
                        "man",
                    }
                }}
        },
    },
    {
        'airblade/vim-gitgutter',
        event = { 'BufReadPre', 'BufNewFile' },
        init = function()
            vim.g.gitgutter_sign_added    = '▌'
            vim.g.gitgutter_sign_modified = '▌'
            vim.g.gitgutter_sign_removed        = '_'
            vim.g.gitgutter_sign_removed_first_line = '‾'
            vim.g.gitgutter_sign_modified_removed = '~'

            vim.g.gitgutter_realtime = 1
            vim.g.gitgutter_eager    = 1
        end,
    },
    {
        'rhysd/conflict-marker.vim',
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup({
                prefix = "New Name: ",
                empty_input_behavior = "auto",
            })

            vim.keymap.set("n", "<leader>rn", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true, desc = "[R]e[n]ame Symbol" })
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        keys = {
            {
                'gr',
                function()
                    require('telescope.builtin').lsp_references({
                        show_line = true,
                        include_declaration = false,
                    })
                end,
                desc = 'LSP: [G]oto [R]eferences',
            },
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            --vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },

    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        ft = "lua",
        config = function()
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
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
                    },
                },
            })
        end,
    },
    {
        "neoclide/coc.nvim",
        branch = "release",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",

        priority = 1000,
        config = function()
            require("catppuccin").setup({
                 float = {
                     transparent = true,
                     solid = false
                 },
                flavour = "mocha",
                styles = {
                    keywords = {"bold"},
                },
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                no_italic = true,
                no_bold = true,
            })
            vim.cmd.colorscheme("catppuccin")

            local flavor = require("catppuccin").flavour or "frappe"
            local colors = require("catppuccin.palettes").get_palette(flavor)
            local sign_bg = vim.api.nvim_get_hl(0, { name = 'SignColumn' }).bg or colors.base

            vim.api.nvim_set_hl(0, 'GitGutterAdd',    { fg = colors.green,  bg = sign_bg })
            vim.api.nvim_set_hl(0, 'GitGutterChange', { fg = colors.yellow, bg = sign_bg })
            vim.api.nvim_set_hl(0, 'GitGutterDelete', { fg = colors.red,    bg = sign_bg })
        end,
    },
    -- Highlight todo, notes, etc in comments
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("neo-tree").setup({
                window = {
                    position = "float",
                    mappings = {
                        ["-"] = "navigate_up",
                        ["D"] = "delete",
                        ["r"] = "rename",
                        ["%"] = "add",     -- new file
                        ["d"] = "add_directory", -- new folder
                    },
                },
                popup_border_style = "rounded",
                sources = { "filesystem", "buffers", "git_status" },
                filesystem = {
                    follow_current_file = { enabled = true },
                    hijack_netrw_behavior = "open_default",
                    use_libuv_file_watcher = true,
                },
            })
        end,
        lazy = false,
    },
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup { n_lines = 500 }
            require('mini.surround').setup()

            local statusline = require('mini.statusline')
            statusline.setup({
                use_icons = vim.g.have_nerd_font,
                set_vim_settings = true,
            })

            statusline.section_fileinfo = function()
                local path = vim.fn.expand('%:p:h') -- get dir of current file
                local parts = vim.split(path, '[\\/]', { plain = false })
                return table.concat(vim.list_slice(parts, math.max(#parts - 2, 1)), '/') .. ' '
            end

            local function filename_with_icon()
                local fname = vim.fn.expand('%:t')
                if fname == '' then fname = '[No Name]' end
                local icon = ''
                local ok, devicons = pcall(require, 'nvim-web-devicons')
                if ok then
                    local ic = devicons.get_icon(fname, nil, { default = true })
                    if ic then icon = ic .. ' ' end
                end
                local modified = vim.bo.modified and ' +' or ''
                return icon .. fname .. modified
            end

            local function clock()
                return os.date(' %H:%M ')
            end

            statusline.active = function()
                local mode   = statusline.section_mode({ trunc_width = 120 })
                local git    = statusline.section_git({ trunc_width = 75 })
                local diags  = statusline.section_diagnostics({ trunc_width = 75 })
                return statusline.combine_groups({
                    { hl = 'MiniStatuslineModeNormal', strings = { mode } },
                    { hl = 'MiniStatuslineDevinfo',    strings = { git, diags } },
                    '%<', -- allow left side to truncate
                    { hl = 'MiniStatuslineFilename',   strings = { filename_with_icon() } },
                    '%=', -- right align from here
                    { hl = 'MiniStatuslineModeNormal', strings = { clock() } },
                })
            end
            local flavor = require("catppuccin").flavour or "frappe"
            local colors = require("catppuccin.palettes").get_palette(flavor)

            vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = colors.base, bg = colors.blue, bold = true })
            vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = colors.base, bg = colors.green, bold = true })
            vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = colors.base, bg = colors.mauve, bold = true })
            vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = colors.base, bg = colors.red, bold = true })
            vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = colors.base, bg = colors.peach, bold = true })

            vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { fg = colors.text, bg = colors.surface0 })
            vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { fg = colors.text, bg = colors.surface1 })
            vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', { fg = colors.overlay0, bg = colors.base })

        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
    },
    { import = 'custom.plugins' },
}, {
        ui = {
            icons = vim.g.have_nerd_font and {} or {
                cmd = '⌘',
                config = '🛠',
                event = '📅',
                ft = '📂',
                init = '⚙',
                keys = '🗝',
                plugin = '🔌',
                runtime = '💻',
                require = '🌙',
                source = '📄',
                start = '🚀',
                task = '📌',
                lazy = '💤 ',
            },
        },
    })
