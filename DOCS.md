# KazGui Documentation

KazGui is a Roblox Luau GUI library for executor environments. It provides a compact window layout, theme support, Lucide icons, saved component state, searchable dropdowns, multi-select dropdowns, notifications, dialogs, draggable windows, image-only open buttons, and resize support.

## Loader

Use the raw loader:

```lua
local KazGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/KazGuiLibrary/main/dist/KazGui.min.lua"))()
```

For cache-safe testing, use a commit URL:

```lua
local KazGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/KazGuiLibrary/<commit>/dist/KazGui.min.lua"))()
```

## Quick Start

```lua
local KazGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/KazGuiLibrary/main/dist/KazGui.min.lua"))()

local Window = KazGui:CreateWindow({
	Title = "KazHub",
	Author = "v1.0",
	Icon = "layout-dashboard",
	OpenButtonIcon = "sparkles",
	Theme = "Midnight",
	Size = UDim2.fromOffset(620, 390),
	MinSize = Vector2.new(460, 300),
	ToggleKey = Enum.KeyCode.RightShift,
	AutoSave = true,
	FileSaveName = "KazHub.json",
})

local Main = Window:Tab({
	Title = "Main",
	Icon = "house",
})

local Combat = Main:Section({
	Title = "Combat",
	Default = true,
})

Combat:Toggle({
	Title = "Auto Farm",
	Desc = "Saved automatically.",
	Default = false,
	Callback = function(value)
		print(value)
	end,
})
```

## Window

### `KazGui:CreateWindow(data)`

Creates a window and returns a `Window` object.

```lua
local Window = KazGui:CreateWindow({
	Title = "KazHub",
	Author = "v1.0",
	Icon = "layout-dashboard",
	OpenButtonIcon = "sparkles",
	Theme = "Midnight",
	Size = UDim2.fromOffset(620, 390),
	MinSize = Vector2.new(460, 300),
	ToggleKey = Enum.KeyCode.RightShift,
	AutoSave = true,
	FileSaveName = "KazHub.json",
})
```

Fields:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"KazGui"` | Window title. Long titles truncate safely. |
| `Author` / `Version` | `string` | `"v1.0"` | Text shown on the right side of the topbar. |
| `Icon` | `string` / asset id | `"layout"` | Window icon. Supports Lucide names and Roblox asset ids. |
| `OpenButtonIcon` / `OpenIcon` | `string` / asset id | `Icon` | Image-only open button icon shown when window is hidden. |
| `Theme` | `string` / table | `"Midnight"` | Initial theme. |
| `Size` | `UDim2` | `UDim2.fromOffset(620, 390)` | Initial window size. |
| `MinSize` | `Vector2` | `Vector2.new(460, 300)` | Minimum resize size. |
| `ToggleKey` | `Enum.KeyCode` | `RightShift` | Keyboard key to hide/open the window. |
| `AutoSave` | `boolean` | `true` | Saves supported component values using executor file APIs. |
| `FileSaveName` | `string` | `"<Title>.json"` | Config file path/name. |
| `OnOpen` | `function` | `nil` | Optional callback fired when the window opens. |
| `OnClose` | `function` | `nil` | Optional callback fired when the window hides or is destroyed while visible. |
| `OnDestroy` | `function` | `nil` | Optional callback fired before the window GUI is destroyed. |

### Window Methods

```lua
Window:Toggle()              -- toggles visibility
Window:Toggle(true)          -- shows window
Window:Toggle(false)         -- hides window and shows open button
Window:Open()
Window:Close()
Window:Destroy()
Window:OnOpen(function(window) end)
Window:OnClose(function(window) end)
Window:OnDestroy(function(window) end)
Window:SetToggleKey(Enum.KeyCode.RightControl)
Window:SetTheme("Emerald")
Window:SelectTab(2)
Window:Divider()
Window:Dialog({...})
Window:Notify({...})
```

## Tabs

Tabs appear in the left sidebar.

```lua
local Player = Window:Tab({
	Title = "Player",
	Icon = "user-round",
})
```

Fields:

| Field | Type | Description |
| --- | --- | --- |
| `Title` | `string` | Tab label. |
| `Icon` | `string` / asset id | Lucide icon name or asset id. |

## Sections

Sections group components and can collapse/expand.

```lua
local Movement = Player:Section({
	Title = "Movement",
	Icon = "footprints",
	Default = true,
	WithBackground = true,
})

