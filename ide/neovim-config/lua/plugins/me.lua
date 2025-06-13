-- my own config

return {
  -- lua lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
        },
      },
    },
  },
  -- configure copilot
  { "github/copilot.vim" },
}
