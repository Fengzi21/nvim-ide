---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or _G.unpack

function SwapWordPartsUnderCursor()
  -- 获取当前行和光标位置
  local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- 扫描整行，找出所有 \w+_\w+ 的变量，以及它们的位置
  for start_pos, word, end_pos in line:gmatch("()(%w+_%w+)()") do
    if col + 1 >= start_pos and col + 1 <= end_pos then
      -- 找到光标所在的变量名，进行拆分
      local a, b = word:match("^(%w+)%_(%w+)$")
      if a and b then
        local swapped = b .. "_" .. a
        local new_line = line:sub(1, start_pos - 1) .. swapped .. line:sub(end_pos)
        vim.api.nvim_set_current_line(new_line)
        -- 设置光标位置到新变量起始位置
        vim.api.nvim_win_set_cursor(0, { row, start_pos - 1 })
      end
      return
    end
  end

  -- 如果没有匹配，提示用户
  vim.notify("No swap-able variable under cursor (like a_b)", vim.log.levels.WARN)
end

vim.api.nvim_create_user_command("SwapVar", SwapWordPartsUnderCursor, {})
