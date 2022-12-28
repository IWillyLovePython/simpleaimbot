keybind = Enum.UserInputType.MouseButton2
local camera = game.Workspace.Camera
local localplayer = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

local aiming = false
function closestplayer()
	local dist = math.huge -- math.huge means a really large number, 1M+.
	local target = nil --- nil means no value
	for i,v in pairs (game:GetService("Players"):GetPlayers()) do
		if v ~= localplayer then
		    print(v.Character, v.Character:FindFirstChild("Head"), aiming, v.Character.Humanoid.Health > 0)
			if v.Character and v.Character:FindFirstChild("Head") and aiming and v.Character.Humanoid.Health > 0 then --- creating the checks
				local magnitude = (v.Character.Head.Position - localplayer.Character.Head.Position).magnitude
				if magnitude < dist then
					dist = magnitude
					target = v
				end
			end
		end
	end
	return target
end

UIS.InputBegan:Connect(function(inp)
	if inp.UserInputType == keybind then
		aiming = true
	end
end)

UIS.InputEnded:Connect(function(inp)
	if inp.UserInputType == keybind then ---- when we stop pressing the keybind it would unlock off the player
		aiming = false
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if aiming then
		camera.CFrame = CFrame.new(camera.CFrame.Position, closestplayer().Character.Head.Position) -- locks into the HEAD
	end
end)
