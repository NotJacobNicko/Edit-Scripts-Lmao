local Plr = game:GetService("Players").LocalPlayer
function LeechToPlayers(Char)
	local mainRoot = Plr.Character:FindFirstChild("Torso") or Plr.Character:FindFirstChild("HumanoidRootPart")
	local mainHum = Plr.Character:FindFirstChildWhichIsA("Humanoid")
	local ShouldStop = false
	if Char then
		local EnemyRoot = Char:FindFirstChild("Torso") or Char:FindFirstChild("HumanoidRootPart")
		local enemyHum = Char:FindFirstChildWhichIsA("Humanoid")
		local Con;
		
		
		
		Con = game:GetService("RunService").Heartbeat:Connect(function()
			if ShouldStop then
				mainHum.PlatformStand = false
				mainRoot.Anchored = false
				Con:Disconnect()
			else
				if EnemyRoot and mainRoot and (enemyHum and enemyHum.Health > 0) then
					mainHum.PlatformStand = true
					Plr.Character:PivotTo(EnemyRoot.CFrame*CFrame.new(0,0,4))
				else
					mainRoot.Anchored = true
					mainHum.PlatformStand = true
				end
			end
		end)
	end
	
	return {
		Runner = function(boolean)
			if type(boolean) ~= "boolean" then
				return
			end
			
			ShouldStop = boolean
		end,
		
	}
end

local GUI = Instance.new("ScreenGui",Plr.PlayerGui)
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
local FRame = Instance.new("Frame",GUI)
FRame.Size = UDim2.new(0,92,0,74)
FRame.BackgroundColor3 = Color3.new(0, 0, 0)
FRame.Position = UDim2.new(0.449, 0,0.773, 0)
FRame.Visible = true
local textbox = Instance.new("TextBox",FRame)
textbox.Size = UDim2.new(0,75,0,32)
textbox.BackgroundColor3 = Color3.new(0.133333, 1, 0)
textbox.Position = UDim2.new(0.086, 0,0.108, 0)
textbox.Visible = true
textbox.Text = ""
textbox.PlaceholderText = "Username"
textbox.PlaceholderColor3 = Color3.new(0, 0, 0)
local button = Instance.new("TextButton",FRame)
button.Size = UDim2.new(0,60,0,20)
button.BackgroundColor3 = Color3.new(0.133333, 1, 0)
button.Position = UDim2.new(0.176, 0,0.622, 0)
button.Text = "Toggle"
button.Visible = true
local Name = ""
textbox:GetPropertyChangedSignal("Text"):Connect(function()
	local Uh = tostring(textbox.Text)
	Name = Uh
end)
local Toogleee = false
local UH = nil
button.MouseButton1Click:Connect(function()
	if not Toogleee then
		if UH == nil then
			for i,v in pairs(workspace:GetDescendants()) do
				if v.Name == Name and v:IsA("Model") and (v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChildWhichIsA("Humanoid").Health > 0) then
					UH = LeechToPlayers(v)
					break
				end
			end
		end
		button.BackgroundColor3 = Color3.new(0,1,0)
		Toogleee = true
	else
		if UH then
			UH.Runner(true)
			UH = nil
		end
		button.BackgroundColor3 = Color3.new(1, 0, 0)
		Toogleee = false
	end
end)
