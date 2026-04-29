# KazGui Documentation

KazGui is a Roblox Luau GUI library for executor environments. It provides draggable and resizable windows, theme support, Lucide icons, tabs, sections, common controls, searchable dropdowns, multi-select dropdowns, dialogs, notifications, and optional config autosave.

## Loader

```lua
local KazGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/KazGuiLibrary/main/dist/KazGui.min.lua"))()
```

For cache-safe testing, load a specific commit:

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
	IconSize = 18,
	Theme = "Midnight",
	Acrylic = true,
	AcrylicIntensity = 0.9,
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
	Icon = "swords",
	WithIcon = true,
	Default = true,
})

Combat:Toggle({
	Title = "Auto Farm",
	Desc = "Saved automatically when AutoSave is enabled.",
	Default = false,
	Callback = function(value)
		print("Auto Farm:", value)
	end,
})
```

## Object Flow

KazGui uses a simple object chain:

```text
KazGui -> Window -> Tab -> Section -> Component
```

Components can be created directly inside a tab or inside a section:

```lua
Main:Button({...})

local Settings = Main:Section({...})
Settings:Dropdown({...})
```

All component constructors return a control object. Store it if you want to update, lock, unlock, or destroy the component later.

## Library API

### `KazGui:CreateWindow(data)`

Creates a new window and returns a `Window` object.

```lua
local Window = KazGui:CreateWindow({
	Title = "KazHub",
	Theme = "Midnight",
})
```

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"KazGui"` | Window title shown in the topbar. Long text truncates safely. |
| `Author` | `string` | `"v1.0"` | Text shown on the right side of the topbar. |
| `Version` | `string` | `"v1.0"` | Alias used when `Author` is not provided. |
| `Icon` | `string` / asset id | `"layout"` | Window icon. Accepts Lucide icon names, numeric asset ids, or `rbxassetid://...`. |
| `IconSize` | `number` / `Vector2` / `UDim2` | `18` | Topbar window icon size only. |
| `IconThemed` | `boolean` | `true` | When true, the window icon follows the theme. Set false to keep the image color. |
| `IconColorKey` | `string` | `"Accent"` | Theme key used when `IconThemed` is true. |
| `IconColor` | `Color3` | white | Static icon color used when `IconThemed` is false. |
| `OpenButtonIcon` | `string` / asset id | `Icon` | Image-only button icon shown when the window is hidden. |
| `OpenButtonIconThemed` | `boolean` | `true` | When true, the open button icon follows the theme. |
| `OpenButtonIconColorKey` | `string` | `"Accent"` | Theme key used for the open button icon. |
| `OpenIcon` | `string` / asset id | `Icon` | Alias for `OpenButtonIcon`. |
| `Theme` | `string` / table | current theme | Initial theme for the library. |
| `Acrylic` | `boolean` | `false` | Enables acrylic styling for window surfaces and all component cards. |
| `AcrylicIntensity` | `number` | `1` | Acrylic strength from `0` to `1`. |
| `Size` | `UDim2` | `UDim2.fromOffset(620, 390)` | Initial window size. |
| `MinSize` | `Vector2` | `Vector2.new(460, 300)` | Minimum size for user resizing. |
| `ToggleKey` | `Enum.KeyCode` | `Enum.KeyCode.RightShift` | Keyboard key used to hide or show the window. |
| `AutoSave` | `boolean` | `true` | Enables config writes for supported controls when file APIs exist. |
| `FileSaveName` | `string` | `"<Title>.json"` | File path/name used for saved values. |
| `OnOpen` | `function(window)` | `nil` | Optional callback fired when the window becomes visible. |
| `OnClose` | `function(window)` | `nil` | Optional callback fired when the window is hidden or destroyed while visible. |
| `OnDestroy` | `function(window)` | `nil` | Optional callback fired before the window GUI is destroyed. |

### `KazGui:SetTheme(theme)`

Applies a built-in theme name or custom theme table to all active windows.

