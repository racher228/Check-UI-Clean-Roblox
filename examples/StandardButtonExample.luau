--!strict
-- StandardButtonExample.luau
-- Standalone, production-ready Check-UI Canonical Standard Iconless Button.
-- MANDATORY STANDARD: Any button requested without an icon MUST follow this exact design and structure.
--
-- Features verified against live Studio benchmark:
-- - Sharp 90-degree comic rectangular geometry (no UICorner)
-- - 3px solid dark charcoal border (#0C141A)
-- - 90-degree linear color gradient
-- - Subtle black checkerboard overlay (Tile: 19x19, UIGradient fade: 0.91 -> 0.62)
-- - Triple-layered specular inner highlight frames (InnerHighlight1, 2, 3)
-- - Centered GothamBlack white text with 3px #11171A contextual stroke & 1px optical offset
-- - Center-anchored ButtonScale (UIScale) with tactile 4-state micro-interactions

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local CheckUI = require(ReplicatedStorage.CheckUI.CheckUIComponents)
local Theme = require(ReplicatedStorage.CheckUI.CheckUITheme)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StandardButtonShowcase"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Device-responsive scaling engine
local camera = workspace.CurrentCamera
local deviceScale = Instance.new("UIScale")
deviceScale.Name = "DeviceScale"
deviceScale.Scale = 1
deviceScale.Parent = screenGui

local function updateScale()
    local vp = camera.ViewportSize
    if vp.X <= 0 or vp.Y <= 0 then return end
    local factor = math.min(vp.X / 1050, vp.Y / 620)
    deviceScale.Scale = math.clamp(factor, 0.52, 1.18)
end
updateScale()
camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

-- Sound assets
local hoverSound = Instance.new("Sound")
hoverSound.SoundId = Theme.Assets.HoverSound
hoverSound.Volume = 0.5
hoverSound.Parent = screenGui

local clickSound = Instance.new("Sound")
clickSound.SoundId = Theme.Assets.ClickSound
clickSound.Volume = 0.6
clickSound.Parent = screenGui

-- 1. Benchmark: "Throw" Button (Yellow-to-Orange Gradient)
local throwBtn = CheckUI.createStandardButton({
    Name = "ThrowButton",
    Size = UDim2.new(0, 176, 0, 55),
    Position = UDim2.new(0.5, 0, 0.40, 0),
    Text = "Throw",
    TextSize = 36,
    Gradient = Theme.ButtonGradients.YellowOrange,
    Parent = screenGui,
    HoverSound = hoverSound,
    ClickSound = clickSound,
})

-- 2. "Claim" Button (Lime Green Gradient)
local claimBtn = CheckUI.createStandardButton({
    Name = "ClaimButton",
    Size = UDim2.new(0, 176, 0, 55),
    Position = UDim2.new(0.5, 0, 0.50, 0),
    Text = "Claim",
    TextSize = 34,
    Gradient = Theme.ButtonGradients.LimeGreen,
    Parent = screenGui,
    HoverSound = hoverSound,
    ClickSound = clickSound,
})

-- 3. "Redeem" Button (Electric Cyan Gradient)
local redeemBtn = CheckUI.createStandardButton({
    Name = "RedeemButton",
    Size = UDim2.new(0, 176, 0, 55),
    Position = UDim2.new(0.5, 0, 0.60, 0),
    Text = "Redeem",
    TextSize = 34,
    Gradient = Theme.ButtonGradients.ElectricCyan,
    Parent = screenGui,
    HoverSound = hoverSound,
    ClickSound = clickSound,
})

-- Click Handler Example
throwBtn.MouseButton1Click:Connect(function()
    print("[Check-UI] Throw button clicked!")
end)

return screenGui
