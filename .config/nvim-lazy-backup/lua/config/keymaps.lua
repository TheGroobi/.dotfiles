vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })
vim.keymap.set('v', '<C-s>', '<Esc>:w<CR>gv', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":Ex<Enter>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rn", ":IncRename ")
vim.keymap.set("n", '<leader>ws', ":noautocmd write")

-- golang error handler keymap
vim.keymap.set("n", "<leader>ee", "oif err != nil {<Enter>return err<Esc>o}<Esc>")

vim.keymap.set("n", "<leader>!",
    [[i<!DOCTYPE html><Enter><html lang="en"><Enter><head><Enter><meta charset="UTF-8"><Enter><meta name="viewport" content="width=device-width, initial-scale=1.0"><Enter><meta http-equiv="X-UA-Compatible" content="ie=edge"><Enter><title>App Title</title><Enter><link rel="stylesheet" href="style.css"><Enter><script defer src="script.js"></script><Enter></head><Enter><body><Enter><Enter><Enter></body><Enter></html><Esc>kkk]])
vim.keymap.set("n", "<alt>/", "^i//<Esc>")
