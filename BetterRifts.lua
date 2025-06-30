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
	local v_451 = game:GetService("HttpService")
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
		["Neon Egg"] = "neon-egg",
		["July Egg"] = { "festival-rift-1", "festival-rift-2", "festival-rift-3" }
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

	local function sendDiscordEggWebhook(eggName, luckMulti, timeLeft, height, placeId, jobId)
	local url = "https://discord.com/api/webhooks/1389075055157444710/5eHIwr_EIn3GBsDAZQyxXm-JNXZAFN7L_Y5CS6uE8Fzg4RrFzuvH3qGfrhN5Xty2zBf1"

	local data = {
		["embeds"] = {{
			["title"] = eggName .. " Found!!!",
			["description"] = "A(n) **" .. eggName .. "** Has Been Found!",
			["color"] = 16734296,
			["fields"] = {
				{
					["name"] = "Server Info",
					["value"] = "Players: " .. tostring(#game:GetService("Players"):GetPlayers()) .. "/12",
					["inline"] = true
				},
				{
					["name"] = "Rift Info",
					["value"] = "Luck Multi: " .. tostring(luckMulti) .. "\nExpires: " .. timeLeft .. "\nHeight: " .. tostring(height) .. " meters",
					["inline"] = true
				},
				{
					["name"] = "Join Script",
					["value"] = string.format("```lua\ngame:GetService(\"TeleportService\"):TeleportToPlaceInstance(%d, \"%s\")\n```", placeId, jobId),
					["inline"] = false
				},
				{
					["name"] = "Server Link",
					["value"] = "[Click to Join](https://www.roblox.com/games/" .. tostring(placeId) .. "?privateServerLinkCode=" .. jobId .. ")",
					["inline"] = false
				}
			},
			["footer"] = {
				["text"] = "Created By Austin | " .. os.date("%x %X")
			}
		}}
	}

	local headers = {
		["Content-Type"] = "application/json"
	}

	local payload = game:GetService("HttpService"):JSONEncode(data)

	syn.request({
		Url = url,
		Method = "POST",
		Headers = headers,
		Body = payload
	})
end


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
		local duration = 10
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

	local pressingE = false

	while true do
		task.wait(0.2)
		local found = false
		local eggNames = type(v_011) == "table" and v_011 or {v_011}
		local eggIDs = {}

		for _, name in ipairs(eggNames) do
			local ids = v_012[name]
			if typeof(ids) == "string" then
				table.insert(eggIDs, ids)
			elseif typeof(ids) == "table" then
				for _, id in ipairs(ids) do
					table.insert(eggIDs, id)
				end
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
						local closestIsland = getClosestIsland(output.Position)
						if closestIsland then
							v_015:FireServer("Teleport", v_016[closestIsland].v_015)
							task.wait(2)
							tweenToRift(output)

							if getRiftMulti() == "x25" then
								sendDiscordEggWebhook(rift.Name, getRiftMulti(), timeLeft, math.floor(rift.Position.Y), game.PlaceId, game.JobId)
							end

							if not pressingE then
								pressingE = true
								task.spawn(function()
									local vim = game:GetService("VirtualInputManager")
									while true do
										for _ = 1, 5 do
											vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
											task.wait(0.1)
											vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
											task.wait(0.25)
										end
										task.wait(0.5)
									end
								end)
							end

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
										tweenToRift(o)
									end
								end
							end)

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
			local displayEgg = type(v_011) == "string" and v_011 or "Unknown Egg"
			local v_941 = "❌\n Rift Not Found.\n" .. displayEgg
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
