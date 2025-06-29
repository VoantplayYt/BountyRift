local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
getgenv().CurrentDigInfo = nil
getgenv().AutoInstantDig = false
local DigEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Dig_Replicate")
local LocalPlayer = Players.LocalPlayer
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
	local args = { ... }
	local method = getnamecallmethod():lower()
	if not checkcaller() and self == DigEvent and method == "fireserver" then
		if typeof(args[2]) == "table" and typeof(args[2][4]) == "table" then
			getgenv().CurrentDigInfo = {
				Character = args[2][1],
				Rarity = args[2][4].Rarity,
				Rock = args[2][4].Rock
			}
			local message = "Captured Dig: Rarity = " .. tostring(getgenv().CurrentDigInfo.Rarity)
			warn(message)
			StarterGui:SetCore("SendNotification", {
				Title = "Auto Dig",
				Text = message,
				Duration = 3
			})
		end
	end

	return oldNamecall(self, ...)
end)
task.spawn(function()
	while true do
		task.wait(0.1)
		if getgenv().AutoInstantDig and getgenv().CurrentDigInfo then
			local info = getgenv().CurrentDigInfo
			local args = {
				"Progress",
				{
					info.Character,
					100, -- High progress
					"Strong",
					{
						Rarity = info.Rarity,
						Rock = info.Rock
					}
				}
			}

			DigEvent:FireServer(unpack(args))
		end
	end
end)
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.K then
		getgenv().AutoInstantDig = not getgenv().AutoInstantDig
		local status = getgenv().AutoInstantDig and "ENABLED :white_check_mark:" or "DISABLED :x:"
		StarterGui:SetCore("SendNotification", {
			Title = "Auto Instant Dig",
			Text = status,
			Duration = 2
		})
		print("AutoInstantDig:", status)
	end
end)
StarterGui:SetCore("SendNotification", {
	Title = "Auto Instant Dig Loaded!",
	Text = "Press [K] to toggle",
	Duration = 4
})
