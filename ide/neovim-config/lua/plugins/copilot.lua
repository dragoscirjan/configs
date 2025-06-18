-- my own config

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    -- build = "make tiktoken", -- Only on MacOS or Linux
    -- @see https://github.com/neovim/neovim/issues/25019
    build = vim.fn.has("win32") == 1
        and "pwsh -ExecutionPolicy Bypass -File " .. vim.fs.normalize(vim.fn.stdpath("config") .. "/Build-LuaTiktoken.ps1")
      or "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}

-- return {
--   -- lua lsp
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         lua_ls = {
--           mason = false,
--         },
--       },
--     },
--   },
--   -- configure copilot
--   { "github/copilot.vim" },
-- }
