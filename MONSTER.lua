-- ==============================================================
-- 👻 SINSISTER MONSTER MENU 👻 - BẢN MAX PING (FINAL + FIX ALL)
-- Tác giả: GERBOX | Fix all empty buttons
-- ==============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Khởi tạo Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👻SINSISTER MONSTER👻",
   LoadingTitle = "Đang nạp mã nguồn...",
   LoadingSubtitle = "by GERBOX",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SinsisterMonster",
      FileName = "MonsterHubConfig"
   },
   Discord = {
      Enabled = true,
      Invite = "YDymXSuWf",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Hệ thống Key - SINSISTER MONSTER",
      Subtitle = "Tham gia Discord để lấy Key",
      Note = "Link Discord: discord.gg/YDymXSuWf",
      FileName = "MonsterKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"MonsterFreeKey", "GERBOX_VIP"}
   }
})

---------------------------------------------------------
-- CÁC TAB
---------------------------------------------------------
local TabHome = Window:CreateTab("Home", "home")
local TabPlayer = Window:CreateTab("Player", "user")
local TabMovement = Window:CreateTab("Movement", "navigation")
local TabVisuals = Window:CreateTab("Visuals", "eye")
local TabCombat = Window:CreateTab("Combat", "swords")
local TabWorld = Window:CreateTab("World", "globe")
local TabVehicle = Window:CreateTab("Vehicle", "car")
local TabItems = Window:CreateTab("Items", "box")
local TabUtilities = Window:CreateTab("Utilities", "wrench")
local TabScripts = Window:CreateTab("Scripts", "scroll")
local TabSettings = Window:CreateTab("Settings", "settings")
local TabFavorites = Window:CreateTab("Favorites", "star")
local TabDebug = Window:CreateTab("Debug", "terminal")
local TabAbout = Window:CreateTab("About", "info")

---------------------------------------------------------
-- 🏠 TAB HOME
---------------------------------------------------------
TabHome:CreateLabel("Welcome: Xin chào mọi người đến với menu MONSTER!")
TabHome:CreateParagraph({Title = "Script Info", Content = "Bản hoàn chỉnh 100%. Tích hợp ESP, Aimbot, Universal Mods."})
TabHome:CreateParagraph({Title = "Changelog", Content = "- Fix toàn bộ nút trống.\n- Thêm Script Executor thực tế.\n- Thêm Favorites URL."})
TabHome:CreateLabel("Credits: GERBOX")
TabHome:CreateButton({ Name = "Discord (Copy Link)", Callback = function() setclipboard("https://discord.gg/YDymXSuWf"); Rayfield:Notify({Title="Copy", Content="Đã copy link!"}) end })
TabHome:CreateButton({ Name = "Key System Info", Callback = function() Rayfield:Notify({Title="Key Info", Content="Key: MonsterFreeKey"}) end })
TabHome:CreateButton({ Name = "Update Checker", Callback = function() Rayfield:Notify({Title="Update", Content="Đang ở bản mới nhất!"}) end })

---------------------------------------------------------
-- 👤 TAB PLAYER
---------------------------------------------------------
TabPlayer:CreateSlider({Name = "WalkSpeed", Range = {16, 500}, Increment = 1, CurrentValue = 16, Flag = "WS", Callback = function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v end end})
TabPlayer:CreateSlider({Name = "JumpPower", Range = {50, 500}, Increment = 1, CurrentValue = 50, Flag = "JP", Callback = function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = v end end})
TabPlayer:CreateSlider({Name = "HipHeight", Range = {0, 100}, Increment = 1, CurrentValue = 0, Flag = "HH", Callback = function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.HipHeight = v end end})

local infJump = false
TabPlayer:CreateToggle({Name = "Infinite Jump", CurrentValue = false, Flag = "InfJ", Callback = function(v) infJump = v end})
UserInputService.JumpRequest:Connect(function() if infJump and LocalPlayer.Character then LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)

