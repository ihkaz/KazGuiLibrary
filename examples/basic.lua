local KazGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/KazGuiLibrary/main/dist/KazGui.min.lua"))()

local Window = KazGui:CreateWindow({
	Title = "KazGui Showcase",
	Author = "iHkaz",
	Icon = "rbxassetid://80490914601117",
	OpenButtonIcon = "rbxassetid://102844189283504",
	IconSize = 18,
	IconThemed = false,
	OpenButtonIconThemed = false,
	Theme = "Midnight",
	Acrylic = true,
	AcrylicIntensity = 0.9,
	Size = UDim2.fromOffset(640, 420),
	MinSize = Vector2.new(480, 320),
	ToggleKey = Enum.KeyCode.RightShift,
	AutoSave = true,
	FileSaveName = "KazGuiShowcase.json",
	OnOpen = function()
		print("KazGui opened")
	end,
	OnClose = function()
		print("KazGui closed")
	end,
	OnDestroy = function()
		print("KazGui destroyed")
	end,
})

Window:SetToggleKey("RightShift")

Window:OnOpen(function()
	print("Runtime OnOpen listener")
end)

Window:OnClose(function()
	print("Runtime OnClose listener")
end)

Window:OnDestroy(function()
	print("Runtime OnDestroy listener")
end)

KazGui:Notify({
	Title = "KazGui",
	Content = "Showcase loaded.",
	Icon = "sparkles",
	Duration = 2,
})

local Main = Window:Tab({
	Title = "Main",
	Icon = "house",
})

local Player = Window:Tab({
	Title = "Player",
	Icon = "user-round",
})

local Settings = Window:Tab({
	Title = "Settings",
	Icon = "settings-2",
})

local Advanced = Window:Tab({
	Title = "Advanced",
	Icon = "sliders-horizontal",
	IconThemed = false,
})

local HeaderLabel = Main:Label({
	Title = "Dashboard",
	Desc = "Complete KazGui API showcase.",
	Icon = "layout-dashboard",
	WithIcon = true,
	IconThemed = true,
})

Main:Divider({
	ColorKey = "Stroke",
	Spacing = 16,
	Thickness = 2,
})

local Combat = Main:Section({
	Title = "Combat",
	Icon = "swords",
	WithIcon = true,
	IconThemed = true,
	Default = true,
	WithBackground = true,
})

local RunButton = Combat:Button({
	Title = "Run Feature",
	Desc = "Execute a sample action.",
	Icon = "zap",
	WithIcon = true,
	IconThemed = true,
	Callback = function()
		Window:Notify({
			Title = "Feature",
			Content = "Run Feature clicked.",
			Icon = "circle-check",
			Duration = 2,
		})
	end,
})

Combat:ButtonGroup({
	Buttons = {
		{
			Title = "Save",
			Icon = "save",
			WithIcon = true,
			Callback = function()
				Window:Notify({
					Title = "Preset",
					Content = "Settings saved.",
					Icon = "save",
					Duration = 2,
				})
			end,
		},
		{
			Title = "Load",
			Icon = "folder-open",
			WithIcon = true,
			Callback = function()
				Window:Notify({
					Title = "Preset",
					Content = "Settings loaded.",
					Icon = "folder-open",
					Duration = 2,
				})
			end,
		},
	},
})

local AutoFarm = Combat:Toggle({
	Title = "Auto Farm",
	Desc = "Saved automatically when AutoSave is enabled.",
	Default = false,
	Callback = function(value)
		print("Auto Farm:", value)
	end,
})

Combat:Button({
	Title = "Confirm Action",
	Desc = "Open a modal dialog.",
	Icon = "message-square-warning",
	WithIcon = true,
	Callback = function()
		Window:Dialog({
			Title = "Confirm",
			Content = "Run the selected action now?",
			Buttons = {
				{ Title = "Cancel" },
				{
					Title = "Run",
					Callback = function()
						Window:Notify({
							Title = "Dialog",
							Content = "Action confirmed.",
							Icon = "sparkles",
							Duration = 2,
						})
					end,
				},
			},
		})
	end,
})

local Plain = Main:Section({
	Title = "Plain Section",
	Icon = "info",
	WithIcon = true,
	Default = true,
	WithBackground = false,
})

local PlainLabel = Plain:Label({
	Title = "Plain header",
	Desc = "This section has no background card.",
	Icon = "info",
	WithIcon = true,
	IconColorKey = "Muted",
})