```lua
KazGui:SetTheme("Emerald")
```

Returns `true` when the theme is applied, otherwise `false`.

Custom themes may include optional gradients. Gradient keys match normal theme color keys such as `Background`, `Surface`, `SurfaceAlt`, `Topbar`, `Sidebar`, `Accent`, and `AccentSoft`.

```lua
KazGui:SetTheme({
	Name = "Aurora",
	Background = Color3.fromRGB(10, 6, 18),
	Topbar = Color3.fromRGB(20, 12, 35),
	Sidebar = Color3.fromRGB(15, 9, 28),
	Surface = Color3.fromRGB(34, 18, 60),
	SurfaceAlt = Color3.fromRGB(52, 28, 90),
	Stroke = Color3.fromRGB(100, 50, 160),
	Text = Color3.fromRGB(230, 220, 255),
	Muted = Color3.fromRGB(140, 110, 180),
	Accent = Color3.fromRGB(180, 80, 255),
	AccentSoft = Color3.fromRGB(60, 20, 90),
	Danger = Color3.fromRGB(200, 80, 60),
	Gradients = {
		Surface = {
			Rotation = 25,
			Colors = {
				{ Time = 0, Color = Color3.fromRGB(34, 18, 60) },
				{ Time = 1, Color = Color3.fromRGB(48, 24, 84) },
			},
		},
		Accent = {
			Rotation = 90,
			Colors = {
				{ Time = 0, Color = Color3.fromRGB(90, 180, 255) },
				{ Time = 1, Color = Color3.fromRGB(210, 80, 255) },
			},
		},
	},
})
```

Gradient entries also support percent keys:

```lua
Gradients = {
	Accent = {
		Rotation = 45,
		[0] = { Color = Color3.fromRGB(90, 180, 255), Transparency = 0 },
		[100] = { Color = Color3.fromRGB(210, 80, 255), Transparency = 0 },
	},
}
```

### `KazGui:Notify(data)`

Shows a notification on the most recently created active window.

```lua
KazGui:Notify({
	Title = "KazGui",
	Content = "Loaded successfully.",
	Icon = "bell",
	Duration = 3,
})
```

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Notification"` | Notification title. |
| `Content` | `string` | `""` | Notification body text. |
| `Icon` | `string` / asset id | `"sparkles"` | Notification icon. |
| `IconThemed` | `boolean` | `true` | When true, the notification icon follows the theme. |
| `IconColorKey` | `string` | `"Accent"` | Theme key used when `IconThemed` is true. |
| `IconColor` | `Color3` | white | Static icon color used when `IconThemed` is false. |
| `Duration` | `number` | `5` | Auto-close delay in seconds. |

Returns an object with `:Close()`.

## Window API

### `Window:Tab(data)`

Creates a sidebar tab and returns a `Tab` object.

```lua
local Player = Window:Tab({
	Title = "Player",
	Icon = "user-round",
})
```

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Tab"` | Sidebar tab label. |
| `Icon` | `string` / asset id | `"circle"` | Sidebar tab icon. |
| `IconThemed` | `boolean` | `true` | When true, the tab icon follows selected/inactive theme colors. |
| `IconColorKey` | `string` | `"Muted"` | Initial theme key used for the tab icon. |
| `IconColor` | `Color3` | white | Static icon color used when `IconThemed` is false. |

### `Window:Toggle(state)`

Toggles window visibility. Hidden windows show the image-only open button.

```lua
Window:Toggle()
Window:Toggle(true)
Window:Toggle(false)
```

Parameters:

| Parameter | Type | Description |
| --- | --- | --- |
| `state` | `boolean?` | `true` opens, `false` hides, `nil` toggles the current state. |

Returns `true` when the request is handled, otherwise `false` if the window has been destroyed.

### `Window:Open()`

Shows the window.

```lua
Window:Open()
```

Equivalent to `Window:Toggle(true)`.

