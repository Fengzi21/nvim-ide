-- 宏 b: 加粗 latex 文本
vim.fn.setreg("b", "xi\\textbf{\027pa}\027")

-- 宏 h: 自定义命令高亮 latex 文本
vim.fn.setreg("h", "xi\\highlight{\027pa}\027")