local PlainDivider = Plain:Divider({
	ColorKey = "Accent",
	Spacing = 18,
	Thickness = 2,
	Transparency = 0,
})

local NotesInput = Plain:Input({
	Title = "Notes",
	Desc = "Type anything, then unfocus the box.",
	Placeholder = "Write a note...",
	Default = "",
	ClearTextOnFocus = false,
	Callback = function(text)
		print("Notes:", text)
	end,
})

local Movement = Player:Section({
	Title = "Movement",
	Icon = "footprints",
	WithIcon = true,
	Default = true,
})

local WalkSpeed = Movement:Slider({
	Title = "WalkSpeed",
	Desc = "Slider with Min, Max, Default, and Step.",
	Value = {
		Min = 16,
		Max = 100,
		Default = 16,
	},
	Step = 1,
	Callback = function(value)
		print("WalkSpeed:", value)
	end,
})

local JumpPower = Movement:Slider({
	Title = "JumpPower",
	Desc = "Another saved slider.",
	Min = 50,
	Max = 200,
	Default = 50,
	Step = 5,
	Callback = function(value)
		print("JumpPower:", value)
	end,
})

local Presets = Player:Section({
	Title = "Presets",
	Icon = "list-checks",
	WithIcon = true,
	Default = true,
})

local PresetDropdown = Presets:Dropdown({
	Title = "Movement Preset",
	Desc = "Single-select dropdown with search.",
	Values = { "Default", "Fast", "High Jump", "Balanced", "Low Gravity", "Legit" },
	Default = "Default",
	Search = true,
	Callback = function(value)
		print("Preset:", value)
		if value == "Default" then
			WalkSpeed:Set(16)
			JumpPower:Set(50)
		elseif value == "Fast" then
			WalkSpeed:Set(80)
			JumpPower:Set(50)
		elseif value == "High Jump" then
			WalkSpeed:Set(24)
			JumpPower:Set(150)
		end
	end,
})

local UtilityDropdown = Presets:Dropdown({
	Title = "Enabled Utilities",
	Desc = "Multi-select dropdown with search.",
	Values = {
		"Auto Sprint",
		"Auto Jump",
		"No Clip",
		"Fly",
		"ESP",
		"Tracers",
		"Click Teleport",
		"Infinite Jump",
	},
	Default = { "Auto Sprint" },
	Multi = true,
	AllowNone = true,
	Search = true,
	Callback = function(values)
		print("Enabled Utilities:", table.concat(values, ", "))
	end,
})

Presets:Button({
	Title = "Refresh Presets",
	Desc = "Replace dropdown values at runtime.",
	Icon = "refresh-cw",
	WithIcon = true,
	Callback = function()
		PresetDropdown:Refresh({ "Default", "Fast", "High Jump", "Balanced", "Stealth" })
		UtilityDropdown:Select("ESP")
		Window:Notify({
			Title = "Presets",
			Content = "Dropdown values refreshed.",
			Icon = "settings",
			Duration = 2,
		})
	end,
})

local Appearance = Settings:Section({
	Title = "Appearance",
	Icon = "palette",
	WithIcon = true,
	Default = true,
})

Appearance:Dropdown({
	Title = "Theme",
	Desc = "Switch built-in themes.",
	Values = { "Midnight", "Emerald", "Rose", "Aurora", "Amethyst", "Graphite" },
	Default = "Midnight",
	Callback = function(value)
		KazGui:SetTheme(value)
	end,
})

Appearance:Toggle({
	Title = "Acrylic Mode",
	Desc = "Enable or disable acrylic styling for the whole window.",
	Default = true,
	Callback = function(value)
		Window:SetAcrylic(value, 0.9)
	end,
})

Appearance:Button({
	Title = "Custom Theme",
	Desc = "Apply a runtime custom theme table.",
	Icon = "palette",
	WithIcon = true,
	Callback = function()
		KazGui:SetTheme({
			Name = "Custom",
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
				Background = {
					Rotation = 35,
					Colors = {
						{ Time = 0, Color = Color3.fromRGB(10, 6, 18) },
						{ Time = 1, Color = Color3.fromRGB(25, 10, 45) },
					},
				},
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
				AccentSoft = {
					Rotation = 90,
					Colors = {
						{ Time = 0, Color = Color3.fromRGB(35, 55, 95) },
						{ Time = 1, Color = Color3.fromRGB(75, 25, 105) },
					},
				},
			},
		})
	end,
})

