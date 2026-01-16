-- @ScriptType: LocalScript
local ts = game:GetService("TweenService")
local cp = game:GetService("ContentProvider")
local rep = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

local LoadingCameraPart = workspace:WaitForChild("LoadingCameraPart")
local LoadingBG = script.Parent:WaitForChild("LoadingBG")
local LoadingBar = script.Parent:WaitForChild("LoadingBar")
local Camera = workspace.CurrentCamera

local BGFadeOut = ts:Create(LoadingBG, TweenInfo.new(2), {["BackgroundTransparency"] = 1})
local BGFadeIn = ts:Create(LoadingBG, TweenInfo.new(2), {["BackgroundTransparency"] = 0})

local ToLoad = {
	workspace:WaitForChild("Terrain"),
	plr.PlayerGui
}

if not game:IsLoaded() then
	game.Loaded:Wait()
end

Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = LoadingCameraPart.CFrame

BGFadeOut:Play()

for i, asset in ipairs(ToLoad) do
	LoadingBar.Size = UDim2.new(i/#ToLoad, 0, 1, 0)
	cp:PreloadAsync(asset)
end

--when done loading
LoadingBG.ZIndex = 2
BGFadeIn:Play()
BGFadeIn.Completed:Wait()

rep.Events.DoneLoading:FireServer()

BGFadeOut:Play()

script.Parent:Destroy()