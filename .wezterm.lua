local wezterm = require("wezterm")

local function file_exists(path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local config = {
  audible_bell = "Disabled",
  check_for_updates = false,
  color_scheme = "Hipster Green",
  inactive_pane_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
  },
  font_size = 12.0,
  launch_menu = {},
  -- Leader を Ctrl+g
  leader = { key = "g", mods = "CTRL" },
  disable_default_key_bindings = true,

  keys = {
    -- tmux: <Prefix>+r で設定再読み込み
    { key = "r", mods = "LEADER", action = wezterm.action.ReloadConfiguration },

    -- tmux: <Prefix>+[ でコピーモード
    { key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
    -- tmux: <Prefix>+] で貼り付け
    { key = "]", mods = "LEADER",  action = wezterm.action.PasteFrom("Clipboard") },

    -- 既存
    { key = "a", mods = "LEADER|CTRL", action = wezterm.action { SendString = "\x01" } },

    -- 分割: v=縦(左右), s=横(上下)
    { key = "v", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },   -- 左右
    { key = "s", mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } }, -- 上下

    -- ペイン移動
    { key = "h", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Left" } },
    { key = "j", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Down" } },
    { key = "k", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Up" } },
    { key = "l", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Right" } },

    -- tmux: <Prefix>+Ctrl-h/j/k/l でペインサイズ変更（10）
    { key = "h", mods = "LEADER|CTRL", action = wezterm.action { AdjustPaneSize = { "Left", 10 } } },
    { key = "j", mods = "LEADER|CTRL", action = wezterm.action { AdjustPaneSize = { "Down", 10 } } },
    { key = "k", mods = "LEADER|CTRL", action = wezterm.action { AdjustPaneSize = { "Up", 10 } } },
    { key = "l", mods = "LEADER|CTRL", action = wezterm.action { AdjustPaneSize = { "Right", 10 } } },

    -- 既存のサイズ変更 (Shift+H/J/K/L, 各5)
    { key = "H", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
    { key = "J", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
    { key = "K", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
    { key = "L", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },

    -- タブ関連
    { key = "c", mods = "LEADER", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    { key = "n", mods = "LEADER", action = wezterm.action { ActivateTabRelative = 1 } },
    { key = "p", mods = "LEADER", action = wezterm.action { ActivateTabRelative = -1 } },
    { key = "1", mods = "LEADER", action = wezterm.action { ActivateTab = 0 } },
    { key = "2", mods = "LEADER", action = wezterm.action { ActivateTab = 1 } },
    { key = "3", mods = "LEADER", action = wezterm.action { ActivateTab = 2 } },
    { key = "4", mods = "LEADER", action = wezterm.action { ActivateTab = 3 } },
    { key = "5", mods = "LEADER", action = wezterm.action { ActivateTab = 4 } },
    { key = "6", mods = "LEADER", action = wezterm.action { ActivateTab = 5 } },
    { key = "7", mods = "LEADER", action = wezterm.action { ActivateTab = 6 } },
    { key = "8", mods = "LEADER", action = wezterm.action { ActivateTab = 7 } },
    { key = "9", mods = "LEADER", action = wezterm.action { ActivateTab = 8 } },

    { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
    { key = "&", mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
    { key = "x", mods = "LEADER", action = wezterm.action { CloseCurrentPane = { confirm = true } } },

    -- システム系
    { key = "n", mods = "SHIFT|CTRL", action = "ToggleFullScreen" },
    { key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "c", mods = "SHIFT|CTRL", action = wezterm.action.CopyTo("Clipboard") },
    { key = "+", mods = "SHIFT|CTRL", action = "IncreaseFontSize" },
    { key = "-", mods = "SHIFT|CTRL", action = "DecreaseFontSize" },
    { key = "0", mods = "SHIFT|CTRL", action = "ResetFontSize" },

  },

  set_environment_variables = {},
}

-- OSごとの分岐
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  -- Windows: PowerShell 既定
  config.default_prog = { "powershell.exe", "-NoLogo", "-NoExit" }

  if string.match(wezterm.hostname(), "^C") then
    config.prefer_egl = true
  end

  table.insert(config.launch_menu, {
    label = "Windows PowerShell",
    args = { "powershell.exe", "-NoLogo", "-NoExit" },
  })

  local pwsh_stable = "C:/Program Files/PowerShell/7/pwsh.exe"
  local pwsh_preview = "C:/Program Files/PowerShell/7-preview/pwsh.exe"
  if file_exists(pwsh_stable) then
    table.insert(config.launch_menu, {
      label = "PowerShell 7",
      args = { pwsh_stable, "-NoLogo", "-NoExit" },
    })
  elseif file_exists(pwsh_preview) then
    table.insert(config.launch_menu, {
      label = "PowerShell 7 (Preview)",
      args = { pwsh_preview, "-NoLogo", "-NoExit" },
    })
  end

  for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
    local year = vsvers:gsub("Microsoft Visual Studio/", "")
    table.insert(config.launch_menu, {
      label = "x64 Native Tools VS " .. year,
      args = {
        "cmd.exe",
        "/k",
        "C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat",
      },
    })
  end

else
  -- macOS / Linux: zsh 既定
  config.default_prog = { "/bin/zsh", "-l" }

  -- Launch Menu に fish / bash / zsh を追加
  if file_exists("/opt/homebrew/bin/fish") then
    table.insert(config.launch_menu, {
      label = "fish",
      args = { "/opt/homebrew/bin/fish", "-l" },
    })
  elseif file_exists("/usr/local/bin/fish") then
    table.insert(config.launch_menu, {
      label = "fish",
      args = { "/usr/local/bin/fish", "-l" },
    })
  end
  table.insert(config.launch_menu, { label = "bash", args = { "/bin/bash", "-l" } })
  table.insert(config.launch_menu, { label = "zsh", args = { "/bin/zsh", "-l" } })
end

return config