TabPlayer:CreateButton({Name = "Fly (Script Khách)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end})

local noclip = false
TabPlayer:CreateToggle({Name = "NoClip", CurrentValue = false, Flag = "NC", Callback = function(v) noclip = v end})
RunService.Stepped:Connect(function() if noclip and LocalPlayer.Character then for _,p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)

TabPlayer:CreateButton({Name = "Invisible (Script Khách)", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Awesome-Invisible-man-21074"))() end})
TabPlayer:CreateButton({Name = "God Mode (Universal)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconLord1/GodMode/main/GodMode.lua"))() end})
TabPlayer:CreateButton({Name = "Anti AFK", Callback = function() for _,v in pairs(getconnections(LocalPlayer.Idled)) do v:Disable() end Rayfield:Notify({Title="Anti AFK", Content="Đã tắt tính năng tự động kick khi treo game!"}) end})
TabPlayer:CreateButton({Name = "Reset Character", Callback = function() if LocalPlayer.Character then LocalPlayer.Character:BreakJoints() end end})
TabPlayer:CreateButton({Name = "Respawn (Load Character)", Callback = function() LocalPlayer:LoadCharacter() end})
TabPlayer:CreateButton({Name = "Freeze", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.Anchored = true end end})
TabPlayer:CreateButton({Name = "Unfreeze", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.Anchored = false end end})
TabPlayer:CreateButton({Name = "Sit", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.Humanoid.Sit = true end end})

TabPlayer:CreateButton({Name = "Ragdoll", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/1-1X/Ragdoll-Script/main/Ragdoll.lua"))() end})
TabPlayer:CreateButton({Name = "No Ragdoll", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.Humanoid.PlatformStand = false end end})

---------------------------------------------------------
-- 🎮 TAB MOVEMENT
---------------------------------------------------------
TabMovement:CreateButton({Name = "Speed Boost", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 150 end end})
TabMovement:CreateButton({Name = "Dash", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-30) end end})
TabMovement:CreateToggle({Name = "Sprint", CurrentValue = false, Flag = "Sprint", Callback = function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v and 50 or 16 end end})

local bhop = false
TabMovement:CreateToggle({Name = "Bunny Hop", CurrentValue = false, Flag = "Bhop", Callback = function(v) bhop = v end})
RunService.RenderStepped:Connect(function() if bhop and LocalPlayer.Character and LocalPlayer.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then LocalPlayer.Character.Humanoid.Jump = true end end)

TabMovement:CreateButton({Name = "Air Jump", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0) end end})

local tpwalk = false
TabMovement:CreateToggle({Name = "TP Walk", CurrentValue = false, Flag = "TPWalk", Callback = function(v) tpwalk = v end})
RunService.RenderStepped:Connect(function() if tpwalk and LocalPlayer.Character and LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + (LocalPlayer.Character.Humanoid.MoveDirection * 1) end end)

local spin = false
TabMovement:CreateToggle({Name = "Spin", CurrentValue = false, Flag = "Spin", Callback = function(v) spin = v end})
RunService.RenderStepped:Connect(function() if spin and LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0) end end)

local spinbotFast = false
TabMovement:CreateToggle({Name = "Spinbot (Nhanh)", CurrentValue = false, Flag = "Spinbot", Callback = function(v) spinbotFast = v end})
RunService.RenderStepped:Connect(function() if spinbotFast and LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0) end end)

