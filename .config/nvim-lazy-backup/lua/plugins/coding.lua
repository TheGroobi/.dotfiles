return {
    "smjonas/inc-rename.nvim",
    config = function()
        require("inc_rename").setup({
            prefix = "New Name: ",
            empty_input_behavior = "auto",
        })
    end,
}
