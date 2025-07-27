-- python config

return {
  python = {
    venv_selector = {
      enabled = true,
      auto_detect = true,
      search_paths = { ".venv", "venv" },
    },
  },
}
