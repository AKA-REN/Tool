--// Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

--// Decompiler Loader (MEDAL)
if Medal_Decompiler then
	loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/TrapstarKS/Signal/refs/heads/main/Decompile.lua"))()
end
--// ReGui Loader
local ReGui = loadstring(game:HttpGet("https://api.lithium.wtf/misc/regui"))()
-- Theme

ReGui:DefineTheme("Dark Theme", {
	Text = Color3.fromRGB(220, 220, 220),
	WindowBg = Color3.fromRGB(25, 25, 25),
	TitleBarBg = Color3.fromRGB(20, 20, 20),
	TitleBarBgActive = Color3.fromRGB(35, 35, 35),
	Border = Color3.fromRGB(45, 45, 45),
	ResizeGrab = Color3.fromRGB(45, 45, 45),
})

-- Window

local TabsWindow = ReGui:TabsWindow({
	Title = "Secret Lab X",
	Theme = "Dark Theme",
	Size = UDim2.fromOffset(500, 260),
})

-- Decompiler
local Credit = TabsWindow:CreateTab({
	Name = "Credit",
})

Credit:Label({
	Text = "UI Library: https://github.com/depthso",
})
Credit:Label({
	Text = "MEDAL Decompiler : https://github.com/TrapstarKS",
})
Credit:Label({
	Text = "Dex : https://github.com/AKA-REN",
})
Credit:Label({
	Text = "Synsaveinstance : https://github.com/luau",
})
Credit:Label({
	Text = "GCView2 : https://github.com/Awakenchan",
})
Credit:Label({
	Text = "Cobalt Spy : https://github.com/notpoiu",
})
Credit:Label({
	Text = "Infinite Yield : https://github.com/EdgeIY",
})
Credit:Label({
	Text = "CachedServerhop : https://github.com/Cesare0328",
})

local Decompiler = TabsWindow:CreateTab({
	Name = "Decompiler",
})

Decompiler:Separator({ Text = "MEDAL Decompiler" })

Decompiler:Radiobox({
	Value = true,
	Label = "Hide Upvalues",
	Callback = function(_, v)
		getgenv().HideUpvalues = v
	end,
})

Decompiler:Radiobox({
	Value = false,
	Label = "Hide Function Names",
	Callback = function(_, v)
		getgenv().HideFunctionsNames = v
	end,
})

Decompiler:Radiobox({
	Value = true,
	Label = "Hide Function Lines",
	Callback = function(_, v)
		getgenv().HideFunctionsLine = v
	end,
})

Decompiler:Button({
	Text = "DexPlusPlus",
	Callback = function()
		loadstring(game:HttpGetAsync("https://secretlabx.online/Dex.lua"))()
	end,
})

-- Utility

local Utility = TabsWindow:CreateTab({
	Name = "Utility",
})

Utility:Separator({ Text = "Player" })

--// Array
local Mode = Utility:Combo({
	Label = "Select Mode",
	Selected = "CFrame",
	Items = {
		"CFrame",
		"Position",
	},
})

local UtilityRow = Utility:Row()

UtilityRow:Button({
	Text = "Copy Teleport Code",
	Callback = function()
		local char = LocalPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		local pos = hrp[Mode.Selected]
		if hrp and Mode.Selected == "CFrame" then
			setclipboard(
				"game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(" .. tostring(pos) .. ")"
			)
		elseif hrp and Mode.Selected == "Position" then
			setclipboard(
				string.format(
					"game.Players.LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(%.3f, %.3f, %.3f)",
					pos.X,
					pos.Y,
					pos.Z
				)
			)
		end
	end,
})

Utility:Separator({ Text = "Server" })

Utility:Button({
	Text = "Rejoin",
	Callback = function()
		local Rejoin = Instance.new("BindableFunction")
		Rejoin.OnInvoke = function()
			local TeleportService = game:GetService("TeleportService")
			local Players = game:GetService("Players")

			TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
		end
		Rejoin:Invoke()
	end,
})

Utility:Button({
	Text = "CachedServerhop",
	Callback = function()
		loadstring(
			game:HttpGetAsync(
				"https://raw.githubusercontent.com/Cesare0328/my-scripts/refs/heads/main/CachedServerhop.lua"
			)
		)()
	end,
})

-- Debug / Inspect

local Debug = TabsWindow:CreateTab({
	Name = "Debug",
})

Debug:Separator({ Text = "Runtime Inspection" })

local DebugRow = Debug:Row()

DebugRow:Button({
	Text = "Dump Function",
	Callback = function()
		local scanned, lines = {}, {}
		local function safe_debug_info(fn, what)
			local ok, r = pcall(debug.info, fn, what)
			return ok and r or nil
		end
		for _, fn in next, getgc(true) do
			if typeof(fn) == "function" and islclosure(fn) and not scanned[fn] then
				scanned[fn] = true

				local name = safe_debug_info(fn, "n")
				local src = safe_debug_info(fn, "s") or "[no source]"
				local addr = tostring(fn)

				if name and name ~= "" and name ~= "anonymous" then
					local line = string.format("%s function : %s : %s", name, addr, src)
					table.insert(lines, line)
					print(line)
				end
			end
		end
		if type(setclipboard) == "function" then
			setclipboard(table.concat(lines, "\n"))
			print("\n--- Dump copied to clipboard ---")
		else
			print("\n--- setclipboard not supported ---")
		end
	end,
})

DebugRow:Button({
	Text = "Cobalt Spy",
	Callback = function()
		loadstring(game:HttpGetAsync("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()
	end,
})

DebugRow:Button({
	Text = "GCView2",
	Callback = function()
		loadstring(game:HttpGetAsync("https://api.luarmor.net/files/v3/loaders/caffbda8eeb690826d7f1911098bd3f2.lua"))()
	end,
})

-- Admin / Hub

local Admin = TabsWindow:CreateTab({
	Name = "Admin",
})

Admin:Separator({ Text = "Command Hub" })

Admin:Button({
	Text = "Infinite Yield",
	Callback = function()
		loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end,
})

-- Save / Export

local SaveTab = TabsWindow:CreateTab({
	Name = "Saveinstance",
})

SaveTab:Separator({ Text = "Saveinstance" })

SaveTab:Label({
	Text = "Map Name",
})

local MapNameInput = SaveTab:InputText({
	Label = "",
	Value = "",
})

SaveTab:Button({
	Text = "SaveInstance",
	Callback = function()
		local synsaveinstance = loadstring(
			game:HttpGetAsync(
				"https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/saveinstance.luau",
				true
			)
		)()

		local Options = {
			FilePath = MapNameInput.Value or "Test", -- FileName
			SafeMode = false, -- Bypass detection by temporarily kicking before saving
			Decompile = true, -- Decompile LocalScripts (if executor supports it)
			SaveBytecode = false, -- Include bytecode for later decompilation
			timeout = 15, -- Timeout in seconds for decompiling
			Threads = 80, -- Number of threads to use (adjust based on CPU)
			MaxThreads = 80,
			TreatUnionsAsParts = true, -- Converts UnionParts for executors that don't support them
			ShowStatus = true, -- Displays progress in console
			NilInstances = true, -- Save instances that aren't Parented (Parented to nil). Default

			DecompileIgnore = { "Chat", "CoreGui", "CorePackages" },
			RemovePlayerCharacters = true,
			SavePlayers = true,
			IgnoreDefaultProps = true,
			IsolateStarterPlayer = true,
		}

		synsaveinstance(Options)
	end,
})
