-- ==================================================================
-- THEBA HUB - BẢN DIỆT BOSS CUỐI (10/10 PERFECT LIFECYCLE) 💀
-- Reviewed by: Senior QA chuyên bắt rác =)))
-- Coded by: Tao (Đại ca của mày)
-- ==================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- ================= QUẢN LÝ RÁC (GARBAGE COLLECTOR MAX PING) =================
local GC = {
    Connections = {},       
    TouchCache = {},        
    CollideCache = {}       
}
local isUIAlive = true

local function setConn(name, connection)
    if GC.Connections[name] then
        GC.Connections[name]:Disconnect()
    end
    GC.Connections[name] = connection
end

-- ================= DỌN RÁC CŨ TẬN GỐC =================
if CoreGui:FindFirstChild("ThebaMeowHub") then
    CoreGui.ThebaMeowHub:Destroy()
end

-- ================= TẠO ÂM THANH CLICK =================
-- Fix lỗi leak Sound (Đéo để rác trong SoundService nữa)
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://6895079853"
clickSound.Volume = 2
clickSound.Parent = CoreGui -- Nhét mẹ vào CoreGui, tí xóa rác cho dễ

-- ================= UI CHÍNH =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ThebaMeowHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.Enabled = true

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Active = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 2

-- Viền RGB
task.spawn(function()
    local hue = 0
    while isUIAlive and task.wait(0.02) do
        hue = hue + 0.005
        if hue >= 1 then hue = 0 end
        UIStroke.Color = Color3.fromHSV(hue, 1, 1)
    end
end)

-- Kéo UI
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then 
                dragging = false 
                dragInput = nil 
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
setConn("UIDrag", RunService.Heartbeat:Connect(function()
    if dragging and dragInput and isUIAlive then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end))

-- TopBar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BackgroundTransparency = 0.5
TopBar.Size = UDim2.new(1, 0, 0, 30)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local FixSquare = Instance.new("Frame", TopBar)
FixSquare.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FixSquare.BackgroundTransparency = 0.5
FixSquare.BorderSizePixel = 0
FixSquare.Position = UDim2.new(0, 0, 0.5, 0)
FixSquare.Size = UDim2.new(1, 0, 0.5, 0)

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "THEBA HUB (PERFECT)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.TextSize = 14

local ToggleMenuBtn = Instance.new("TextButton", TopBar)
ToggleMenuBtn.BackgroundTransparency = 1
ToggleMenuBtn.Position = UDim2.new(1, -60, 0, 0)
ToggleMenuBtn.Size = UDim2.new(0, 30, 1, 0)
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.Text = "-"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMenuBtn.TextSize = 18

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.Size = UDim2.new(1, 0, 1, -35)

local UIListLayout = Instance.new("UIListLayout", ContentFrame)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local function createButton(text)
    local btn = Instance.new("TextButton", ContentFrame)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(100, 100, 100)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return btn
end

ToggleMenuBtn.MouseButton1Click:Connect(function()
    clickSound:Play()
    local menuOpen = ContentFrame.Visible
    if not menuOpen then
        ToggleMenuBtn.Text = "-"
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 150), "Out", "Quad", 0.3, true)
        ContentFrame.Visible = true
    else
        ToggleMenuBtn.Text = "+"
        ContentFrame.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 30), "Out", "Quad", 0.3, true)
    end
end)


-- ================= SINGLETON HOOK (DIỆT BOSS CUỐI) =================
-- Tạo ra một Hook duy nhất dùng chung toàn cầu. Kể cả execute 100 lần cũng đéo bị xếp chồng (Hook Stacking).
if getgenv and hookmetamethod and getnamecallmethod then
    -- Cấu hình của bản hiện tại
    if not getgenv().ThebaHub_Config then
        getgenv().ThebaHub_Config = {
            GodMode = false,
            UIAlive = true
        }
        
        local originalNamecall
        originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local cfg = getgenv().ThebaHub_Config
            if not cfg.UIAlive then return originalNamecall(self, ...) end 
            
            local method = getnamecallmethod()  
            if cfg.GodMode and (method == "FireServer" or method == "InvokeServer") then  
                local remoteName = string.lower(self.Name)  
                if string.find(remoteName, "damage") or string.find(remoteName, "hit") or string.find(remoteName, "dead") or string.find(remoteName, "kill") or string.find(remoteName, "takehealth") then  
                    return nil  
                end  
            end  
            return originalNamecall(self, ...)  
        end)
    end
    
    -- Đánh thức Config cho UI hiện tại
    getgenv().ThebaHub_Config.UIAlive = true
    getgenv().ThebaHub_Config.GodMode = false
end


-- ================= LOGIC GODMODE =================
local GodModeBtn = createButton("God Mode (Client) - OFF")
local isGodMode = false

local function handleNewPartGodmode(part)
    if part:IsA("BasePart") then
        if GC.TouchCache[part] == nil then GC.TouchCache[part] = part.CanTouch end
        part.CanTouch = false
    end
end

