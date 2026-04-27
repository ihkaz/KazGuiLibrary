local KazGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ihkaz/KazGuiLibrary/main/dist/KazGui.min.lua"))()

local Window = KazGui:CreateWindow({
	Title = "Kaz Development",
	Author = "iHkaz",
	Icon = "rbxassetid://80490914601117",
	OpenButtonIcon = "rbxassetid://102844189283504",
	Theme = "Midnight",
	Size = UDim2.fromOffset(620, 390),
	MinSize = Vector2.new(460, 300),
	ToggleKey = Enum.KeyCode.RightShift,
	AutoSave = true,
	FileSaveName = "KazHub.json",
})

Window:SetToggleKey(Enum.KeyCode.RightShift)

Window:OnOpen(function()
	print("Window opened")
end)

Window:OnClose(function()
	print("Window closed")
end)

Window:OnDestroy(function()
	print("Window destroyed")
end)

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

Window:Divider()

Main:Label({
	Title = "Dashboard",
	Desc = "Direct tab label without a section.",
	Icon = "layout-dashboard",
})

Main:Divider()

local Combat = Main:Section({
	Title = "Combat",
	Icon = "swords",
	Default = true,
})

local RunButton = Combat:Button({
	Title = "Run Feature",
	Desc = "Execute selected action",
	Icon = "zap",
	Callback = function()
		Window:Notify({
			Title = "KazGui",
			Content = "Feature executed.",
			Icon = "sparkles",
			Duration = 3,
		})
	end,
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
	Desc = "Open a dialog with multiple buttons.",
		Icon = "message-square-warning",
	Callback = function()
		Window:Dialog({
			Title = "Confirm",
			Content = "Run the selected action now?",
			Buttons = {
				{
					Title = "Cancel",
				},
				{
					Title = "Run",
					Callback = function()
						Window:Notify({
							Title = "Dialog",
							Content = "Confirmed.",
							Icon = "sparkles",
							Duration = 2,
						})
					end,
				},
			},
		})
	end,
})

local Info = Main:Section({
	Title = "Info",
	Icon = "info",
	Default = true,
	WithBackground = false,
})

Info:Label({
	Title = "Plain section",
	Desc = "Label and divider also work inside sections.",
	Icon = "info",
})

Info:Divider()

Info:Input({
	Title = "Webhook",
	Desc = "Example text input.",
	Placeholder = "https://discord.com/api/webhooks/...",
	Default = "",
	ClearTextOnFocus = false,
	Callback = function(text)
		print("Webhook:", text)
	end,
})

local Movement = Player:Section({
	Title = "Movement",
	Icon = "footprints",
	Default = true,
})

local WalkSpeed = Movement:Slider({
	Title = "WalkSpeed",
	Desc = "Example slider control.",
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
	Value = {
		Min = 50,
		Max = 200,
		Default = 50,
	},
	Step = 5,
	Callback = function(value)
		print("JumpPower:", value)
	end,
})

local Presets = Player:Section({
	Title = "Presets",
	Icon = "list-checks",
	Default = true,
})

local PresetDropdown = Presets:Dropdown({
	Title = "Movement Preset",
	Desc = "Single dropdown with search.",
	Values = { "Default", "Fast", "High Jump", "Balanced", "Low Gravity", "Legit" },
	Default = "Default",
	Search = true,
	Callback = function(value)
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

Presets:Dropdown({
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
	Callback = function()
		PresetDropdown:Refresh({ "Default", "Fast", "High Jump", "Balanced" })
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
	Default = true,
})

Appearance:Dropdown({
	Title = "Theme",
	Desc = "Switch KazGui theme.",
	Values = { "Midnight", "Emerald", "Rose" },
	Default = "Midnight",
	Callback = function(value)
		KazGui:SetTheme(value)
	end,
})

Appearance:Button({
	Title = "Custom Theme",
	Desc = "Apply a runtime custom theme table.",
	Icon = "palette",
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
})
	end,
})

local Controls = Settings:Section({
	Title = "Control Methods",
	Icon = "sliders-horizontal",
	Default = true,
})

Controls:Button({
	Title = "Set Values",
	Desc = "Call object methods returned by components.",
	Icon = "sliders-horizontal",
	Callback = function()
		RunButton:SetTitle("Run Feature")
		RunButton:SetDesc("Updated from Set Values.")
		AutoFarm:Set(true)
		WalkSpeed:Set(32)
		JumpPower:Set(75)
	end,
})

Controls:Button({
	Title = "Lock Toggle",
	Desc = "Lock Auto Farm for three seconds.",
	Icon = "lock-keyhole",
	Callback = function()
		AutoFarm:Lock()
		task.delay(3, function()
			AutoFarm:Unlock()
		end)
	end,
})

Controls:Button({
	Title = "Collapse Combat",
	Desc = "Use Section:Close and Section:Open.",
	Icon = "panel-top-close",
	Callback = function()
		Combat:Close()
		task.delay(2, function()
			Combat:Open()
		end)
	end,
})

Controls:Button({
	Title = "Go To Player Tab",
	Desc = "Select tab by index.",
	Icon = "user-round",
	Callback = function()
		Window:SelectTab(2)
	end,
})
