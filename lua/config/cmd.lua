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

-- 运行当前行并插到下一行
local function run_current_line(cmd)
  local line = vim.api.nvim_get_current_line()
  local output = vim.fn.system(cmd, line)
  local output_lines = vim.split(output, "\n", { plain = true, trimempty = true })
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, output_lines)
end

-- 运行当前行作为 Shell 命令
local function run_shell()
  run_current_line("bash")
end

-- 运行当前行作为 Python 代码
local function run_python()
  local line = vim.api.nvim_get_current_line()
  local output = vim.fn.system({ "python", "-c", line })
  local output_lines = vim.split(output, "\n", { plain = true, trimempty = true })
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, output_lines)
end

local function create_scratch_buffer(cmd)
  vim.cmd(cmd)
  vim.cmd("file *scratch*")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false
end

local function scratch_buffer()
  create_scratch_buffer("enew")
end

local function horizontal_scratch_buffer()
  create_scratch_buffer("new")
end

local function vertical_scratch_buffer()
  create_scratch_buffer("vnew")
end

-- Helper to wrap word under cursor
local function wrap_word(wrapper)
  local word = vim.fn.expand("<cword>") -- word under cursor
  local replacement = wrapper .. word .. wrapper
  vim.cmd("normal! ciw" .. replacement) -- change inner word
end

-- Create the command
vim.api.nvim_create_user_command("MarkdownBold", function()
  wrap_word("**")
end, {})
vim.api.nvim_create_user_command("MarkdownItalic", function()
  wrap_word("*")
end, {})
vim.api.nvim_create_user_command("MarkdownStroke", function()
  wrap_word("~~")
end, {})
vim.api.nvim_create_user_command("MarkdownCode", function()
  wrap_word("`")
end, {})

local function warp_by_tag(tag)
  local word = vim.fn.expand("<cword>") -- word under cursor
  local replacement = "<" .. tag .. ">" .. word .. "</" .. tag .. ">"
  vim.cmd("normal! ciw" .. replacement) -- change inner word
end

vim.api.nvim_create_user_command("HtmlWrapA", function()
  warp_by_tag("a")
end, {})
vim.api.nvim_create_user_command("HtmlWrapU", function()
  warp_by_tag("u")
end, {})

-- Function to wrap word under cursor as a markdown link
local function add_link()
  local word = vim.fn.expand("<cword>") -- get word under cursor
  local replacement = "[" .. word .. "]()" -- add link template
  vim.cmd("normal! ciw" .. replacement) -- replace the word
end

-- Create the command
vim.api.nvim_create_user_command("MarkdownLink", function()
  add_link()
end, {})

vim.api.nvim_create_user_command("SwapVar", SwapWordPartsUnderCursor, {})
vim.api.nvim_create_user_command("RunAsBash", run_shell, {})
vim.api.nvim_create_user_command("RunAsPython", run_python, {})
vim.api.nvim_create_user_command("Scratch", scratch_buffer, {})
vim.api.nvim_create_user_command("VScratch", vertical_scratch_buffer, {})
vim.api.nvim_create_user_command("HScratch", horizontal_scratch_buffer, {})

local function open_file_in_app(app)
  local file = vim.fn.expand("%:p")

  if file == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.ERROR)
    return
  end

  vim.fn.jobstart({ "open", "-a", app, file }, {
    detach = true,
    on_stderr = function(_, data)
      if data and #data > 0 then
        vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
      end
    end,
  })
end

vim.api.nvim_create_user_command("OpenInEdge", function()
  open_file_in_app("/Applications/Microsoft Edge.app")
end, {
  desc = "Open current buffer file in Microsoft Edge",
})

vim.api.nvim_create_user_command("OpenInUPDF", function()
  open_file_in_app("/Applications/UPDF.app")
end, {
  desc = "Open current buffer file in UPDF",
})
