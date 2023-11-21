local M = {};
-- Define a function to print quickfix items to a buffer
M.print_quickfix_to_buffer = function()
-- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Set the buffer name and set it as the current buffer
    vim.api.nvim_buf_set_name(buf, 'Quickfix List')
    vim.api.nvim_set_current_buf(buf)

    -- Clear any existing buffer contents
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

    -- Get the quickfix list
    local quickfix_list = vim.fn.getqflist()

    -- Iterate through quickfix list items and append them to the buffer
    for _, item in ipairs(quickfix_list) do
        local text = item.text or ""
        local filename = item.filename or ""
        local lnum = item.lnum or ""
        local col = item.col or ""
        local location = string.format("%s:%s:%s", filename, lnum, col)
        local header = string.format("%s [%s]", text, location)

        vim.api.nvim_buf_set_lines(buf, -1, -1, false, {header})
    end
end

-- Map a key to call the function
vim.keymap.set('n', '<Leader>qq', M.print_quickfix_to_buffer, { noremap = true, silent = true })

return M;
