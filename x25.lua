--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vector = Vector3.new
local DigReplicate = ReplicatedStorage.Remotes:WaitForChild("Dig_Replicate")
local DigFinished = ReplicatedStorage.Remotes:WaitForChild("Dig_Finished")

--// Hook Dig_Replicate to trigger Dig_Finished
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
local args = { ... }
local method = getnamecallmethod():lower()

if not checkcaller() and self == DigReplicate and method == "fireserver" then
		-- Call Dig_Finished shortly after the dig
	task.delay(0.1, function()
		local digArgs = {
			0,
			{
				{
					Orientation = vector(),
					Transparency = 1,
					Name = "PositionPart",
					Position = vector(2091.24365234375, 108.72087097167969, -431.48492431640625),
					Color = Color3.new(0.639, 0.635, 0.647),
					Material = Enum.Material.Plastic,
					Shape = Enum.PartType.Block,
					Size = vector(0.1, 0.1, 0.1)
				},
				{
					Orientation = vector(0, 90, 90),
					Transparency = 0,
					Name = "CenterCylinder",
					Position = vector(2091.24365234375, 108.67086791992188, -431.48492431640625),
					Color = Color3.new(0.462, 0.392, 0.290),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Cylinder,
					Size = vector(0.2, 8.546, 8.396)
				},
				{
					Orientation = vector(-16, 45, 0),
					Transparency = 0,
					Name = "Rock/1",
					Position = vector(2094.6296, 107.7228, -428.1008),
					Color = Color3.new(0.690, 0.584, 0.435),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector(8.2749, 3.397, 4.1126)
				},
				{
					Orientation = vector.create(-22, 75, 0),
					Transparency = 0,
					Name = "Rock/2",
					Position = vector.create(2095.9462890625, 108.13976287841797, -430.224853515625),
					Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(4.746952533721924, 3.397007942199707, 4.386020183563232)
				},
				{
					Orientation = vector.create(-32, 105, 0),
					Transparency = 0,
					Name = "Rock/3",
					Position = vector.create(2095.98486328125, 108.84673309326172, -432.7551574707031),
					Color = Color3.new(0.6901960968971252, 0.5843137502670288, 0.43529412150382996),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(7.141256332397461, 3.397007942199707, 5.160921096801758)
				},
				{
					Orientation = vector.create(-18, 134.99600219726562, 0),
					Transparency = 0,
					Name = "Rock/4",
					Position = vector.create(2094.649658203125, 107.86090850830078, -434.8918151855469),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(5.780846118927002, 3.397007942199707, 4.349738121032715)
				},
				{
					Orientation = vector.create(-25, 164.9929962158203, 0),
					Transparency = 0,
					Name = "Rock/5",
					Position = vector.create(2092.5087890625, 108.35107421875, -436.2110900878906),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(7.950542449951172, 3.397007942199707, 4.5068359375)
				},
				{
					Orientation = vector.create(-21, -164.9929962158203, 0),
					Transparency = 0,
					Name = "Rock/6",
					Position = vector.create(2089.984375, 108.06979370117188, -436.17730712890625),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(6.269765853881836, 3.397007942199707, 4.623900413513184)
				},
				{
					Orientation = vector.create(-32, -134.99600219726562, 0),
					Transparency = 0,
					Name = "Rock/7",
					Position = vector.create(2087.7734375, 108.84673309326172, -434.95526123046875),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(5.9692606925964355, 3.397007942199707, 5.757662296295166)
				},
				{
					Orientation = vector.create(-21, -105, 0),
					Transparency = 0,
					Name = "Rock/8",
					Position = vector.create(2086.5546875, 108.06979370117188, -432.7425231933594),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(7.190993785858154, 3.397007942199707, 4.412728309631348)
				},
				{
					Orientation = vector.create(-26, -75, 0),
					Transparency = 0,
					Name = "Rock/9",
					Position = vector.create(2086.511474609375, 108.42169952392578, -430.2170715332031),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(4.7241716384887695, 3.397007942199707, 4.117498397827148)
				},
				{
					Orientation = vector.create(-19, -45.00400161743164, 0),
					Transparency = 0,
					Name = "Rock/10",
					Position = vector.create(2087.82958984375, 107.9303207397461, -428.06805419921875),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(4.726218223571777, 3.397007942199707, 4.917757034301758)
				},
				{
					Orientation = vector.create(-27, -15.006999969482422, 0),
					Transparency = 0,
					Name = "Rock/11",
					Position = vector.create(2089.971923828125, 108.49239349365234, -426.7483215332031),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(3.8894240856170654, 3.397007942199707, 4.652950763702393)
				},
				{
					Orientation = vector.create(-31, 15.006999969482422, 0),
					Transparency = 0,
					Name = "Rock/12",
					Position = vector.create(2092.517578125, 108.77593231201172, -426.74237060546875),
					Color = Color3.new(0.6039215922355652, 0.5098039507865906, 0.3803921639919281),
					Material = Enum.Material.Pebble,
					Shape = Enum.PartType.Block,
					Size = vector.create(7.467870235443115, 3.397007942199707, 4.717135906219482)
				}
			}
			DigFinished:FireServer(unpack(digArgs))
			print("✅ Sent Dig_Finished after Dig_Replicate")
		end)
	end

	return oldNamecall(self, ...)
end)

print("📦 Auto Dig_Finished system loaded.")
