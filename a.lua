-- =========================================================
-- DESTROY DEVICE SELECTION GUI
-- =========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function removeDeviceGui()
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            local name = gui.Name:lower()
            if string.find(name, "device") or string.find(name, "choose") or string.find(name, "start") or string.find(name, "menu") then
                gui:Destroy()
                print("[AutoDevice] Removed GUI: " .. gui.Name)
            end
        end
    end
end

task.spawn(function()
    while task.wait(0.5) do
        removeDeviceGui()
    end
end)