local function enableGodModeLogic(char)
    if not char then return end
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        hum.Health = hum.MaxHealth
    end
    
    for _, part in pairs(char:GetDescendants()) do
        handleNewPartGodmode(part)
    end
    setConn("DescAddedGod", char.DescendantAdded:Connect(handleNewPartGodmode))
    
    -- Ép máu lỳ đòn bằng Heartbeat (Bù đắp cho cái Client-side)
    setConn("GodModeHealthLock", RunService.Heartbeat:Connect(function()
        if hum and hum.Parent then
            if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        end
    end))
end

local function disableGodModeLogic(char)
    if GC.Connections["DescAddedGod"] then GC.Connections["DescAddedGod"]:Disconnect(); GC.Connections["DescAddedGod"] = nil end
    if GC.Connections["GodModeHealthLock"] then GC.Connections["GodModeHealthLock"]:Disconnect(); GC.Connections["GodModeHealthLock"] = nil end
    
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end
    
    for part, val in pairs(GC.TouchCache) do
        if part and part.Parent then part.CanTouch = val end
    end
end

GodModeBtn.MouseButton1Click:Connect(function()
    clickSound:Play()
    isGodMode = not isGodMode
    
    -- Cập nhật config cho Singleton Hook
    if getgenv and getgenv().ThebaHub_Config then
        getgenv().ThebaHub_Config.GodMode = isGodMode
    end

    if isGodMode then  
        GodModeBtn.Text = "God Mode (Client) - ON"  
        GodModeBtn.TextColor3 = Color3.fromRGB(50, 255, 50)  
        if Player.Character then enableGodModeLogic(Player.Character) end  
    else  
        GodModeBtn.Text = "God Mode (Client) - OFF"  
        GodModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)  
        if Player.Character then disableGodModeLogic(Player.Character) end  
        table.clear(GC.TouchCache)
    end
end)


-- ================= LOGIC NOCLIP =================
local NoclipBtn = createButton("Noclip (Xuyên Tường) - OFF")
local isNoclip = false

local function restoreNoclip()
    if GC.Connections["NoclipStepped"] then 
        GC.Connections["NoclipStepped"]:Disconnect()
        GC.Connections["NoclipStepped"] = nil 
    end
    for part, val in pairs(GC.CollideCache) do
        if part and part.Parent then part.CanCollide = val end
    end
end

local function enableNoclipLogic()
    setConn("NoclipStepped", RunService.Stepped:Connect(function()
        local char = Player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    if GC.CollideCache[part] == nil then GC.CollideCache[part] = part.CanCollide end
                    if part.CanCollide then part.CanCollide = false end
                end
            end
        end
    end))
end

NoclipBtn.MouseButton1Click:Connect(function()
    clickSound:Play()
    isNoclip = not isNoclip
    if isNoclip then
        NoclipBtn.Text = "Noclip (Xuyên Tường) - ON"
        NoclipBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
        enableNoclipLogic()
    else
        NoclipBtn.Text = "Noclip (Xuyên Tường) - OFF"
        NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        restoreNoclip()
        table.clear(GC.CollideCache)
    end
end)


-- ================= LIFECYCLE RE-SPAWN (FIX BUG 3 & 4) =================
setConn("CharAdded", Player.CharacterAdded:Connect(function(newChar)
    if isGodMode then task.wait(0.5); enableGodModeLogic(newChar) end
end))

setConn("CharRemoving", Player.CharacterRemoving:Connect(function(oldChar)
    -- Xả sạch effect vật lý của cái xác cũ đi trước
    if isGodMode then disableGodModeLogic(oldChar) end
    if isNoclip then restoreNoclip() end
    -- Xóa cache cũ để nhường chỗ cho Body mới =))
    table.clear(GC.TouchCache)
    table.clear(GC.CollideCache)
    -- Nếu noclip đang bật thì mồi lại loop cho char mới
    if isNoclip then enableNoclipLogic() end
end))


-- ================= NÚT X (THIẾN TẬN GỐC, KHÔNG SÓT MỘT PHÂN) =================
CloseBtn.MouseButton1Click:Connect(function()
    isUIAlive = false 
    isGodMode = false 
    isNoclip = false
    
    -- Tắt Config của Singleton Hook (Trả lại zin cho game)
    if getgenv and getgenv().ThebaHub_Config then
        getgenv().ThebaHub_Config.UIAlive = false
        getgenv().ThebaHub_Config.GodMode = false
    end
    
    -- Trả lại vật lý in-game
    if Player.Character then disableGodModeLogic(Player.Character) end
    restoreNoclip()
    table.clear(GC.TouchCache)
    table.clear(GC.CollideCache)
    
    -- Tắt toàn bộ Listeners
    for name, conn in pairs(GC.Connections) do
        if conn then conn:Disconnect() end
    end
    table.clear(GC.Connections)
    
    -- Hủy nốt cái Âm Thanh thối tha kia
    if clickSound then clickSound:Destroy() end
    
    -- Cút UI
    ScreenGui:Destroy()
end)

print("🚀 Bản Perfect 10/10 Lifecycle đã chèn xong. Lấy kính lúp ra soi tiếp đi mạy! 🐧🔥")
