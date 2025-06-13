-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 14
config.color_scheme = 'AdventureTime'
-- Set font to SauceCodePro Nerd Font
config.font = wezterm.font('SauceCodePro Nerd Font')

config.launch_menu = {}

-- setting the shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'powershell.exe', '-NoLogo' }

    -- Add PowerShell 7 if available
    table.insert(config.launch_menu, {
        label = 'PowerShell 7',
        args = { 'pwsh.exe' },
    })

    -- Add Git Bash if available
    table.insert(config.launch_menu, {
        label = 'Git Bash',
        args = { 'C:\\Program Files\\Git\\bin\\bash.exe', '-i', '-l' },
    })

    -- Add Windows PowerShell
    table.insert(config.launch_menu, {
        label = 'Windows PowerShell',
        args = { 'powershell.exe', '-NoLogo' },
    })    -- Add Command Prompt
    table.insert(config.launch_menu, {
        label = 'Command Prompt',
        args = { 'cmd.exe' },
    })

    -- Scan for installed WSL distributions and add them to the menu
    local success, wsl_list = wezterm.run_child_process { 'wsl', '-l', '-q' }
    if success then
        for line in string.gmatch(wsl_list, '[^\r\n]+') do
            local distro = line:gsub('%s+$', '') -- trim trailing whitespace
            if distro ~= '' then
                table.insert(config.launch_menu, {
                    label = 'WSL: ' .. distro,
                    args = { 'wsl', '-d', distro },
                })
            end
        end
    end
end

config.keys = {
  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },

  -- Tab navigation shortcuts
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },

  -- Direct tab access (1-9)
  { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },

  -- Move tabs
  { key = 'LeftArrow', mods = 'CTRL|ALT', action = wezterm.action.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|ALT', action = wezterm.action.MoveTabRelative(1) },
}

-- Finally, return the configuration to wezterm:
return config
