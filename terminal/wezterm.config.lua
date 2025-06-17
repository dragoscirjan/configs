-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Define OS-based modifier variables
local SUPER, SUPER_REV
if wezterm.target_triple:find("darwin") then
  -- macOS
  SUPER = "SUPER"
  SUPER_REV = "SUPER|CTRL"
else
  -- Windows/Linux
  SUPER = "ALT"
  SUPER_REV = "ALT|CTRL"
end

-- Visuals
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 14
config.color_scheme = "AdventureTime"
config.font = wezterm.font("SauceCodePro Nerd Font")

config.launch_menu = {}

config.keys = {
  -- Tab navigation shortcuts
  { key = "LeftArrow", mods = SUPER_REV, action = wezterm.action.MoveTabRelative(-1) },
  { key = "RightArrow", mods = SUPER_REV, action = wezterm.action.MoveTabRelative(1) },
  -- { key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
  -- { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },

  -- Direct tab access (1-9)
  { key = "1", mods = SUPER, action = wezterm.action.ActivateTab(0) },
  { key = "2", mods = SUPER, action = wezterm.action.ActivateTab(1) },
  { key = "3", mods = SUPER, action = wezterm.action.ActivateTab(2) },
  { key = "4", mods = SUPER, action = wezterm.action.ActivateTab(3) },
  { key = "5", mods = SUPER, action = wezterm.action.ActivateTab(4) },
  { key = "6", mods = SUPER, action = wezterm.action.ActivateTab(5) },
  { key = "7", mods = SUPER, action = wezterm.action.ActivateTab(6) },
  { key = "8", mods = SUPER, action = wezterm.action.ActivateTab(7) },
  { key = "9", mods = SUPER, action = wezterm.action.ActivateTab(8) },
  -- Move tabs

  -- Tab spawning shortcuts
  { key = "t", mods = SUPER, action = wezterm.action.SpawnTab("CurrentPaneDomain") },

  --   -- Enter tab spawning mode
  --   { key = 't', mods = SUPER_REV, action = wezterm.action.ActivateKeyTable {
  --     name = 'tab_spawn_mode',
  --     one_shot = true,
  --   }},

  -- Windows spawning shortcuts
  { key = "n", mods = SUPER, action = wezterm.action.SpawnWindow },

  -- Split panes
  { key = "d", mods = SUPER, action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = SUPER .. "|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  -- Pane navigation
  { key = "LeftArrow", mods = SUPER_REV, action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "DownArrow", mods = SUPER_REV, action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "UpArrow", mods = SUPER_REV, action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "RightArrow", mods = SUPER_REV, action = wezterm.action.ActivatePaneDirection("Right") },

  { key = "l", mods = SUPER, action = wezterm.action.ShowLauncher },
}

-- -- Key table for tab spawning mode
-- config.key_tables = {
--   tab_spawn_mode = {
--     { key = 'u', action = wezterm.action.SpawnCommandInNewTab {
--       label = 'Ubuntu WSL',
--       args = { 'wsl', '-d', 'Ubuntu' },
--     }},
--     { key = 'a', action = wezterm.action.SpawnCommandInNewTab {
--       label = 'Alpine WSL',
--       args = { 'wsl', '-d', 'Alpine' },
--     }},
--     { key = 'n', action = wezterm.action.SpawnCommandInNewTab {
--       label = 'NixOS WSL',
--       args = { 'wsl', '-d', 'NixOS' },
--     }},
--     { key = 'Escape', action = 'PopKeyTable' },
--   },
-- }

-- setting the shell
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "powershell.exe", "-NoLogo" }

  -- Add PowerShell 7 if available
  table.insert(config.launch_menu, {
    label = "PowerShell 7",
    args = { "pwsh.exe" },
  })

  -- Add Git Bash if available
  table.insert(config.launch_menu, {
    label = "Git Bash",
    args = { "C:\\Program Files\\Git\\bin\\bash.exe", "-i", "-l" },
  })

  -- Add Windows PowerShell
  table.insert(config.launch_menu, {
    label = "Windows PowerShell",
    args = { "powershell.exe", "-NoLogo" },
  }) -- Add Command Prompt
  table.insert(config.launch_menu, {
    label = "Command Prompt",
    args = { "cmd.exe" },
  })

  -- Scan for installed WSL distributions and add them to the menu
  local success, wsl_list = wezterm.run_child_process({ "wsl", "-l", "-q" })
  if success then
    for line in string.gmatch(wsl_list, "[^\r\n]+") do
      local distro = line:gsub("%s+$", "") -- trim trailing whitespace
      if distro ~= "" then
        table.insert(config.launch_menu, {
          label = "WSL: " .. distro,
          args = { "wsl", "-d", distro },
        })
      end
    end
  end
end

-- Finally, return the configuration to wezterm:
return config