### `Window:Close()`

Hides the window and shows the open button.

```lua
Window:Close()
```

Equivalent to `Window:Toggle(false)`.

### `Window:Destroy()`

Destroys the window GUI and removes the window from `KazGui.Windows`.

```lua
Window:Destroy()
```

This also disconnects the toggle-key listener, removes the dropdown overlay, clears lifecycle callbacks, and prevents future theme refresh work for that window.

### `Window:OnOpen(callback)`

Registers a callback fired when the window becomes visible.

```lua
local connection = Window:OnOpen(function(window)
	print("opened", window.Title)
end)

connection:Disconnect()
```

### `Window:OnClose(callback)`

Registers a callback fired when the window is hidden. If `Window:Destroy()` is called while visible, close callbacks fire before destroy callbacks.

```lua
Window:OnClose(function(window)
	print("closed", window.Title)
end)
```

### `Window:OnDestroy(callback)`

Registers a callback fired before the GUI is destroyed.

```lua
Window:OnDestroy(function(window)
	print("destroyed", window.Title)
end)
```

### `Window:SetToggleKey(key)`

Changes the keyboard shortcut used to hide or show the window.

```lua
Window:SetToggleKey(Enum.KeyCode.RightControl)
Window:SetToggleKey("RightControl")
```

Parameters:

| Parameter | Type | Description |
| --- | --- | --- |
| `key` | `Enum.KeyCode` / `string` | New toggle key. String values are resolved through `Enum.KeyCode`. |

### `Window:SetTheme(theme)`

Applies a theme and refreshes active windows.

```lua
Window:SetTheme("Rose")
```

Returns `true` when applied, otherwise `false`.

### `Window:SetAcrylic(value, intensity)`

Enables or disables acrylic styling for the window and registered component surfaces.

```lua
Window:SetAcrylic(true, 0.9)
Window:SetAcrylic(false)
```

Parameters:

| Parameter | Type | Description |
| --- | --- | --- |
| `value` | `boolean` | `true` enables acrylic, `false` returns surfaces to normal. |
| `intensity` | `number?` | Optional acrylic strength from `0` to `1`. |

This is a window-level switch. Components do not need their own acrylic option.

### `Window:SelectTab(target)`

Selects a tab by object or numeric index.

```lua
Window:SelectTab(2)
Window:SelectTab(Player)
```

Parameters:

| Parameter | Type | Description |
| --- | --- | --- |
| `target` | `number` / `Tab` | Tab index or tab object returned by `Window:Tab()`. |

### `Window:Dialog(data)`

Shows a modal dialog inside the window.

```lua
Window:Dialog({
	Title = "Confirm",
	Content = "Run selected action?",
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

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Dialog"` | Dialog title. |
| `Content` | `string` | `""` | Dialog body text. |
| `Buttons` | `{ table }` | `{ { Title = "Ok" } }` | Button definitions shown at the bottom of the dialog. |

Button fields:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Button"` | Button label. |
| `Callback` | `function()` | `nil` | Fired before the dialog closes. |

### `Window:Notify(data)`

Shows a notification on this window. This forwards to `KazGui:Notify(data)`.

```lua
Window:Notify({
	Title = "Saved",
	Content = "Settings updated.",
	Icon = "circle-check",
	Duration = 2,
})
```

## Tab API

Tabs can contain sections or components directly.

### `Tab:Section(data)`

Creates a collapsible section and returns a `Section` object.

```lua
local Movement = Player:Section({
	Title = "Movement",
	Icon = "footprints",
	WithIcon = true,
	Default = true,
	WithBackground = true,
})
```

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Section"` | Header title. |
| `Icon` | `string` / asset id | `"folder"` | Header icon. |
| `WithIcon` | `boolean` | `false` | Shows the header icon when true. |
| `IconThemed` | `boolean` | `true` | When true, the section icon follows the theme. |
| `IconColorKey` | `string` | `"Accent"` | Theme key used when `IconThemed` is true. |
| `IconColor` | `Color3` | white | Static icon color used when `IconThemed` is false. |
| `IconSize` | `number` / `Vector2` / `UDim2` | `16` | Overrides icon size for this section. |
| `Default` | `boolean` | `true` | Initial expanded state. |
| `WithBackground` | `boolean` | `true` | Enables the section background, stroke, and inner padding. |