local Methods = Settings:Section({
	Title = "Runtime Methods",
	Icon = "wrench",
	WithIcon = true,
	Default = true,
})

Methods:Button({
	Title = "Set Values",
	Desc = "Call methods returned by components.",
	Icon = "sliders-horizontal",
	WithIcon = true,
	Callback = function()
		HeaderLabel:SetTitle("Dashboard Updated")
		HeaderLabel:SetDesc("Updated using Label:SetTitle and Label:SetDesc.")
		PlainLabel:SetIcon("badge-info")
		PlainDivider:SetColorKey("Stroke")
		RunButton:SetTitle("Run Feature")
		RunButton:SetDesc("Updated from Set Values.")
		RunButton:SetIcon("sparkles")
		AutoFarm:Set(true)
		WalkSpeed:Set(32)
		JumpPower:Set(75)
		NotesInput:Set("Updated from code.")
		NotesInput:SetPlaceholder("Placeholder updated.")
	end,
})

Methods:Button({
	Title = "Toggle Icon Styling",
	Desc = "Switch icon visibility and theme behavior.",
	Icon = "paintbrush",
	WithIcon = true,
	Callback = function()
		RunButton:SetWithIcon(true)
		RunButton:SetIconThemed(false)
		PlainLabel:SetWithIcon(true)
		PlainLabel:SetIconThemed(false)
	end,
})

Methods:Button({
	Title = "Lock Controls",
	Desc = "Temporarily lock toggle, sliders, input, and dropdown.",
	Icon = "lock-keyhole",
	WithIcon = true,
	Callback = function()
		AutoFarm:Lock()
		WalkSpeed:Lock()
		JumpPower:Lock()
		NotesInput:Lock()
		PresetDropdown:Lock()
		task.delay(3, function()
			AutoFarm:Unlock()
			WalkSpeed:Unlock()
			JumpPower:Unlock()
			NotesInput:Unlock()
			PresetDropdown:Unlock()
		end)
	end,
})

Methods:Button({
	Title = "Collapse Combat",
	Desc = "Use Section:Close and Section:Open.",
	Icon = "panel-top-close",
	WithIcon = true,
	Callback = function()
		Combat:Close()
		task.delay(2, function()
			Combat:Open()
		end)
	end,
})

Methods:Button({
	Title = "Go To Player Tab",
	Desc = "Select a tab by index.",
	Icon = "user-round",
	WithIcon = true,
	Callback = function()
		Window:SelectTab(2)
	end,
})

Methods:Button({
	Title = "Hide Window",
	Desc = "Use Window:Close and the open button to return.",
	Icon = "eye-off",
	WithIcon = true,
	Callback = function()
		Window:Close()
	end,
})

local CustomParent = Advanced:Section({
	Title = "Custom Parent API",
	Icon = "folder-tree",
	WithIcon = true,
	Default = true,
})

CustomParent:Label({
	Title = "Default parent",
	Desc = "The next label is inserted using Tab:SetParent.",
	Icon = "arrow-down",
	WithIcon = true,
})

Advanced:SetParent(CustomParent.Parent)
Advanced:Label({
	Title = "Inserted through Advanced:SetParent",
	Desc = "Advanced:ResetParent is called immediately after this label.",
	Icon = "corner-down-right",
	WithIcon = true,
})
Advanced:ResetParent()

local Destructive = Advanced:Section({
	Title = "Destroy Methods",
	Icon = "trash-2",
	WithIcon = true,
	Default = true,
})

local TemporaryLabel = Destructive:Label({
	Title = "Temporary Label",
	Desc = "Destroy this label with the button below.",
	Icon = "timer",
	WithIcon = true,
})

Destructive:Button({
	Title = "Destroy Temporary Label",
	Desc = "Calls Label:Destroy.",
	Icon = "trash",
	WithIcon = true,
	Callback = function()
		if TemporaryLabel then
			TemporaryLabel:Destroy()
			TemporaryLabel = nil
		end
	end,
})

Destructive:Button({
	Title = "Destroy Window",
	Desc = "Calls Window:Destroy.",
	Icon = "x",
	WithIcon = true,
	Callback = function()
		Window:Destroy()
	end,
})
