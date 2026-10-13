local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local connection

local function removeSpin(hrp)
    for _, v in pairs(hrp:GetChildren()) do
        if v.Name == "VelocitySpin" or v:IsA("AngularVelocity") or v:IsA("BodyAngularVelocity") then
            v:Destroy()
        end
    end
end

local function applySpin(character)
    local hrp = character:WaitForChild("HumanoidRootPart")
    removeSpin(hrp)
    
    local av = Instance.new("AngularVelocity")
    av.Name = "VelocitySpin"
    av.Attachment0 = hrp:WaitForChild("RootAttachment")
    av.AngularVelocity = Vector3.new(0, 999999, 0)
    av.MaxTorque = 999999
    av.Parent = hrp
end

if player.Character then
    applySpin(player.Character)
end

if connection then connection:Disconnect() end
connection = player.CharacterAdded:Connect(function(character)
    applySpin(character)
end)