### `Tab:SetParent(parent)`

Changes where new components created by this tab are inserted.

```lua
Tab:SetParent(customFrame)
```

Use this only when you intentionally manage layout yourself.

### `Tab:ResetParent()`

Resets component insertion back to the tab page.

```lua
Tab:ResetParent()
```

### Component constructors

Tabs support the same component constructors as sections:

```lua
Tab:Button({...})
Tab:Label({...})
Tab:Divider({...})
Tab:Toggle({...})
Tab:Slider({...})
Tab:Input({...})
Tab:Dropdown({...})
```

## Section API

Sections group components and can be collapsed.

```lua
local Section = Main:Section({
	Title = "General",
	Icon = "settings",
})
```

### Section methods

```lua
Section:SetTitle("New Title")
Section:SetState(false)
Section:Open()
Section:Close()
Section:Destroy()
```

| Method | Parameters | Description |
| --- | --- | --- |
| `SetTitle` | `text: string` | Updates the section header title. |
| `SetState` | `value: boolean` | Expands or collapses the section. |
| `Open` | none | Expands the section. |
| `Close` | none | Collapses the section. |
| `Destroy` | none | Removes the section and its components. |

### Component constructors

Sections support:

```lua
Section:Button({...})
Section:Label({...})
Section:Divider({...})
Section:Toggle({...})
Section:Slider({...})
Section:Input({...})
Section:Dropdown({...})
```

## Components

Every component accepts `Title` and most visual components accept `Desc`. Components that store values use `Title` as the autosave key.

### Button

Creates a clickable action card.

```lua
local Button = Main:Button({
	Title = "Run Feature",
	Desc = "Execute selected action.",
	Icon = "zap",
	WithIcon = true,
	Locked = false,
	Callback = function()
		print("clicked")
	end,
})
```

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Button"` | Button title and autosave-safe object name. |
| `Desc` | `string` | `nil` | Optional secondary text. |
| `Icon` | `string` / asset id | `"zap"` | Icon shown on the right when `WithIcon` is true. |
| `WithIcon` | `boolean` | `false` | Enables the button icon. |
| `IconThemed` | `boolean` | `true` | When true, the button icon follows the theme. |
| `IconColorKey` | `string` | `"Muted"` | Theme key used when `IconThemed` is true. |
| `IconColor` | `Color3` | white | Static icon color used when `IconThemed` is false. |
| `IconSize` | `number` / `Vector2` / `UDim2` | `18` | Button icon size. |
| `Locked` | `boolean` | `false` | Prevents clicks when true. |
| `Callback` | `function()` | empty function | Fired when clicked while unlocked. |

Methods:

| Method | Parameters | Description |
| --- | --- | --- |
| `SetTitle` | `text: string` | Updates title text. |
| `SetDesc` | `text: string?` | Updates or hides description text. |
| `SetIcon` | `icon: string?` | Updates the button icon. |
| `SetWithIcon` | `value: boolean` | Shows or hides the button icon. |
| `SetIconThemed` | `value: boolean` | Enables or disables theme color for the icon. |
| `Lock` | none | Disables interaction. |
| `Unlock` | none | Enables interaction. |
| `Destroy` | none | Removes the component. |

### ButtonGroup

Creates two or more compact buttons in one horizontal line.

