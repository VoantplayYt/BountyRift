-- Bounty Egg
-- DC | Austin11111888
-- Test 5
-- Report Issues To Me | Thank You
if game.PlaceId == 85896571713843 then
	repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
	task.wait(0.1)

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
	local v_242 = {"x5", "x10", "x25"}
	local v_009 = getgenv().Multi or v_242
	local v_010 = require(v_006.Shared.Utils.Stats.SecretBountyUtil)
	local v_999 = v_010.Get()
	local v_011 = getgenv().EggOverride or v_999.Egg

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

	local function getClosestIsland(targetPosition)
		local closest, shortestDist = nil, math.huge
		for key, data in pairs(v_016) do
			local dist = (targetPosition - data.Position).Magnitude
			if dist < shortestDist then
				shortestDist = dist
				closest = key
			end
		end
		return closest, shortestDist
	end

	local function tweenToRift(target)
	if not (target and target:IsA("BasePart")) then return end
	local char = v_007.Character or v_007.CharacterAdded:Wait()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local start = hrp.Position
	local goal = target.Position + Vector3.new(0, 15, 0)
	local duration = 10 -- total travel time
	local direction = (goal - start)
	local startTime = tick()

	local function easeOutQuad(t)
		return 1 - (1 - t)^2
	end

	local conn
	conn = v_004.Heartbeat:Connect(function()
		local elapsed = tick() - startTime
		local alpha = math.clamp(elapsed / duration, 0, 1)
		local easedAlpha = easeOutQuad(alpha)
		local newPos = start + direction * easedAlpha
		hrp.CFrame = CFrame.new(newPos, newPos + hrp.CFrame.LookVector)

		if alpha >= 1 then
			conn:Disconnect()
			task.wait(0.2)
			if hrp then hrp.Anchored = true end
		end
	end)
end



	local function formatTime(seconds)
		local m = math.floor(seconds / 60)
		local s = seconds % 60
		return string.format("%d minute%s %d second%s", m, m ~= 1 and "s" or "", s, s ~= 1 and "s" or "")
	end

	while true do
		task.wait(0.2)
		local found = false
		local eggNames = type(v_011) == "table" and v_011 or {v_011}
		local eggIDs = {}
		for _, name in ipairs(eggNames) do
			local id = v_012[name]
			if id then
				table.insert(eggIDs, id)
			end
		end
		if #eggIDs > 0 then
			for _, rift in pairs(v_014:GetChildren()) do
				if table.find(eggIDs, rift.Name) then
					found = true
					local despawnTime = math.max(0, math.floor(rift:GetAttribute("DespawnAt") - os.time()))
					local timeLeft = formatTime(despawnTime)

					local function getRiftMulti()
						return rift:FindFirstChild("Display")
							and rift.Display:FindFirstChild("SurfaceGui")
							and rift.Display.SurfaceGui:FindFirstChild("Icon")
							and rift.Display.SurfaceGui.Icon:FindFirstChild("Luck")
							and rift.Display.SurfaceGui.Icon.Luck.Text
					end

					local multiplier = getRiftMulti()
					if not table.find(v_009, multiplier) then
						v_007:Kick("❌\n Bounty Rift multiplier not allowed.\nRejoining...")
						task.wait(0.2)
						v_002:Teleport(game.PlaceId, v_007)
						break
					end

					local output = rift:FindFirstChild("Output")
					if output and output:IsA("BasePart") then
						local closestIsland, dist = getClosestIsland(output.Position)
						if closestIsland then
							v_015:FireServer("Teleport", v_016[closestIsland].v_015)
							task.wait(2)
							tweenToRift(output, 500)

							-- Start pressing E
							task.spawn(function()
								local vim = game:GetService("VirtualInputManager")
								while true do
									for i = 1, 5 do
										vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
										task.wait(0.1)
										vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
										task.wait(0.25)
									end
									task.wait(0.5)
								end
							end)

							-- Despawn Monitor
							task.spawn(function()
								while true do
									task.wait(0.2)
									local r = v_014:FindFirstChild(rift.Name)
									local o = r and r:FindFirstChild("Output")
									if not r or not o or not o:IsA("BasePart") then
										v_007:Kick("❌\n Bounty Egg Despawned.\nRejoining...")
										task.wait(0.2)
										v_002:Teleport(game.PlaceId, v_007)
										break
									end
								end
							end)

							-- Distance Watchdog
							task.spawn(function()
								while true do
									task.wait(0.5)
									local char = v_007.Character
									local hrp = char and char:FindFirstChild("HumanoidRootPart")
									local r = v_014:FindFirstChild(rift.Name)
									local o = r and r:FindFirstChild("Output")
									if not hrp or not o then break end
									local dist = (hrp.Position - o.Position).Magnitude
									if dist > 15 then
										tweenToRift(o, 50)
									end
								end
							end)

							-- Timeout Failsafe
							task.delay(610, function()
								if v_007 and v_007.Parent then
									v_007:Kick("❌\n Hatch Timeout.\nRejoining...")
									task.wait(0.2)
									v_002:Teleport(game.PlaceId, v_007)
								end
							end)
						end
					end
					break
				end
			end
		else
			v_007:Kick("❌ Invalid Egg")
		end

		if not found and v_008 then
			local v_941 = "❌\n Rift Not Found.\n" .. v_011 or "Unknown Egg"
			v_007:Kick(v_941)
			task.wait(0.2)
			v_002:Teleport(game.PlaceId, v_007)
			break
		else
			break
		end
	end
else
	game.Players.LocalPlayer:Kick("❌ Invalid SessionID.")
end