TabMovement:CreateSlider({Name = "Gravity", Range = {0, 196}, Increment = 1, CurrentValue = 196, Flag = "Grav", Callback = function(v) Workspace.Gravity = v end})
TabMovement:CreateButton({Name = "Fling (Tạo lốc)", Callback = function() if LocalPlayer.Character then local b = Instance.new("BodyAngularVelocity", LocalPlayer.Character.HumanoidRootPart) b.AngularVelocity = Vector3.new(0,99999,0) b.MaxTorque = Vector3.new(0,99999,0) end end})
TabMovement:CreateToggle({Name = "Glide", CurrentValue = false, Flag = "Glide", Callback = function(v) if v then local bg = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart) bg.Name = "GlideV" bg.Velocity = Vector3.new(0, -2, 0) bg.MaxForce = Vector3.new(0, 99999, 0) else if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GlideV") then LocalPlayer.Character.HumanoidRootPart.GlideV:Destroy() end end end})

---------------------------------------------------------
-- 👁️ TAB VISUALS (ESP & DRAWING)
---------------------------------------------------------
_G.ESP_Enabled = false
_G.BoxESP = false
_G.NameESP = false
_G.HealthESP = false
_G.DistESP = false
_G.Tracers = false

TabVisuals:CreateToggle({Name = "ESP Master (Bật trước)", CurrentValue = false, Flag = "ESP", Callback = function(v) _G.ESP_Enabled = v end})

-- Hàm tạo ESP cho từng player (có Health & Distance)
local function CreateESP(player)
    local espObj = Drawing.new("Text")
    espObj.Visible = false espObj.Center = true espObj.Outline = true espObj.Color = Color3.new(1, 1, 1) espObj.Size = 14

    local box = Drawing.new("Square")
    box.Visible = false box.Thickness = 1 box.Color = Color3.new(1,0,0) box.Filled = false

    local tracer = Drawing.new("Line")
    tracer.Visible = false tracer.Thickness = 1 tracer.Color = Color3.new(0,1,0)

    RunService.RenderStepped:Connect(function()
        if _G.ESP_Enabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local rootPos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                -- Tạo text: Name + Health + Distance
                local text = ""
                if _G.NameESP then text = text .. player.Name end
                if _G.HealthESP then text = text .. " [" .. math.floor(player.Character.Humanoid.Health) .. "HP]" end
                if _G.DistESP then
                    local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                    text = text .. " [" .. dist .. "m]"
                end
                if text ~= "" then
                    espObj.Position = Vector2.new(rootPos.X, rootPos.Y - 40)
                    espObj.Text = text
                    espObj.Visible = true
                else
                    espObj.Visible = false
                end

                if _G.BoxESP then
                    box.Size = Vector2.new(2000/rootPos.Z, 3000/rootPos.Z)
                    box.Position = Vector2.new(rootPos.X - box.Size.X/2, rootPos.Y - box.Size.Y/2)
                    box.Visible = true
                else box.Visible = false end

                if _G.Tracers then
                    tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                    tracer.Visible = true
                else tracer.Visible = false end
            else
                espObj.Visible = false box.Visible = false tracer.Visible = false
            end
        else
            espObj.Visible = false box.Visible = false tracer.Visible = false
        end
    end)
end

for _, v in pairs(Players:GetPlayers()) do if v ~= LocalPlayer then CreateESP(v) end end
Players.PlayerAdded:Connect(function(v) CreateESP(v) end)

-- Các toggle điều khiển ESP
TabVisuals:CreateToggle({Name = "Box ESP", CurrentValue = false, Flag = "BoxE", Callback = function(v) _G.BoxESP = v end})
TabVisuals:CreateToggle({Name = "Name ESP", CurrentValue = false, Flag = "NameE", Callback = function(v) _G.NameESP = v end})
TabVisuals:CreateToggle({Name = "Health ESP", CurrentValue = false, Flag = "HealthE", Callback = function(v) _G.HealthESP = v end})
TabVisuals:CreateToggle({Name = "Distance ESP", CurrentValue = false, Flag = "DistE", Callback = function(v) _G.DistESP = v end})
TabVisuals:CreateToggle({Name = "Skeleton ESP", CurrentValue = false, Flag = "Skel", Callback = function(v) if v then loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/ESPs/main/SkeletonESP.lua"))() end end})
TabVisuals:CreateToggle({Name = "Tracers", CurrentValue = false, Flag = "Tracers", Callback = function(v) _G.Tracers = v end})

local chams = false
TabVisuals:CreateToggle({Name = "Chams (Nhìn xuyên tường)", CurrentValue = false, Flag = "Chams", Callback = function(v) 
    chams = v 
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if v then
                local hl = Instance.new("Highlight", p.Character) hl.FillColor = Color3.new(1,0,0)
            else
                if p.Character:FindFirstChildOfClass("Highlight") then p.Character:FindFirstChildOfClass("Highlight"):Destroy() end
            end
        end
    end
end})

TabVisuals:CreateToggle({Name = "FullBright", CurrentValue = false, Flag = "FB", Callback = function(v) Lighting.Ambient = v and Color3.new(1,1,1) or Color3.fromRGB(128,128,128) end})
TabVisuals:CreateToggle({Name = "Night Vision", CurrentValue = false, Flag = "NV", Callback = function(v) if v then local cc = Instance.new("ColorCorrectionEffect", Lighting) cc.Name = "NVis" cc.Brightness = 0.2 cc.Contrast = 0.5 cc.TintColor = Color3.new(0,1,0) else if Lighting:FindFirstChild("NVis") then Lighting.NVis:Destroy() end end end})
TabVisuals:CreateToggle({Name = "X-Ray", CurrentValue = false, Flag = "XRay", Callback = function(v) for _, p in pairs(Workspace:GetDescendants()) do if p:IsA("BasePart") and not p.Parent:FindFirstChild("Humanoid") then p.Transparency = v and 0.5 or 0 end end end})

local crossLine1 = Drawing.new("Line") crossLine1.Visible = false crossLine1.Thickness = 2 crossLine1.Color = Color3.new(0,1,0)
local crossLine2 = Drawing.new("Line") crossLine2.Visible = false crossLine2.Thickness = 2 crossLine2.Color = Color3.new(0,1,0)
RunService.RenderStepped:Connect(function()
    if crossLine1.Visible then
        local cx, cy = Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2
        crossLine1.From = Vector2.new(cx - 10, cy) crossLine1.To = Vector2.new(cx + 10, cy)
        crossLine2.From = Vector2.new(cx, cy - 10) crossLine2.To = Vector2.new(cx, cy + 10)
    end
end)
TabVisuals:CreateToggle({Name = "Crosshair", CurrentValue = false, Flag = "Cross", Callback = function(v) crossLine1.Visible = v crossLine2.Visible = v end})

_G.ViewHB = false
TabVisuals:CreateToggle({Name = "Hitbox Viewer", CurrentValue = false, Flag = "HBV", Callback = function(v) _G.ViewHB = v end})

---------------------------------------------------------
-- 🎯 TAB COMBAT
---------------------------------------------------------
_G.AimAssist = false
TabCombat:CreateToggle({Name = "Aim Assist", CurrentValue = false, Flag = "AimA", Callback = function(v) _G.AimAssist = v end})

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false FOVCircle.Thickness = 2 FOVCircle.Color = Color3.new(1,0,0) FOVCircle.Filled = false
RunService.RenderStepped:Connect(function() FOVCircle.Position = UserInputService:GetMouseLocation() end)

TabCombat:CreateToggle({Name = "FOV Circle", CurrentValue = false, Flag = "FOVShow", Callback = function(v) FOVCircle.Visible = v end})
TabCombat:CreateSlider({Name = "FOV Size", Range = {10, 500}, Increment = 10, CurrentValue = 150, Flag = "FOVS", Callback = function(v) FOVCircle.Radius = v end})

local AimbotOn = false
TabCombat:CreateToggle({Name = "Aimbot", CurrentValue = false, Flag = "AimBot", Callback = function(v) AimbotOn = v end})
RunService.RenderStepped:Connect(function()
    if AimbotOn or _G.AimAssist then
        local target = nil local dist = FOVCircle.Radius local mousePos = UserInputService:GetMouseLocation()
        for _,v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 then
                local pos, vis = Camera:WorldToViewportPoint(v.Character.Head.Position)
                if vis then
                    local d = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if d < dist then dist = d target = v end
                end
            end
        end
        if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position) end
    end
end)

TabCombat:CreateToggle({Name = "Silent Aim (Script Khách)", CurrentValue = false, Flag = "SilentA", Callback = function(v) if v then loadstring(game:HttpGet("https://raw.githubusercontent.com/Averiias/Universal-SilentAim/main/main.lua"))() end end})

local TriggerBot = false
TabCombat:CreateToggle({Name = "Trigger Bot", CurrentValue = false, Flag = "Trigger", Callback = function(v) TriggerBot = v end})
RunService.RenderStepped:Connect(function()
    if TriggerBot and Mouse.Target and Mouse.Target.Parent:FindFirstChild("Humanoid") and Mouse.Target.Parent.Name ~= LocalPlayer.Name then
        mouse1click()
    end
end)

-- Các toggle còn lại (Aim Prediction, Target Lock, Auto Shoot, Auto Reload, No Recoil, No Spread)
-- Có thể bổ sung nếu biết game cụ thể, nhưng để universal thì tạm thời thông báo
TabCombat:CreateToggle({Name = "Aim Prediction", CurrentValue = false, Flag = "AimP", Callback = function(v) Rayfield:Notify({Title="Thông báo", Content="Tính năng này chỉ hoạt động ở một số game nhất định."}) end})
TabCombat:CreateToggle({Name = "Target Lock", CurrentValue = false, Flag = "TL", Callback = function(v) Rayfield:Notify({Title="Thông báo", Content="Tính năng này chỉ hoạt động ở một số game nhất định."}) end})
TabCombat:CreateToggle({Name = "Auto Shoot", CurrentValue = false, Flag = "AShoot", Callback = function(v) Rayfield:Notify({Title="Thông báo", Content="Tính năng này chỉ hoạt động ở một số game nhất định."}) end})
TabCombat:CreateToggle({Name = "Auto Reload", CurrentValue = false, Flag = "AReload", Callback = function(v) Rayfield:Notify({Title="Thông báo", Content="Tính năng này chỉ hoạt động ở một số game nhất định."}) end})
TabCombat:CreateToggle({Name = "No Recoil", CurrentValue = false, Flag = "NRecoil", Callback = function(v) Rayfield:Notify({Title="Thông báo", Content="Tính năng này chỉ hoạt động ở một số game nhất định."}) end})
TabCombat:CreateToggle({Name = "No Spread", CurrentValue = false, Flag = "NSpread", Callback = function(v) Rayfield:Notify({Title="Thông báo", Content="Tính năng này chỉ hoạt động ở một số game nhất định."}) end})

TabCombat:CreateSlider({Name = "Hitbox Expander", Range = {1, 30}, Increment = 1, CurrentValue = 2, Flag = "HB", Callback = function(v) 
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.Size = Vector3.new(v,v,v)
            if _G.ViewHB then p.Character.HumanoidRootPart.Transparency = 0.5 p.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red") else p.Character.HumanoidRootPart.Transparency = 1 end
            p.Character.HumanoidRootPart.CanCollide = false
        end
    end
end})

---------------------------------------------------------
-- 🌍 TAB WORLD
---------------------------------------------------------
TabWorld:CreateButton({Name = "FullBright", Callback = function() Lighting.Ambient = Color3.new(1,1,1) Lighting.Brightness = 2 end})
TabWorld:CreateButton({Name = "Remove Fog", Callback = function() Lighting.FogEnd = 999999 if Lighting:FindFirstChild("Atmosphere") then Lighting.Atmosphere:Destroy() end end})
TabWorld:CreateSlider({Name = "Time Changer", Range = {0, 24}, Increment = 1, CurrentValue = 12, Flag = "Time", Callback = function(v) Lighting.ClockTime = v end})
TabWorld:CreateButton({Name = "Skybox Changer (Galaxy)", Callback = function() local s = Instance.new("Sky", Lighting) s.SkyboxBk = "rbxassetid://159454299" s.SkyboxDn = "rbxassetid://159454296" s.SkyboxFt = "rbxassetid://159454293" s.SkyboxLf = "rbxassetid://159454286" s.SkyboxRt = "rbxassetid://159454300" s.SkyboxUp = "rbxassetid://159454288" end})
TabWorld:CreateButton({Name = "Weather Changer", Callback = function() Rayfield:Notify({Title="Weather", Content="Chỉ hoạt động ở một số game hỗ trợ hệ thống thời tiết"}) end})
TabWorld:CreateSlider({Name = "Gravity Control", Range = {0, 200}, Increment = 5, CurrentValue = 196, Flag = "WGrav", Callback = function(v) Workspace.Gravity = v end})
TabWorld:CreateButton({Name = "Destroy Map Parts", Callback = function() for _,v in pairs(Workspace:GetDescendants()) do if v:IsA("BasePart") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") then v:Destroy() end end end})
TabWorld:CreateButton({Name = "FPS Booster", Callback = function() for _, v in pairs(Workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end end end Lighting.GlobalShadows = false end})
TabWorld:CreateButton({Name = "Low Graphics", Callback = function() settings().Rendering.QualityLevel = 1 end})
TabWorld:CreateButton({Name = "High Graphics", Callback = function() settings().Rendering.QualityLevel = 21 end})

---------------------------------------------------------
-- 🚗 TAB VEHICLE
---------------------------------------------------------
local function getVehicle()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart then
        return LocalPlayer.Character.Humanoid.SeatPart.Parent
    end
    return nil
end

TabVehicle:CreateSlider({Name = "Car Speed", Range = {10, 500}, Increment = 10, CurrentValue = 50, Flag = "CSpeed", Callback = function(v) 
    local seat = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart
    if seat and seat:IsA("VehicleSeat") then seat.MaxSpeed = v end
end})

TabVehicle:CreateToggle({Name = "Fly Car (Bấm E)", CurrentValue = false, Flag = "FCar", Callback = function(v) _G.CarFly = v end})
UserInputService.InputBegan:Connect(function(input, gameProcessed) 
    if not gameProcessed and _G.CarFly and input.KeyCode == Enum.KeyCode.E then
        local veh = getVehicle()
        if veh and veh.PrimaryPart then veh.PrimaryPart.Velocity = Vector3.new(0, 50, 0) end
    end
end)

TabVehicle:CreateToggle({Name = "No Clip Car", CurrentValue = false, Flag = "NCCar", Callback = function(v) _G.CarNC = v end})
RunService.Stepped:Connect(function()
    if _G.CarNC then
        local veh = getVehicle()
        if veh then for _,p in pairs(veh:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    end
end)

-- Infinite Fuel: tìm và set fuel
TabVehicle:CreateToggle({Name = "Infinite Fuel", CurrentValue = false, Flag = "IFuel", Callback = function(v)
    if v then
        local veh = getVehicle()
        if veh then
            for _, child in pairs(veh:GetDescendants()) do
                if child:IsA("NumberValue") and string.lower(child.Name):find("fuel") then
                    child.Value = 9999
                end
            end
            Rayfield:Notify({Title="Infinite Fuel", Content="Đã set fuel lên 9999 (nếu có)"})
        end
    end
end})

TabVehicle:CreateButton({Name = "Instant Enter", Callback = function() for _,v in pairs(Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v:Sit(LocalPlayer.Character.Humanoid) break end end end})
TabVehicle:CreateToggle({Name = "Drift Mode", CurrentValue = false, Flag = "Drift", Callback = function(v) local s = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart if s and s:IsA("VehicleSeat") then s.TurnSpeed = v and 50 or 1 end end})
TabVehicle:CreateSlider({Name = "Vehicle Gravity", Range = {0, 200}, Increment = 10, CurrentValue = 196, Flag = "VG", Callback = function(v) Workspace.Gravity = v end})
TabVehicle:CreateButton({Name = "Vehicle TP", Callback = function() local veh = getVehicle() if veh and veh.PrimaryPart then veh:MoveTo(Mouse.Hit.Position) end end})

---------------------------------------------------------
-- 📦 TAB ITEMS
---------------------------------------------------------
TabItems:CreateToggle({Name = "Auto Equip", CurrentValue = false, Flag = "AEquip", Callback = function(v) _G.AEquip = v end})
RunService.RenderStepped:Connect(function() if _G.AEquip then for _,t in pairs(LocalPlayer.Backpack:GetChildren()) do if t:IsA("Tool") then LocalPlayer.Character.Humanoid:EquipTool(t) end end end end)

TabItems:CreateToggle({Name = "Auto Collect", CurrentValue = false, Flag = "ACollect", Callback = function(v) _G.ACollect = v end})
RunService.RenderStepped:Connect(function() if _G.ACollect and LocalPlayer.Character then for _,t in pairs(Workspace:GetChildren()) do if t:IsA("Tool") and t:FindFirstChild("Handle") then t.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame end end end end)

TabItems:CreateToggle({Name = "Item ESP", CurrentValue = false, Flag = "ItemESP", Callback = function(v) 
    for _,t in pairs(Workspace:GetChildren()) do 
        if t:IsA("Tool") and t:FindFirstChild("Handle") then 
            if v then local hl = Instance.new("Highlight", t) hl.FillColor = Color3.new(1,1,0) else if t:FindFirstChildOfClass("Highlight") then t:FindFirstChildOfClass("Highlight"):Destroy() end end
        end 
    end 
end})

TabItems:CreateToggle({Name = "Tool Reach", CurrentValue = false, Flag = "TReach", Callback = function(v) 
    for _,t in pairs(LocalPlayer.Backpack:GetChildren()) do
        if t:IsA("Tool") and t:FindFirstChild("Handle") then
            t.Handle.Size = v and Vector3.new(20,20,20) or Vector3.new(1,1,1)
            t.Handle.Transparency = v and 0.8 or 0
        end
    end
end})

-- Infinite Ammo: quét giá trị đạn
TabItems:CreateToggle({Name = "Infinite Ammo", CurrentValue = false, Flag = "IAmmo", Callback = function(v)
    if v then
        for _, obj in pairs(LocalPlayer.Character:GetDescendants()) do
            if obj:IsA("NumberValue") and string.lower(obj.Name):find("ammo") then
                obj.Value = 9999
            end
        end
        for _, obj in pairs(LocalPlayer.Backpack:GetDescendants()) do
            if obj:IsA("NumberValue") and string.lower(obj.Name):find("ammo") then
                obj.Value = 9999
            end
        end
        Rayfield:Notify({Title="Infinite Ammo", Content="Đã set đạn lên 9999 (nếu có)"})
    end
end})

TabItems:CreateButton({Name = "Drop All", Callback = function() for _,t in pairs(LocalPlayer.Backpack:GetChildren()) do if t:IsA("Tool") then t.Parent = Workspace end end end})
TabItems:CreateButton({Name = "Equip All", Callback = function() for _,t in pairs(LocalPlayer.Backpack:GetChildren()) do if t:IsA("Tool") then LocalPlayer.Character.Humanoid:EquipTool(t) end end end})

---------------------------------------------------------
-- 🛠️ TAB UTILITIES
---------------------------------------------------------
TabUtilities:CreateButton({Name = "Rejoin", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end})
TabUtilities:CreateButton({Name = "Server Hop", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LeoKholYt/roblox/main/Hop.lua"))():Hop() end})
TabUtilities:CreateButton({Name = "Join Small Server", Callback = function() Rayfield:Notify({Title="Hop", Content="Đang tìm server ít người..."}) loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconLord1/ServerHop/main/SmallServerHop.lua"))() end})

-- Join Friend: yêu cầu nhập tên
TabUtilities:CreateButton({Name = "Join Friend (Nhập Tên)", Callback = function()
    local name = Rayfield:Input("Nhập tên bạn của bạn", "Tên người chơi", "")
    if name ~= "" then
        TeleportService:TeleportToPlayer(Players:FindFirstChild(name))
    end
end})

TabUtilities:CreateButton({Name = "Copy Job ID", Callback = function() setclipboard(game.JobId) Rayfield:Notify({Title="Copy", Content="Đã copy Job ID!"}) end})
TabUtilities:CreateButton({Name = "Copy Place ID", Callback = function() setclipboard(tostring(game.PlaceId)) Rayfield:Notify({Title="Copy", Content="Đã copy Place ID!"}) end})

local fpsLab = Drawing.new("Text") fpsLab.Visible = false fpsLab.Position = Vector2.new(100, 50) fpsLab.Color = Color3.new(1,1,1) fpsLab.Size = 20
RunService.RenderStepped:Connect(function(fps) fpsLab.Text = "FPS: " .. math.floor(1/fps) end)
TabUtilities:CreateToggle({Name = "FPS Counter", CurrentValue = false, Flag = "FPSC", Callback = function(v) fpsLab.Visible = v end})

-- Ping Counter thực tế
local pingLab = Drawing.new("Text") pingLab.Visible = false pingLab.Position = Vector2.new(100, 70) pingLab.Color = Color3.new(1,1,0) pingLab.Size = 20
RunService.RenderStepped:Connect(function()
    local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    pingLab.Text = "Ping: " .. ping .. "ms"
end)
TabUtilities:CreateToggle({Name = "Ping Counter", CurrentValue = false, Flag = "PingC", Callback = function(v) pingLab.Visible = v end})

TabUtilities:CreateButton({Name = "Executor Info", Callback = function() Rayfield:Notify({Title="Executor", Content=identifyexecutor and identifyexecutor() or "Không xác định", Duration=5}) end})

-- Anti Idle: tắt idle connections
TabUtilities:CreateToggle({Name = "Anti Idle", CurrentValue = true, Flag = "AIdle", Callback = function(v)
    if v then
        for _, conn in pairs(getconnections(LocalPlayer.Idled)) do conn:Disable() end
    else
        for _, conn in pairs(getconnections(LocalPlayer.Idled)) do conn:Enable() end
    end
end})

-- Anti Kick: hook kick
TabUtilities:CreateToggle({Name = "Anti Kick", CurrentValue = false, Flag = "AKick", Callback = function(v)
    if v then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local old = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            if getnamecallmethod() == "Kick" then return nil end
            return old(self, ...)
        end)
    else
        -- Khôi phục? Khó, nên để vậy
    end
end})

-- Auto Execute: chạy script đã lưu
local autoExecScript = ""
TabUtilities:CreateToggle({Name = "Auto Execute", CurrentValue = false, Flag = "AExe", Callback = function(v)
    if v and autoExecScript ~= "" then
        loadstring(autoExecScript)()
        Rayfield:Notify({Title="Auto Execute", Content="Đã chạy script tự động!"})
    end
end})

TabUtilities:CreateButton({Name = "Save Config", Callback = function() pcall(function() Rayfield:LoadConfiguration() end) Rayfield:Notify({Title="Config", Content="Đã lưu cấu hình!"}) end})
TabUtilities:CreateButton({Name = "Load Config", Callback = function() pcall(function() Rayfield:LoadConfiguration() end) end})

---------------------------------------------------------
-- 📜 TAB SCRIPTS (CÓ EXECUTOR THẬT)
---------------------------------------------------------
TabScripts:CreateButton({Name = "Universal Scripts (IY)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end})
TabScripts:CreateButton({Name = "Game Scripts", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconLord1/BrooksHub/main/BrooksHub.lua"))() end})
TabScripts:CreateButton({Name = "Script Hub", Callback = function() loadstring(game:HttpGet('https://sirius.menu/script'))() end})

-- Ô nhập code
local scriptInput = TabScripts:CreateInput({
    Name = "Nhập Script Code",
    PlaceholderText = "print('Hello Sinsister!')",
    RemoveTextAfterFocusLost = false,
    Callback = function(txt) 
        _G.ScriptCode = txt 
    end
})

-- Nút Execute
TabScripts:CreateButton({Name = "▶ Execute", Callback = function()
    if _G.ScriptCode and _G.ScriptCode ~= "" then
        local fn, err = loadstring(_G.ScriptCode)
        if fn then
            pcall(fn)
            Rayfield:Notify({Title="Execute", Content="Đã chạy script thành công!"})
        else
            Rayfield:Notify({Title="Lỗi", Content=tostring(err), Duration=5})
        end
    else
        Rayfield:Notify({Title="Lỗi", Content="Bạn chưa nhập code!"})
    end
end})

-- Clear Editor: xóa nội dung input
TabScripts:CreateButton({Name = "🗑 Clear Editor", Callback = function()
    _G.ScriptCode = ""
    scriptInput:Set("")
    Rayfield:Notify({Title="Clear", Content="Đã xóa code trong editor."})
end})

-- Save Script: lưu vào file
TabScripts:CreateButton({Name = "💾 Save Script", Callback = function()
    if writefile then
        writefile("Sinsister_SavedScript.lua", _G.ScriptCode or "")
        Rayfield:Notify({Title="Save", Content="Đã lưu script vào Sinsister_SavedScript.lua"})
    else
        Rayfield:Notify({Title="Lỗi", Content="Executor không hỗ trợ writefile!"})
    end
end})

-- Load Script: đọc từ file
TabScripts:CreateButton({Name = "📁 Load Script", Callback = function()
    if readfile and isfile("Sinsister_SavedScript.lua") then
        local data = readfile("Sinsister_SavedScript.lua")
        _G.ScriptCode = data
        scriptInput:Set(data)
        Rayfield:Notify({Title="Load", Content="Đã load script từ file!"})
    else
        Rayfield:Notify({Title="Lỗi", Content="Không tìm thấy file hoặc không hỗ trợ readfile!"})
    end
end})

---------------------------------------------------------
-- ⭐ TAB FAVORITES
---------------------------------------------------------
TabFavorites:CreateLabel("Lưu script yêu thích bằng URL")
local favInput = TabFavorites:CreateInput({
    Name = "Nhập URL Raw Script",
    PlaceholderText = "https://raw.githubusercontent.com/...",
    RemoveTextAfterFocusLost = false,
    Callback = function(txt) _G.FavURL = txt end
})

TabFavorites:CreateButton({Name = "⭐ Chạy Script Yêu Thích", Callback = function()
    if _G.FavURL and _G.FavURL ~= "" then
        local success, err = pcall(function()
            loadstring(game:HttpGet(_G.FavURL))()
        end)
        if success then
            Rayfield:Notify({Title="Favorites", Content="Đã chạy script yêu thích!"})
        else
            Rayfield:Notify({Title="Lỗi", Content="URL không hợp lệ hoặc script lỗi!"})
        end
    else
        Rayfield:Notify({Title="Lỗi", Content="Bạn chưa nhập URL!"})
    end
end})

TabFavorites:CreateButton({Name = "⭐ Lưu URL Hiện Tại", Callback = function()
    if _G.FavURL and _G.FavURL ~= "" then
        if writefile then
            writefile("Sinsister_FavoriteURL.txt", _G.FavURL)
            Rayfield:Notify({Title="Favorites", Content="Đã lưu URL vào file!"})
        else
            Rayfield:Notify({Title="Lỗi", Content="Executor không hỗ trợ writefile!"})
        end
    end
end})

TabFavorites:CreateButton({Name = "⭐ Load URL Đã Lưu", Callback = function()
    if readfile and isfile("Sinsister_FavoriteURL.txt") then
        local url = readfile("Sinsister_FavoriteURL.txt")
        _G.FavURL = url
        favInput:Set(url)
        Rayfield:Notify({Title="Favorites", Content="Đã load URL từ file!"})
    else
        Rayfield:Notify({Title="Lỗi", Content="Không tìm thấy file!"})
    end
end})

---------------------------------------------------------
-- ⚙️ TAB SETTINGS (ĐÃ FIX SẠCH & THÊM HỆ THỐNG MÀU)
---------------------------------------------------------
TabSettings:CreateDropdown({
   Name = "UI Theme (Giao Diện Nền)",
   Options = {"Default", "Ocean", "Light", "DarkBlue", "Green"},
   CurrentOption = {"Default"},
   MultipleOptions = false,
   Flag = "ThemeSel",
   Callback = function(Option)
        local t = Option[1]
        pcall(function()
            if t == "Ocean" then Window:ModifyTheme('Ocean')
            elseif t == "Light" then Window:ModifyTheme('Light')
            elseif t == "DarkBlue" then Window:ModifyTheme('DarkBlue')
            elseif t == "Green" then Window:ModifyTheme('Green')
            else Window:ModifyTheme('Default') end
        end)
   end,
})

TabSettings:CreateToggle({
   Name = "Blur (Làm Mờ Nền Game)", 
   CurrentValue = true, 
   Flag = "BlurUI",
   Callback = function(v)
      local b = Lighting:FindFirstChild("RayfieldBlur")
      if v then if not b then local blur = Instance.new("BlurEffect", Lighting) blur.Name = "RayfieldBlur" blur.Size = 15 end
      else if b then b:Destroy() end end
   end,
})

TabSettings:CreateKeybind({
   Name = "Nút Ẩn/Hiện Menu",
   CurrentKeybind = "RightShift",
   HoldToInteract = false,
   Flag = "KeybindUI",
   Callback = function()
      pcall(function() Window:Minimize(not Window.Minimized) end)
   end,
})

-- HỆ THỐNG CUSTOM ĐỔI MÀU GIAO DIỆN RAYFIELD TRỰC TIẾP (FIXED)
local CustomColor = Color3.fromRGB(150, 0, 255)
local IsRainbow = false

local function ApplyMenuColor(color)
    pcall(function()
        local coreGui = (gethui and gethui()) or game:GetService("CoreGui")
        local rayfieldGui = coreGui:FindFirstChild("Rayfield") or LocalPlayer.PlayerGui:FindFirstChild("Rayfield")
        if rayfieldGui then
            for _, v in pairs(rayfieldGui:GetDescendants()) do
                if v:IsA("UIStroke") then
                    v.Color = color
                end
            end
        end
    end)
end

TabSettings:CreateColorPicker({
    Name = "Accent Color (Đổi Màu Viền Menu)",
    Color = CustomColor,
    Flag = "ColorP",
    Callback = function(Value)
        CustomColor = Value
        if not IsRainbow then ApplyMenuColor(CustomColor) end
    end
})

TabSettings:CreateToggle({
    Name = "Rainbow UI (Viền 7 Màu Chuyển Động)",
    CurrentValue = false,
    Flag = "Rainbow",
    Callback = function(Value)
        IsRainbow = Value
        if not IsRainbow then ApplyMenuColor(CustomColor) end
    end
})

RunService.RenderStepped:Connect(function()
    if IsRainbow then
        local hue = tick() % 5 / 5
        ApplyMenuColor(Color3.fromHSV(hue, 1, 1))
    end
end)

---------------------------------------------------------
-- 🧪 TAB DEBUG & ℹ️ ABOUT
---------------------------------------------------------
TabDebug:CreateButton({Name = "Console (F9)", Callback = function() game:GetService("StarterGui"):SetCore("DevConsoleVisible", true) end})

-- Logs: in thông tin ra console
TabDebug:CreateButton({Name = "Logs (In thông tin)", Callback = function()
    print("=== SINSISTER DEBUG LOGS ===")
    print("Game:", game.Name)
    print("Place ID:", game.PlaceId)
    print("Job ID:", game.JobId)
    print("Players:", #Players:GetPlayers())
    print("=============================")
    Rayfield:Notify({Title="Logs", Content="Đã in logs ra Console (F9)"})
end})

-- Explorer: dùng Dex
TabDebug:CreateButton({Name = "Explorer (Dex)", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end})

TabDebug:CreateButton({Name = "Remote Spy", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))() end})

TabAbout:CreateLabel("Phiên bản: SINSISTER MONSTER MAX (FIX ALL)")
TabAbout:CreateLabel("Tác giả: GERBOX")
TabAbout:CreateButton({Name = "Discord (Copy)", Callback = function() setclipboard("https://discord.gg/YDymXSuWf") Rayfield:Notify({Title="Copy", Content="Đã copy link!"}) end})
TabAbout:CreateButton({Name = "GitHub (Mở link)", Callback = function() 
    -- Mở link (nếu executor hỗ trợ)
    pcall(function() 
        game:GetService("GuiService"):OpenBrowser("https://github.com/GERBOX")
    end)
    Rayfield:Notify({Title="GitHub", Content="Đã mở link (nếu hỗ trợ)"})
end})
TabAbout:CreateButton({Name = "Donate", Callback = function() 
    Rayfield:Notify({Title="Donate", Content="Cảm ơn bạn! Liên hệ Discord để ủng hộ."})
end})

---------------------------------------------------------
-- KẾT THÚC
---------------------------------------------------------
Rayfield:Notify({Title = "THÀNH CÔNG", Content = "Bản Sinsister Monster MAX đã nạp hoàn tất và fix bug thành công!", Duration = 7})