```lua
local Group = Main:ButtonGroup({
	Buttons = {
		{
			Title = "Save",
			Icon = "save",
			WithIcon = true,
			Callback = function() end,
		},
		{
			Title = "Load",
			Icon = "folder-open",
			WithIcon = true,
			Callback = function() end,
		},
	},
})
```

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Buttons` | `{ table }` | `{}` | Button definitions shown in the row. |
| `Items` | `{ table }` | `Buttons` | Alias for `Buttons`. |
| `Height` | `number` | `48` | Row height. |
| `Gap` | `number` | `8` | Horizontal spacing between buttons. |
| `Locked` | `boolean` | `false` | Prevents all group buttons from firing callbacks. |

Button fields:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Button <index>"` | Button text. |
| `Icon` | `string` / asset id | `nil` | Optional icon shown before the title. |
| `WithIcon` | `boolean` | `false` | Enables the icon. |
| `IconThemed` | `boolean` | `true` | When true, the icon follows the theme. |
| `IconColorKey` | `string` | `"Muted"` | Theme key used when `IconThemed` is true. |
| `IconColor` | `Color3` | white | Static icon color used when `IconThemed` is false. |
| `IconSize` | `number` / `Vector2` / `UDim2` | `16` | Button icon size. |
| `ColorKey` | `string` | `"Surface"` | Theme key used for the button background. |
| `AccentColorKey` | `string` | `"Accent"` | Theme key used for the right accent marker. |
| `Locked` | `boolean` | `false` | Prevents this button from firing callbacks. |
| `Callback` | `function()` | empty function | Fired when clicked while unlocked. |

Methods:

| Method | Parameters | Description |
| --- | --- | --- |
| `AddButton` | `info: table` | Adds another button to the row. |
| `Lock` | none | Locks the whole group. |
| `Unlock` | none | Unlocks the whole group. |
| `Destroy` | none | Removes the group. |

### Label

Creates static text with an optional icon.

```lua
local Label = Main:Label({
	Title = "Dashboard",
	Desc = "Optional supporting text.",
	Icon = "info",
	WithIcon = true,
	TextSize = 14,
	ColorKey = "Text",
	IconColorKey = "Accent",
})
```

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Label"` | Main label text. |
| `Desc` | `string` | `nil` | Optional secondary text. |
| `Icon` | `string` / asset id | `nil` | Icon shown before the title when `WithIcon` is true. |
| `WithIcon` | `boolean` | `false` | Enables the label icon. |
| `IconThemed` | `boolean` | `true` | When true, the label icon follows the theme. |
| `IconSize` | `number` / `Vector2` / `UDim2` | `16` | Label icon size. |
| `TextSize` | `number` | `14` | Title font size. |
| `ColorKey` | `string` | `"Text"` | Theme color key used for title text. |
| `IconColorKey` | `string` | `"Accent"` | Theme color key used for the icon. |

Methods:

| Method | Parameters | Description |
| --- | --- | --- |
| `SetTitle` | `text: string` | Updates title text. |
| `SetDesc` | `text: string?` | Updates or hides description text. |
| `SetIcon` | `icon: string?` | Updates or removes the icon. |
| `SetWithIcon` | `value: boolean` | Shows or hides the label icon. |
| `SetIconThemed` | `value: boolean` | Enables or disables theme color for the icon. |
| `Destroy` | none | Removes the label. |

### Divider

Creates a themed separator line.

```lua
local Divider = Main:Divider({
	Spacing = 18,
	ColorKey = "Stroke",
	Thickness = 2,
	Transparency = 0,
})
```

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Spacing` | `number` | `14` | Divider container height. |
| `ColorKey` | `string` | `"Stroke"` | Theme color key used for the divider line. |
| `Thickness` | `number` | `2` | Divider line height. |
| `Transparency` | `number` | `0` | Divider line transparency. |

Methods:

| Method | Parameters | Description |
| --- | --- | --- |
| `SetColorKey` | `colorKey: string` | Changes which theme color key the divider uses. |
| `Destroy` | none | Removes the divider. |

### Toggle

Creates a boolean switch.

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

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Toggle"` | Toggle title and autosave key. |
| `Desc` | `string` | `nil` | Optional secondary text. |
| `Default` | `boolean` | `false` | Initial value when config has no saved value. |
| `Value` | `boolean` | `false` | Alias-style initial value when `Default` is not used. |
| `Locked` | `boolean` | `false` | Prevents user interaction when true. |
| `Callback` | `function(value: boolean)` | empty function | Fired on creation and whenever value changes. |

