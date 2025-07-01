-- List of folders to exclude from search
local exclude_dirs = { "node_modules", "deno_modules" }

-- Build fd_opts with excludes
local fd_opts = { "--no-ignore", "--type", "f", "--hidden", "--follow" }
for _, dir in ipairs(exclude_dirs) do
  table.insert(fd_opts, "--exclude")
  table.insert(fd_opts, dir)
end

return {
  "ibhagwan/fzf-lua",
  opts = {
    files = {
      -- Show files ignored by .gitignore, include hidden files, follow symlinks, and ignore excluded dirs
      fd_opts = fd_opts,
    },
  },
}