Movement:Close()
Movement:Open()
Movement:SetState(false)
Movement:SetTitle("New Title")
```

Components can be added directly to a tab or to a section:

```lua
Player:Button({...})
Movement:Slider({...})
```

Sections render as framed background groups with a Lucide icon before the title by default. Set `WithBackground = false` for a plain section header without the section card background.

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Section"` | Section header text. |
| `Icon` | `string` / asset id | `"folder"` | Header icon before the title. |
| `Default` | `boolean` | `true` | Initial expanded/collapsed state. |
| `WithBackground` | `boolean` | `true` | Enables section background, stroke, and inner padding. |

## Components

### Button

```lua
local Button = Main:Button({
	Title = "Run Feature",
	Desc = "Execute selected action.",
	Icon = "zap",
	Locked = false,
	Callback = function()
		print("clicked")
	end,
})
```

Methods:

```lua
Button:SetTitle("New Title")
Button:SetDesc("New description")
Button:Lock()
Button:Unlock()
Button:Destroy()
```

### Label

Labels add static text to a tab or section.

```lua
local Label = Main:Label({
	Title = "Dashboard",
	Desc = "Optional supporting text.",
	Icon = "info",
})
```

Methods:

```lua
Label:SetTitle("New title")
Label:SetDesc("New description")
Label:SetIcon("circle-check")
Label:Destroy()
```

### Divider

Dividers add a thin themed separator line.

```lua
local Divider = Main:Divider()

Main:Divider({
	Spacing = 18,
})
```

Methods:

```lua
Divider:Destroy()
```

### Toggle

```lua
local Toggle = Main:Toggle({
	Title = "Auto Farm",
	Desc = "Saved when AutoSave is enabled.",
	Default = false,
	Callback = function(value)
		print(value)
	end,
})
```

Methods:

```lua
Toggle:Set(true)
Toggle:Lock()
Toggle:Unlock()
Toggle:Destroy()
```

### Slider

```lua
local Slider = Main:Slider({
	Title = "WalkSpeed",
	Desc = "Example slider.",
	Value = {
		Min = 16,
		Max = 100,
		Default = 16,
	},
	Step = 1,
	Callback = function(value)
		print(value)
	end,
})
```

Methods:

```lua
Slider:Set(32)
Slider:Lock()
Slider:Unlock()
Slider:Destroy()
```

### Input

```lua
local Input = Main:Input({
	Title = "Webhook",
	Desc = "Text input.",
	Placeholder = "https://...",
	Default = "",
	ClearTextOnFocus = false,
	Callback = function(text)
		print(text)
	end,
})
```

Methods:

```lua
Input:Set("new text")
Input:SetPlaceholder("placeholder")
Input:Lock()
Input:Unlock()
Input:Destroy()
```

### Dropdown

Dropdowns open in a compact overlay above the window content. The content scroll remains vertical and does not resize when dropdowns open.

Single-select dropdown:

```lua
local Preset = Main:Dropdown({
	Title = "Movement Preset",
	Desc = "Single dropdown with search.",
	Values = { "Default", "Fast", "High Jump", "Balanced" },
	Default = "Default",
	Search = true,
	Callback = function(value)
		print(value)
	end,
})
```

Multi-select dropdown:

```lua
local Utilities = Main:Dropdown({
	Title = "Enabled Utilities",
	Desc = "Multi-select dropdown with search.",
	Values = { "Auto Sprint", "Auto Jump", "No Clip", "Fly", "ESP" },
	Default = { "Auto Sprint" },
	Multi = true,
	AllowNone = true,
	Search = true,
	Callback = function(values)
		print(table.concat(values, ", "))
	end,
})
```

Methods:

```lua
Preset:Select("Fast")
Preset:Refresh({ "Default", "Fast", "Legit" })
Preset:Lock()
Preset:Unlock()
Preset:Destroy()
```

Fields:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Values` | `{ string }` | `{}` | Dropdown options. |
| `Default` / `Value` | `string` / table | first option | Initial selected value. |
| `Multi` | `boolean` | `false` | Allows multiple selected options. |
| `AllowNone` | `boolean` | `true` | Allows clearing all values in multi mode. |
| `Search` | `boolean` | `true` | Enables search box in popup. |

## Dialogs

```lua
Window:Dialog({
	Title = "Confirm",
	Content = "Run this action?",
	Buttons = {
		{ Title = "Cancel" },
		{
			Title = "Run",
			Callback = function()
				print("confirmed")
			end,
		},
	},
})
```

## Notifications

```lua
Window:Notify({
	Title = "KazGui",
	Content = "Action completed.",
	Icon = "sparkles",
	Duration = 3,
})
```

You can also call:

```lua
KazGui:Notify({
	Title = "Global",
	Content = "Uses the most recent window.",
	Icon = "bell",
	Duration = 3,
})
```

## Themes

Built-in themes:

```lua
KazGui:SetTheme("Midnight")
KazGui:SetTheme("Emerald")
KazGui:SetTheme("Rose")
```

Custom theme:

```lua
KazGui:SetTheme({
	Name = "Custom",
	Background = Color3.fromRGB(16, 18, 22),
	Topbar = Color3.fromRGB(22, 24, 30),
	Sidebar = Color3.fromRGB(19, 21, 26),
	Surface = Color3.fromRGB(30, 34, 42),
	SurfaceAlt = Color3.fromRGB(38, 44, 54),
	Stroke = Color3.fromRGB(61, 70, 84),
	Text = Color3.fromRGB(240, 244, 250),
	Muted = Color3.fromRGB(150, 160, 176),
	Accent = Color3.fromRGB(255, 196, 87),
	AccentSoft = Color3.fromRGB(92, 67, 30),
	Danger = Color3.fromRGB(235, 87, 87),
})
```

## Icons

KazGui supports:

1. Lucide icon names from the embedded Footagesus Lucide map:
   ```lua
   Icon = "house"
   Icon = "settings-2"
   Icon = "layout-dashboard"
   Icon = "user-round"
   ```
2. Roblox asset ids:
   ```lua
   Icon = "rbxassetid://123456789"
   Icon = "123456789"
   ```

Window and open-button icons use the original image color. Component and tab icons follow theme colors.

## Executor APIs

KazGui uses common executor APIs when available:

| API | Purpose |
| --- | --- |
| `gethui` | Preferred GUI parent. |
| `protect_gui` / `syn.protect_gui` | Optional GUI protection. |
| `cloneref` | Safer CoreGui reference when available. |
| `isfile`, `readfile`, `writefile` | Config autosave. |

If file APIs are unavailable, UI still works but config saving is skipped.

## Troubleshooting

### Raw GitHub still loads old code

Some executors cache `game:HttpGet`. Use a commit URL while testing:

```lua
local KazGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/KazGuiLibrary/<commit>/dist/KazGui.min.lua"))()
```

### Horizontal scroll appears

KazGui sets content scrolling to `Enum.ScrollingDirection.Y`. If horizontal movement still appears, confirm you are loading the latest version.

### Dropdown appears behind components

Dropdowns are rendered in a top-level overlay. If this happens, update to a build after `Improve dropdowns and icons`.

### Title overlaps author/version

Topbar title uses `TextTruncate.AtEnd` and author/version is anchored near the right controls. Update to the latest build if overlap appears.
