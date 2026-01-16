-- @ScriptType: Script
local rep = game:GetService("ReplicatedStorage")

rep.Events.DoneLoading.OnServerEvent:Connect(function(player: Player, ...) 
	player.Character:WaitForChild("HumanoidRootPart").CFrame = workspace.SpawnPart.CFrame
end)