Methods:

| Method | Parameters | Description |
| --- | --- | --- |
| `Set` | `value: boolean` | Updates the value, saves config, and fires callback. |
| `SetTitle` | `text: string` | Updates title text. |
| `SetDesc` | `text: string?` | Updates or hides description text. |
| `Lock` | none | Prevents toggling. |
| `Unlock` | none | Allows toggling. |
| `Destroy` | none | Removes the toggle. |

### Slider

Creates a numeric slider.

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

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Slider"` | Slider title and autosave key. |
| `Desc` | `string` | `nil` | Optional secondary text. |
| `Value.Min` | `number` | `0` | Minimum value. |
| `Value.Max` | `number` | `100` | Maximum value. |
| `Value.Default` | `number` | `Min` | Initial value when config has no saved value. |
| `Min` | `number` | `0` | Alternative top-level minimum value. |
| `Max` | `number` | `100` | Alternative top-level maximum value. |
| `Default` | `number` | `Min` | Alternative top-level default value. |
| `Step` | `number` | `1` | Increment used when rounding slider values. |
| `Locked` | `boolean` | `false` | Prevents dragging when true. |
| `Callback` | `function(value: number)` | empty function | Fired on creation and whenever value changes. |

Methods:

| Method | Parameters | Description |
| --- | --- | --- |
| `Set` | `value: number` | Rounds, clamps, saves config, and fires callback. |
| `SetTitle` | `text: string` | Updates title text. |
| `SetDesc` | `text: string?` | Updates or hides description text. |
| `Lock` | none | Prevents dragging. |
| `Unlock` | none | Allows dragging. |
| `Destroy` | none | Removes the slider. |

### Input

Creates a text input.

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

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Input"` | Input title and autosave key. |
| `Desc` | `string` | `nil` | Optional secondary text. |
| `Default` | `string` | `""` | Initial text when config has no saved value. |
| `Value` | `string` | `""` | Alias-style initial text when `Default` is not used. |
| `Placeholder` | `string` | `""` | Placeholder text shown when empty. |
| `ClearTextOnFocus` | `boolean` | `false` | Roblox `TextBox.ClearTextOnFocus` behavior. |
| `Locked` | `boolean` | `false` | Prevents editing when locked after creation. |
| `Callback` | `function(text: string)` | empty function | Fired on creation and after focus is lost or `Set` is called. |

Methods:

| Method | Parameters | Description |
| --- | --- | --- |
| `Set` | `text: string` | Updates text, saves config, and fires callback. |
| `SetTitle` | `text: string` | Updates title text. |
| `SetDesc` | `text: string?` | Updates or hides description text. |
| `SetPlaceholder` | `text: string` | Updates placeholder text. |
| `Lock` | none | Makes the text box read-only. |
| `Unlock` | none | Allows editing. |
| `Destroy` | none | Removes the input. |

### Dropdown

Creates a searchable dropdown. Dropdowns open in a top-level overlay so components below do not cover the option list.

Single-select:

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

Multi-select:

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

Parameters:

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | `string` | `"Dropdown"` | Dropdown title and autosave key. |
| `Desc` | `string` | `nil` | Optional secondary text. |
| `Values` | `{ string }` | `{}` | Available options. |
| `Default` | `string` / `{ string }` | first option | Initial selected value when config has no saved value. |
| `Value` | `string` / `{ string }` | first option | Alias-style initial value when `Default` is not used. |
| `Multi` | `boolean` | `false` | Allows selecting more than one option. |
| `AllowNone` | `boolean` | `true` | In multi mode, allows all options to be cleared. |
| `Search` | `boolean` | `true` | Shows the search input in the dropdown overlay. |
| `Locked` | `boolean` | `false` | Prevents opening while true. |
| `Callback` | `function(value)` | empty function | Fired on creation and whenever selection changes. Multi mode passes a table. |

