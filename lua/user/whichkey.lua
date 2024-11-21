local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  -- key_labels = {
  -- 	-- override the label used to display some keys. It doesn't effect WK in any other way.
  -- 	-- For example:
  -- 	-- ["<space>"] = "SPC",
  -- 	-- ["<CR>"] = "RET",
  -- 	-- ["<tab>"] = "TAB",
  -- },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+ ", -- symbol prepended to a group
  },
  -- popup_mappings = {
  -- 	scroll_down = "<c-d>", -- binding to scroll down inside the popup
  -- 	scroll_up = "<c-u>", -- binding to scroll up inside the popup
  -- },
  -- window = {
  -- 	border = "rounded", -- none, single, double, shadow
  -- 	position = "bottom", -- bottom, top
  -- 	margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
  -- 	padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  -- 	winblend = 0,
  -- },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  -- hidden = { "<silent>", ":", "<CMD>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  -- triggers_blacklist = {
  -- 	-- list of mode / prefixes that should never be hooked by WhichKey
  -- 	-- this is mostly relevant for key maps that start with a native binding
  -- 	-- most people should not need to change this
  -- 	i = { "j", "k" },
  -- 	v = { "j", "k" },
  -- },
}

local opts = {
  mode = { "n", "v", "x" },
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { ":Alpha<CR>", "Alpha" },
  ["e"] = { ":NvimTreeToggle<CR>", "Explorer" },
  ["q"] = { ":q!<CR>", "Quit" },
  ["h"] = { ":nohlsearch<CR>", "No Highlight" },

  b = {
    "Buffer",
    b = {
      ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
      "Buffers",
    },
    c = { ":Bdelete!<CR>", "Close Buffer" },
    C = { ":%bd <bar> e# <bar> bd#<CR>", "Close All Buffer" },
  },

  -- DAP
  d = {
    name = "DAP",
    b = { ":lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
    c = { ":lua require'dap'.continue()<CR>", "Continue" },
    i = { ":lua require'dap'.step_into()<CR>", "Step into" },
    o = { ":lua require'dap'.step_over()<CR>", "Step over" },
    O = { ":lua require'dap'.step_out()<CR>", "Step out" },
    r = { ":lua require'dap'.repl.toggle()<CR>", "REPL toggle" },
    l = { ":lua require'dap'.run_last()<CR>", "Run last" },
    u = { ":lua require'dapui'.toggle()<CR>", "UI toggle" },
    t = { ":lua require'dap'.terminate()<CR>", "Terminate" },
  },

  -- For Telescope
  -- live_grep requires ripgrep
  f = {
    name = "Telescope",
    f = { ":Telescope find_files<CR>", "Find Files" },
    t = { ":Telescope live_grep theme=ivy<CR>", "Find Text" },
    g = { ":Telescope live_grep<CR>", "Grep" },
    G = { ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Grep Args" },
    b = { ":Telescope buffers<CR>", "Lists open buffers" },
    h = { ":Telescope help_tags<CR>", "Lists available help tags" },
    P = { ":Telescope projects<CR>", "Projects" },
    s = { ":Telescope grep_string<CR>", "Grep String" },
    E = { ":Telescope emoji<CR>", "Emoji Search" },
    e = { ":Telescope file_browser<CR>", "File Browser" },
  },

  -- ["f"] = {
  --   ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
  --   "Find files",
  -- },

  F = { ":Telescope live_grep theme=ivy<CR>", "Find Text" },

  p = {
    name = "Packer",
    c = { ":PackerCompile<CR>", "Compile" },
    i = { ":PackerInstall<CR>", "Install" },
    s = { ":PackerSync<CR>", "Sync" },
    S = { ":PackerStatus<CR>", "Status" },
    u = { ":PackerUpdate<CR>", "Update" },
  },

  g = {
    name = "Git",
    g = { ":lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { ":lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
    k = { ":lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
    l = { ":lua require 'gitsigns'.blame_line()<CR>", "Blame" },
    p = { ":lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
    r = { ":lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { ":lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    s = { ":lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    u = {
      ":lua require 'gitsigns'.undo_stage_hunk()<CR>",
      "Undo Stage Hunk",
    },
    o = { ":Telescope git_status<CR>", "Open changed file" },
    b = { ":Telescope git_branches<CR>", "Checkout branch" },
    c = { ":Telescope git_commits<CR>", "Checkout commit" },
    d = {
      ":Gitsigns diffthis HEAD<CR>",
      "Diff",
    },
  },

  i = {
    name = "IconPick",
    n = { ":IconPickerNormal<CR>", "Pick and insert icon to the buffer (normal)" },
    i = { ":IconPickerInsert<CR>", "Pick and insert icon to the buffer (insert)" },
    y = { ":IconPickerYank<CR>", "Pick and yank icon to register" },
  },

  l = {
    name = "LSP",
    a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = {
      ":Telescope lsp_document_diagnostics<CR>",
      "Document Diagnostics",
    },
    w = {
      ":Telescope lsp_workspace_diagnostics<CR>",
      "Workspace Diagnostics",
    },
    f = { ":lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
    i = { ":LspInfo<CR>", "Info" },
    I = { ":LspInstallInfo<CR>", "Installer Info" },
    j = {
      ":lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      ":lua vim.lsp.diagnostic.goto_prev()<CR>",
      "Prev Diagnostic",
    },
    l = { ":lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    q = { ":lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
    r = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
    s = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = {
      ":Telescope lsp_dynamic_workspace_symbols<CR>",
      "Workspace Symbols",
    },
  },

  m = {
    name = "Markdown",
    p = { ":MarkdownPreview<CR>", "Preview Markdown" },
    s = { ":MarkdownPreviewStop<CR>", "Stop Markdown Preview" },
    t = { ":MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
    f = { ":Glow %<CR>", "Glow Preview File" },
    b = { ":Glow<CR>", "Glow Preview Current Buffer" },
  },

  r = {
    name = "Repl",
    o = { ":IronRepl<CR>", "Start a repl" },
    r = { ":IronRestart<CR>", "Restart the current repl" },
    f = { ":IronFocus<CR>", "Focus on the repl" },
    h = { ":IronHide<CR>", "Hide the repl window" },
    w = { ":IronWatch<CR>", "Send to repl after writing" },
    s = {
      name = "Send",
      e = { ":lua require('iron.core').send(nil, string.char(13))<CR>", "Carriage Return" },
      i = { ":lua require('iron.core').send(nil, string.char(03))<CR>", "Interrupt" },
      q = { ":lua require('iron.core').close_repl()<CR>", "Quit" },
      c = { ":lua require('iron.core').send(nil, string.char(12))<CR>", "Clear" },
      M = { ":lua require('iron.core').send_motion()<CR>", "Send motion" },
      v = { ":lua require('iron.core').visual_send()<CR>", "Send visual" },
      f = { ":lua require('iron.core').send_file()<CR>", "Send file" },
      l = { ":lua require('iron.core').send_line()<CR>", "Send line" },
      m = { ":lua require('iron.core').send_mark()<CR>", "Send mark" },
    },
    m = {
      name = "Mark",
      m = { ":lua require('iron.core').mark_motion()<CR>", "Mark motion" },
      v = { ":lua require('iron.core').mark_visual()<CR>", "Mark visual" },
      d = { ":lua require('iron.marks').drop_last()<CR>", "Mark drop" },
    },
  },

  -- R = {
  --   name = "Run",
  --   p = { "::w<CR>:exec '!python3' shellescape(@%, 1)<CR>", "Python" },
  --   l = { "::w<CR>:exec '!lua' shellescape(@%, 1)<CR>", "Lua" },
  --   r = { "::w<CR>:exec '!run' shellescape(@%, 1)<CR>", "Run Buffer" },
  -- },
  --

  R = { "::w<CR>:exec '!run' shellescape(@%, 1)<CR>", "Run Buffer" },

  s = {
    name = "Search",
    b = { ":Telescope git_branches<CR>", "Checkout branch" },
    c = { ":Telescope colorscheme<CR>", "Colorscheme" },
    h = { ":Telescope help_tags<CR>", "Find Help" },
    M = { ":Telescope man_pages<CR>", "Man Pages" },
    r = { ":Telescope oldfiles<CR>", "Open Recent File" },
    R = { ":Telescope registers<CR>", "Registers" },
    k = { ":Telescope keymaps<CR>", "Keymaps" },
    C = { ":Telescope commands<CR>", "Commands" },
  },

  t = {
    name = "Terminal",
    g = { ":lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    n = { ":lua _NODE_TOGGLE()<CR>", "Node" },
    u = { ":lua _NCDU_TOGGLE()<CR>", "NCDU" },
    t = { ":lua _HTOP_TOGGLE()<CR>", "Htop" },
    p = { ":lua _PYTHON_TOGGLE()<CR>", "Python" },
    i = { ":lua _IPYTHON_TOGGLE()<CR>", "IPython" },
    f = { ":ToggleTerm direction=float<CR>", "Float" },
    h = { ":ToggleTerm direction=horizontal<CR>", "Horizontal" },
    v = { ":ToggleTerm direction=vertical<CR>", "Vertical" },
    a = { ":ToggleTermToggleAll<CR>", "Toggle all terminal" },
    s = {
      name = "Send/Set",
      n = { ":ToggleTermSetName<CR>", "Set terminal name" },
      l = { ":ToggleTermSendCurrentLine 7<CR>", "Send current line to ipython" },
      v = { ":ToggleTermSendVisualLines 7<CR>", "Send visual lines to ipython" },
      b = { ":ToggleTermSendVisualSelection 7<CR>", "Send visually selected block to ipython" },
    },
  },

  w = {
    name = "Window",
    s = { ":sp<CR>", "Split Horizontally" },
    v = { ":vs<CR>", "Split Vertically" },
    l = { ":windo set invrelativenumber<CR>", "Toggle relative number" },
  },

  -- ydict
  y = {
    name = "ydict",
    c = { ":Ydc<CR>", "Query words from cursor." },
    v = { ":Ydv<CR>", "Query words from selected." },
    d = { ":Yde<CR>", "Query words from input." },
  },
}

which_key.setup(setup) ---@diagnostic disable-line: redundant-parameter
which_key.register(mappings, opts)
