-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.editor")
require("catppuccin").setup({
    flavour = "frappe",
    transparent_background = true,
    styles = {
        keywords = { "bold" },
    },
    no_italic = true,
    no_bold = true,
})
vim.cmd.colorscheme "catppuccin"
vim.opt.wildignore:append({ "node_modeles/*, .git/*" })
