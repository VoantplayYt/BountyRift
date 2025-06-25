-- Bounty Egg
-- DC | Austin11111888
-- Updated | V.5
-- Report Issues To Me | Thank You
if game.PlaceId == 85896571713843 then
	repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
	task.wait(2)

	--// Services \--
	local v_001 = game:GetService("Players")
	local v_002 = game:GetService("TeleportService")
	local v_003 = game:GetService("TweenService")
	local v_004 = game:GetService("RunService")
	local v_005 = game:GetService("Workspace")
	local v_006 = game:GetService("ReplicatedStorage")
	local v_007 = v_001.LocalPlayer

	--// Config \--
	local v_008 = true
	local v_009 = {"x10","x25"}
	local v_010 = require(v_006.Shared.Utils.Stats.SecretBountyUtil)
	local v_011 = v_010.Egg

	local v_012 = {
		["Crystal Egg"] = "crystal-egg",
		["Rainbow Egg"] = "rainbow-egg",
		["Mining Egg"] = "mining-egg",
		["Void Egg"] = "void-egg",
		["Lunar Egg"] = "lunar-egg",
		["Common Egg"] = "common-egg",
		["Cyber Egg"] = "cyber-egg",
		["Spotted Egg"] = "spotted-egg",
		["Iceshard Egg"] = "iceshard-egg",
		["Spikey Egg"] = "spikey-egg",
		["Magma Egg"] = "magma-egg",
		["Hell Egg"] = "hell-egg",
		["Nightmare Egg"] = "nightmare-egg",
		["Showman Egg"] = "showman-egg",
		["Neon Egg"] = "neon-egg"
	}

	--// References \--
	local v_013 = v_005.Worlds["The Overworld"].Islands
	local v_014 = v_005:WaitForChild("Rendered"):WaitForChild("Rifts")
	local v_015 = v_006:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent")

	local v_016 = {
		Floating = {
			Position = v_013["Floating Island"].Island.Input.Position,
			v_015 = "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn"
		},
		Space = {
			Position = v_013["Outer Space"].Island.Input.Position,
			v_015 = "Workspace.Worlds.The Overworld.Islands.Outer Space.Island.Portal.Spawn"
		},
		Twilight = {
			Position = v_013["Twilight"].Island.Input.Position,
			v_015 = "Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn"
		},
		Void = {
			Position = v_013["The Void"].Island.Input.Position,
			v_015 = "Workspace.Worlds.The Overworld.Islands.The Void.Island.Portal.Spawn"
		},
		Zen = {
			Position = v_013["Zen"].Island.Input.Position,
			v_015 = "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"
		}
	}

	--// Helper Functions \--
	local function getClosestIsland(targetPosition)
		local v_017 = nil
		local v_018 = math.huge

		for key, v_044 in pairs(v_016) do
			local v_019 = (targetPosition - v_044.Position).Magnitude
			if v_019 < v_018 then
				v_018 = v_019
				v_017 = key
			end
		end

		return v_017, v_018
	end

	local function tweenToRift(target)
		if not (target and target:IsA("BasePart")) then
			warn("⚠️ Invalid Target Passed To Function")
			return
		end

		local v_020 = v_007.Character or v_007.CharacterAdded:Wait()
		local v_021 = v_020:FindFirstChild("HumanoidRootPart")
		if not v_021 then
			warn("⚠️ HumanoidRootPart Not Found")
			return
		end

		local v_022 = v_021.Position
		local v_023 = target.Position + Vector3.new(0, 10, 0)
		local v_024 = (v_022 - v_023).Magnitude

		local v_025 = 35
		local v_026 = math.clamp(v_024 / v_025, 4, 35)
		local v_027 = v_024 / v_026

		local v_028 = (v_023 - v_022).Unit
		local v_029 = tick()

		local v_030
		v_030 = v_004.Heartbeat:Connect(function()
			local v_031 = tick() - v_029
			local v_032 = math.min(v_031 * v_027, v_024)
			local v_033 = v_022 + v_028 * v_032

			v_021.CFrame = CFrame.new(v_033, v_033 + v_021.CFrame.LookVector)

			if v_032 >= v_024 then
				v_030:Disconnect()
				print(string.format("✅ Arrived At %s (%.2f studs)", target.Name, v_024))
			end
		end)

		print(string.format("🚶 Moving To Rift '%s' Over %.2f Seconds (%.2f studs)", target.Name, v_026, v_024))
	end

	local function formatTime(seconds)
		local v_035 = math.floor(seconds / 60)
		local v_036 = seconds % 60
		return string.format("%d minute%s %d second%s", v_035, v_035 ~= 1 and "s" or "", v_036, v_036 ~= 1 and "s" or "")
	end

	--// Main Loop \--
	while true do
		task.wait(0.2)
		local v_037 = false
		local v_038 = v_012[v_011]
		print(v_011)