Methods:

| Method | Parameters | Description |
| --- | --- | --- |
| `Select` | `value: string` | Selects a value. In multi mode it toggles that value. |
| `Refresh` | `newValues: { string }` | Replaces the option list. |
| `SetTitle` | `text: string` | Updates title text. |
| `SetDesc` | `text: string?` | Updates or hides description text. |
| `Lock` | none | Prevents opening. |
| `Unlock` | none | Allows opening. |
| `Destroy` | none | Removes the dropdown. |

## Themes

Built-in themes:

```lua
KazGui:SetTheme("Midnight")
KazGui:SetTheme("Emerald")
KazGui:SetTheme("Rose")
KazGui:SetTheme("Aurora")
KazGui:SetTheme("Amethyst")
KazGui:SetTheme("Graphite")
```

Custom themes can provide any subset of the theme keys. Missing keys fall back to `Midnight`.

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

Theme keys:

| Key | Used for |
| --- | --- |
| `Background` | Window background and overlays. |
| `Topbar` | Window topbar. |
| `Sidebar` | Left navigation sidebar. |
| `Surface` | Cards, sections, dialogs, and notifications. |
| `SurfaceAlt` | Secondary surfaces such as input fields and inactive toggle tracks. |
| `Stroke` | Borders and divider lines. |
| `Text` | Primary text and active toggle knobs. |
| `Muted` | Secondary text and inactive icons. |
| `Accent` | Active state, highlights, and primary action color. |
| `AccentSoft` | Selected tab background. |
| `Danger` | Reserved danger color. |

## Icons

Icon fields accept:

1. Lucide icon names from the embedded icon map:
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

Window and open-button icons keep their original image color. Component, tab, section, notification, and label icons use theme colors.

## Autosave

Autosave uses common executor file APIs when available:

| API | Purpose |
| --- | --- |
| `isfile` | Checks whether the config file exists. |
| `readfile` | Reads saved config. |
| `writefile` | Writes updated config. |

Saved controls:

| Component | Saved value |
| --- | --- |
| `Toggle` | boolean |
| `Slider` | number |
| `Input` | string |
| `Dropdown` | string or table in multi mode |

Config keys use each component `Title`. Keep titles stable if you want saved values to persist across updates.

## Executor APIs

KazGui uses common executor APIs when available:

| API | Purpose |
| --- | --- |
| `gethui` | Preferred GUI parent. |
| `protect_gui` / `syn.protect_gui` | Optional GUI protection. |
| `cloneref` | Safer CoreGui reference when available. |
| `isfile`, `readfile`, `writefile` | Config autosave. |

If file APIs are unavailable, the UI still works but config saving is skipped.

## Troubleshooting

### Raw GitHub still loads old code

Some executors cache `game:HttpGet`. Use a commit URL while testing:

```lua
local KazGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/KazGuiLibrary/<commit>/dist/KazGui.min.lua"))()
```

### Theme does not update after closing and loading again

Use the current lifecycle API. The close button calls `Window:Destroy()`, which removes the window from active windows and disconnects the toggle-key listener. If you destroy a window manually, call `Window:Destroy()` instead of destroying the `ScreenGui` instance directly.

### Horizontal scroll appears

KazGui sets content scrolling to `Enum.ScrollingDirection.Y`. If horizontal movement still appears, confirm you are loading the latest version.

### Dropdown appears behind components

Dropdowns render in a top-level overlay. If this happens, confirm you are loading the latest version.

### Title overlaps author/version

Topbar title uses `TextTruncate.AtEnd` and author/version is anchored near the right controls. Confirm you are loading the latest version if overlap appears.
