local status_ok, minuetai = pcall(require, "minuet")
if not status_ok then
  return
end

minuetai.setup({
  provider = "openai_fim_compatible",
  provider_options = {
    openai_fim_compatible = {
      api_key = "DEEPSEEK_API_KEY",
      name = "deepseek",
      optional = {
        max_tokens = 256,
        top_p = 0.9,
      },
    },
  },
})