--[[
		if v_038 then
			for _, rift in pairs(v_014:GetChildren()) do
				if rift.Name == v_038 then
					v_037 = true

					local v_039 = rift:GetAttribute("DespawnAt")
					local v_040 = math.max(0, math.floor(v_039 - os.time()))
					local v_041 = formatTime(v_040)

					local function getRiftMulti()
						return rift:FindFirstChild("Display")
							and rift.Display:FindFirstChild("SurfaceGui")
							and rift.Display.SurfaceGui:FindFirstChild("Icon")
							and rift.Display.SurfaceGui.Icon:FindFirstChild("Luck")
							and rift.Display.SurfaceGui.Icon.Luck.Text
					end

					local v_042 = getRiftMulti()
					if not table.find(v_009, v_042) then
						warn(string.format("❌ Multiplier '%s' not allowed. Kicking v_007...", v_042 or "NIL"))
						v_007:Kick("❌\n Bounty Rift multiplier not allowed.\nRejoining...")
						task.wait(0.2)
						v_002:Teleport(game.PlaceId, v_007)
						break
					end

					local v_043 = rift:FindFirstChild("Output")
					if v_043 and v_043:IsA("BasePart") then
						local v_017, distance = getClosestIsland(v_043.Position)

						if v_017 then
							local v_044 = v_016[v_017]
							print(string.format("📍 Closest island to '%s' Output is: %s (%.2f studs away)", rift.Name, v_017, distance))

							v_015:FireServer("Teleport", v_044.v_015)
							task.wait(2)
							tweenToRift(v_043)

							local v_034 = game:GetService("VirtualInputManager")
							task.spawn(function()
								while true do
									for i = 1, 5 do
										v_034:SendKeyEvent(true, Enum.KeyCode.E, false, game)
										task.wait(0.1)
										v_034:SendKeyEvent(false, Enum.KeyCode.E, false, game)
										task.wait(0.25)
									end
									task.wait(0.5)
								end
							end)

							task.spawn(function()
								while true do
									task.wait(0.2)
									if not v_043 or not v_043.Parent or not v_014:FindFirstChild(rift.Name) then
										warn("❌ Bounty Egg Despawned. Kicking v_007...")
										v_007:Kick("❌\n Bounty Egg Despawned.\nRejoining...")
										task.wait(0.2)
										v_002:Teleport(game.PlaceId, v_007)
										break
									end
								end
							end)
						else
							warn("⚠️ No Valid Island Positions To Compare.")
						end
					else
						warn("⚠️ No Output Found In Rift:", rift.Name)
					end

					break
				end
			end
		else
			warn("❌ Invalid v_011 value or not v_037 in v_012:", v_011)
		end

		if not v_037 and v_008 then
			warn("❌ Target Rift Not Found. Rejoining...")
			local msg = "❌\n Rift Not Found.\n" .. (v_011 and tostring(v_011) or "Unknown Rift")
			v_007:Kick(msg)
			task.wait(0.2)
			v_002:Teleport(game.PlaceId, v_007)
			break
		else
			break
		end ]]
	end
else
	return game.Players.LocalPlayer:Kick("❌ Invalid SessionID.")
end
