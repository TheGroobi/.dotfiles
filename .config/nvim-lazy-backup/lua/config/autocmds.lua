local function delete_shada_temp()
    vim.notify("Deleting shada files in the function")
    local shada_dir = vim.fn.stdpath('data') .. '/shada/'
    local files = vim.fn.glob(shada_dir .. "main.shada.tmp.*", true, true)

    return files
end

local function log_message(message)
    local log_file_path = vim.fn.stdpath('cache') .. '/vim_notifications.log'

    local log_file = io.open(log_file_path, "a")
    if log_file then
        log_file:write(message .. "\n")
        log_file:close()
    else
        print("Error: Could not open log file.")
    end
end

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        delete_shada_temp()
    end
})
