-- 宏 b: \textbf 加粗 latex 文本
vim.fn.setreg("b", "xi\\textbf{\027pa}\027")

-- 宏 m: \bm 加粗 latex 公式
vim.fn.setreg("m", "xi\\bm{\027pa}\027")

-- 宏 h: \highlight 高亮 latex 文本
-- latex 自定义蓝色高亮: \newcommand{\highlight}[1]{\textcolor{blue}{#1}}
vim.fn.setreg("h", "xi\\highlight{\027pa}\027")

-- 宏 i: turn selected to inline math
vim.fn.setreg("i", "xi\\(\027pa\\)\027")

-- 宏 d: turn selected to display math
vim.fn.setreg("d", "xi\\[\027pa\\]\027")

-- swap parts seperated by underscore _
vim.fn.setreg("s", ":%s/\\(\\w\\+\\)_\\(\\w\\+\\)/\\2_\\1/g\r")
