-- =========================================================
-- MURDER MYSTERY 2 - AUTO SELECT PHONE
-- =========================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function bypassMM2Device()
    -- 1. Fires MM2's specific RemoteEvent for device selection
    local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("Services")
    if remotes then
        local deviceRemote = remotes:FindFirstChild("DeviceSelect") or remotes:FindFirstChild("SelectDevice")
        if deviceRemote and deviceRemote:IsA("RemoteEvent") then
            pcall(function()
                deviceRemote:FireServer("Phone")
            end)
        end
    end

    -- 2. Finds MM2's Device GUI and forces the Phone button click
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if gui.Name == "LoadingGUI" or gui.Name == "DeviceGUI" or string.find(gui.Name:lower(), "device") then
            
            -- Searches for the Phone Button inside MM2 GUI
            for _, btn in ipairs(gui:GetDescendants()) do
                if (btn:IsA("TextButton") or btn:IsA("ImageButton")) and string.find(btn.Name:lower(), "phone") then
                    
                    if getconnections then
                        for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
                            conn:Fire()
                        end
                        for _, conn in ipairs(getconnections(btn.Activated)) do
                            conn:Fire()
                        end
                    end

                end
            end
            
            -- Destroy the loading frame so it stops blocking the screen
            gui:Destroy()
            print("[MM2 Bypass] Phone selected & LoadingGUI removed!")
            return true
        end
    end
    return false
end

-- Loop to ensure it triggers as soon as MM2 loads upon rejoin
task.spawn(function()
    for i = 1, 20 do
        if bypassMM2Device() then
            break
        end
        task.wait(0.3)
    end
end)

-- Listens for rejoin / respawn screen additions
PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "LoadingGUI" or string.find(child.Name:lower(), "device") then
        task.wait(0.1)
        bypassMM2Device()
    end
end)
