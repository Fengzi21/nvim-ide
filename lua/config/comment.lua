local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

-- Use nvim-ts-context-commentstring for context-aware comments (f-strings,
-- embedded languages, ...). Its pre_hook returns nil when it can't determine
-- the context (empty line, no treesitter node) — we must never return nil
-- here, because a nil pre_hook makes Comment.nvim fall back to its own
-- treesitter walker (Comment/ft.lua `ft.calculate`), which crashes on some
-- filetypes (e.g. Python) with "attempt to index local 'tree' (a nil value)"
-- on Neovim 0.12+.
local context_pre_hook
local ok_ts_ctx, ts_ctx = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if ok_ts_ctx then
  context_pre_hook = ts_ctx.create_pre_hook()
end

comment.setup({
  pre_hook = function(ctx)
    if context_pre_hook then
      local ok, cstr = pcall(context_pre_hook, ctx)
      if ok and cstr then
        return cstr
      end
    end
    return vim.bo.commentstring
  end,
})
