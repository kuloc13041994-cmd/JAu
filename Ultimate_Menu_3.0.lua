--==============================================================
-- ULTIMATE MENU V3.1 (FIXED SPEED, JUMP & HITBOX)
-- UI ONLY | MOBILE FRIENDLY | BY Gerbox (THEBA HUB CORE)
--==============================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

--==============================================================
-- HÀM ANIMATION CHỮ ĐEN/XÁM
--==============================================================
local function ApplyTextGradient(Parent)
    local Gradient = Instance.new("UIGradient")
    Gradient.Parent = Parent
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(0.30, Color3.fromRGB(150, 150, 150)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(0.70, Color3.fromRGB(170, 170, 170)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 15))
    })

    task.spawn(function()
        while Parent.Parent do
            Gradient.Offset = Vector2.new(-1, 0)
            local Tween = TweenService:Create(Gradient, TweenInfo.new(1.8, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 0)})
            Tween:Play()
            Tween.Completed:Wait()
        end
    end)
end

--==============================================================
-- CLEAN OLD UI
--==============================================================
pcall(function()
    if CoreGui:FindFirstChild("UltimateMenu") then CoreGui.UltimateMenu:Destroy() end
    if CoreGui:FindFirstChild("ESP_Folder") then CoreGui.ESP_Folder:Destroy() end
end)

local ESPFolder = Instance.new("Folder", CoreGui)
ESPFolder.Name = "ESP_Folder"

--==============================================================
-- MAIN UI SETUP
--==============================================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "UltimateMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.fromOffset(280, 350)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 9)
MainFrame.BackgroundTransparency = 0.12
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 24)

-- Border Gradient
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3.5
MainStroke.Transparency = 0.02
local BorderGradient = Instance.new("UIGradient", MainStroke)
BorderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(5, 5, 5)),
    ColorSequenceKeypoint.new(0.30, Color3.fromRGB(85, 85, 85)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(0.70, Color3.fromRGB(110, 110, 110)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 5, 5))
})
task.spawn(function()
    while ScreenGui.Parent do
        BorderGradient.Offset = Vector2.new(-1, 0)
        TweenService:Create(BorderGradient, TweenInfo.new(2.2, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 0)}):Play()
        task.wait(2.2)
    end
end)

-- Top Bar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Position = UDim2.fromOffset(5, 5)
TopBar.Size = UDim2.new(1, -10, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BackgroundTransparency = 0.32
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 18)

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(10, 0)
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Ultimate menu"
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyTextGradient(Title)

-- Nút TopBar
local function CreateTopButton(Text, XPosition)
    local Btn = Instance.new("TextButton", TopBar)
    Btn.Position = UDim2.new(1, XPosition, 0, 0)
    Btn.Size = UDim2.fromOffset(30, 30)
    Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 19)
    Btn.BackgroundTransparency = 0.15
    Btn.Text = Text
    Btn.TextColor3 = Color3.fromRGB(175, 175, 175)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 18
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 14)
    Btn.Activated:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(18, 18, 19)}):Play()
    end)
    return Btn
end
local MinimizeButton = CreateTopButton("−", -60)
local CloseButton = CreateTopButton("×", -30)

-- Content Frame
local ContentFrame = Instance.new("ScrollingFrame", MainFrame)
ContentFrame.Position = UDim2.fromOffset(5, 40)
ContentFrame.Size = UDim2.new(1, -10, 1, -45)
ContentFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 13)
ContentFrame.BackgroundTransparency = 0.38
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 2
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", ContentFrame).CornerRadius = UDim.new(0, 19)
local UIList = Instance.new("UIListLayout", ContentFrame)
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("Frame", ContentFrame).Size = UDim2.new(1, 0, 0, 2) -- Spacer

--==============================================================
-- SETTINGS & VARIABLES
--==============================================================
local Settings = {
    ESP_Player = false,
    ESP_Mob = false,
    Aimbot = false,
    FOV = false,
    FOVRadius = 150,
    SpeedToggle = false,
    SpeedVal = 16,
    JumpToggle = false,
    JumpVal = 50,
    InfJump = false,
    Noclip = false,
    Hitbox = false,
    HitboxSize = 5,
    Fullbright = false,
    TeleportTool = false
}

--==============================================================
-- UI COMPONENT BUILDERS
--==============================================================
local function CreateToggle(Text, Callback)
    local ToggleMain = Instance.new("Frame", ContentFrame)
    ToggleMain.Size = UDim2.new(0.9, 0, 0, 30)
    ToggleMain.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", ToggleMain).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel", ToggleMain)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    ApplyTextGradient(Label)

    local Btn = Instance.new("TextButton", ToggleMain)
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Position = UDim2.new(1, -50, 0.5, -10)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.Text = ""
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", Btn)
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 2, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = false
    Btn.Activated:Connect(function()
        state = not state
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, state and 22 or 2, 0.5, -8)}):Play()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(40, 40, 40)}):Play()
        Callback(state)
    end)
end

local function CreateSlider(Text, Min, Max, Default, Callback)
    local SliderMain = Instance.new("Frame", ContentFrame)
    SliderMain.Size = UDim2.new(0.9, 0, 0, 45)
    SliderMain.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", SliderMain).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel", SliderMain)
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = Text .. ": " .. tostring(Default)
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    ApplyTextGradient(Label)

    local BG = Instance.new("Frame", SliderMain)
    BG.Size = UDim2.new(1, -20, 0, 6)
    BG.Position = UDim2.new(0, 10, 0, 30)
    BG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", BG).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame", BG)
    Fill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local Btn = Instance.new("TextButton", BG)
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - BG.AbsolutePosition.X) / BG.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(Min + (pos * (Max - Min)))
        Label.Text = Text .. ": " .. tostring(val)
        Callback(val)
    end
    Btn.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; Update(inp) end end)
    UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    UserInputService.InputChanged:Connect(function(inp) if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then Update(inp) end end)
end

--==============================================================
-- LÔ GIC ESP (PLAYER & MOB)
--==============================================================
local ESP_Objects = {}
local MobList = {}

local function BuildESP(target, labelText)
    local Box = Drawing.new("Square")
    Box.Color = Color3.fromRGB(0, 255, 0)
    Box.Thickness = 1.5; Box.Filled = false; Box.Visible = false

    local Line = Drawing.new("Line")
    Line.Color = Color3.fromRGB(0, 255, 0)
    Line.Thickness = 1.5; Line.Visible = false

    local Bill = Instance.new("BillboardGui", ESPFolder)
    Bill.AlwaysOnTop = true; Bill.Size = UDim2.new(0, 200, 0, 30); Bill.ExtentsOffset = Vector3.new(0, 3, 0)

    local Txt = Instance.new("TextLabel", Bill)
    Txt.Size = UDim2.new(1, 0, 1, 0); Txt.BackgroundTransparency = 1
    Txt.Font = Enum.Font.GothamBold; Txt.TextSize = 12
    Txt.TextColor3 = Color3.fromRGB(255,255,255)
    ApplyTextGradient(Txt)

    ESP_Objects[target] = {Box = Box, Line = Line, Bill = Bill, Txt = Txt}
end

local function RemoveESP(target)
    if ESP_Objects[target] then
        ESP_Objects[target].Box:Remove(); ESP_Objects[target].Line:Remove(); ESP_Objects[target].Bill:Destroy()
        ESP_Objects[target] = nil
    end
end

-- Quét Mob 2s/lần
task.spawn(function()
    while true do
        table.clear(MobList)
        if Settings.ESP_Mob then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(v) then
                    table.insert(MobList, v)
                end
            end
        else
            for target, _ in pairs(ESP_Objects) do
                if typeof(target) == "Instance" and not Players:GetPlayerFromCharacter(target) then RemoveESP(target) end
            end
        end
        task.wait(2)
    end
end)

--==============================================================
-- CÁC CHỨC NĂNG CHÍNH
--==============================================================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Thickness = 1.5; FOVCircle.Filled = false; FOVCircle.Transparency = 1

local OrigLighting = {Ambient = Lighting.Ambient, Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime, GlobalShadows = Lighting.GlobalShadows}

RunService.RenderStepped:Connect(function()
    local CenterScreen = Camera.ViewportSize / 2

    if Settings.FOV then
        FOVCircle.Position = CenterScreen
        FOVCircle.Radius = Settings.FOVRadius
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end

    local ClosestPlayer = nil
    local ShortestDistance = math.huge
    local LocalRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")

    -- 1. Xử lý Player
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
            local Root = v.Character.HumanoidRootPart
            local Hum = v.Character.Humanoid
            local Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
            local Dist = LocalRoot and math.floor((LocalRoot.Position - Root.Position).Magnitude) or 0

            -- ESP Player
            if Settings.ESP_Player then
                if not ESP_Objects[v] then BuildESP(v) end
                local esp = ESP_Objects[v]
                if OnScreen and Hum.Health > 0 then
                    local size = Camera:WorldToViewportPoint(Root.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(Root.Position + Vector3.new(0, 3, 0)).Y
                    esp.Box.Size = Vector2.new(size / 1.5, size)
                    esp.Box.Position = Vector2.new(Pos.X - esp.Box.Size.X / 2, Pos.Y - esp.Box.Size.Y / 2)
                    esp.Box.Visible = true
                    esp.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    esp.Line.To = Vector2.new(Pos.X, Pos.Y - esp.Box.Size.Y / 2)
                    esp.Line.Visible = true
                    esp.Bill.Adornee = Root
                    esp.Txt.Text = string.format("%s | %dHP | %dm", v.Name, math.floor(Hum.Health), Dist)
                else
                    esp.Box.Visible = false; esp.Line.Visible = false; esp.Bill.Adornee = nil
                end
            elseif ESP_Objects[v] then RemoveESP(v) end

            -- [ĐÃ FIX 3] HITBOX EXPANDER (Hiện rõ màu xám mờ, phình to chuẩn xác)
            if Settings.Hitbox then
                Root.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                Root.Transparency = 0.6
                Root.Color = Color3.fromRGB(128, 128, 128)
                Root.Material = Enum.Material.SmoothPlastic
                Root.CanCollide = false
            else
                if Root.Size.X ~= 2 then
                    Root.Size = Vector3.new(2, 2, 1)
                    Root.Transparency = 1
                end
            end

            -- Aimbot Logic
            if Settings.Aimbot and Settings.FOV and OnScreen and Hum.Health > 0 then
                local Mag = (Vector2.new(Pos.X, Pos.Y) - CenterScreen).Magnitude
                if Mag < Settings.FOVRadius and Mag < ShortestDistance then
                    ShortestDistance = Mag; ClosestPlayer = v
                end
            end
        end
    end

    -- 2. Xử lý Mob ESP
    if Settings.ESP_Mob then
        for _, mob in pairs(MobList) do
            if mob and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                local Root = mob.HumanoidRootPart
                local Hum = mob.Humanoid
                local Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
                local Dist = LocalRoot and math.floor((LocalRoot.Position - Root.Position).Magnitude) or 0
                
                if not ESP_Objects[mob] then BuildESP(mob) end
                local esp = ESP_Objects[mob]
                if OnScreen and Hum.Health > 0 then
                    local size = Camera:WorldToViewportPoint(Root.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(Root.Position + Vector3.new(0, 3, 0)).Y
                    esp.Box.Size = Vector2.new(size / 1.5, size)
                    esp.Box.Position = Vector2.new(Pos.X - esp.Box.Size.X / 2, Pos.Y - esp.Box.Size.Y / 2)
                    esp.Box.Visible = true
                    esp.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    esp.Line.To = Vector2.new(Pos.X, Pos.Y - esp.Box.Size.Y / 2)
                    esp.Line.Visible = true
                    esp.Bill.Adornee = Root
                    esp.Txt.Text = string.format("%s | %dm", mob.Name, Dist)
                else
                    esp.Box.Visible = false; esp.Line.Visible = false; esp.Bill.Adornee = nil
                end
            end
        end
    end

    if ClosestPlayer and Settings.Aimbot then
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, ClosestPlayer.Character.HumanoidRootPart.Position)
    end

    -- [ĐÃ FIX 1 & 2] Ép Speed & Jump theo trạng thái Toggle ON/OFF chính xác
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        local myHum = Player.Character.Humanoid
        if Settings.SpeedToggle then
            myHum.WalkSpeed = Settings.SpeedVal
        else
            myHum.WalkSpeed = 16
        end
        
        if Settings.JumpToggle then
            myHum.UseJumpPower = true
            myHum.JumpPower = Settings.JumpVal
        else
            myHum.JumpPower = 50
        end
    end
end)

-- Inf Jump
UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if Settings.Noclip and Player.Character then
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then v.CanCollide = false end
        end
    end
end)

Players.PlayerRemoving:Connect(RemoveESP)

--==============================================================
-- UI DANH SÁCH TELEPORT (PLAYER LIST)
--==============================================================
local PlayerListMain = Instance.new("Frame", ContentFrame)
PlayerListMain.Size = UDim2.new(0.9, 0, 0, 30)
PlayerListMain.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PlayerListMain.ClipsDescendants = true
Instance.new("UICorner", PlayerListMain).CornerRadius = UDim.new(0, 8)

local PlrListBtn = Instance.new("TextButton", PlayerListMain)
PlrListBtn.Size = UDim2.new(1, 0, 0, 30)
PlrListBtn.BackgroundTransparency = 1
PlrListBtn.Text = "  > Player Teleport List"
PlrListBtn.TextColor3 = Color3.fromRGB(255,255,255)
PlrListBtn.Font = Enum.Font.GothamBold; PlrListBtn.TextSize = 13; PlrListBtn.TextXAlignment = Enum.TextXAlignment.Left
ApplyTextGradient(PlrListBtn)

local PlrContainer = Instance.new("ScrollingFrame", PlayerListMain)
PlrContainer.Position = UDim2.new(0, 0, 0, 35)
PlrContainer.Size = UDim2.new(1, 0, 1, -35)
PlrContainer.BackgroundTransparency = 1; PlrContainer.BorderSizePixel = 0
PlrContainer.ScrollBarThickness = 2; PlrContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
local PlrListLayout = Instance.new("UIListLayout", PlrContainer)
PlrListLayout.Padding = UDim.new(0, 5); PlrListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local PlrListOpen = false
PlrListBtn.Activated:Connect(function()
    PlrListOpen = not PlrListOpen
    PlrListBtn.Text = PlrListOpen and "  v Player Teleport List" or "  > Player Teleport List"
    TweenService:Create(PlayerListMain, TweenInfo.new(0.2), {Size = UDim2.new(0.9, 0, 0, PlrListOpen and 150 or 30)}):Play()
end)

local function UpdatePlayerList()
    for _, v in pairs(PlrContainer:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player then
            local Item = Instance.new("Frame", PlrContainer)
            Item.Size = UDim2.new(0.95, 0, 0, 30); Item.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Instance.new("UICorner", Item).CornerRadius = UDim.new(0, 6)
            
            local Ava = Instance.new("ImageLabel", Item)
            Ava.Size = UDim2.new(0, 24, 0, 24); Ava.Position = UDim2.new(0, 3, 0.5, -12); Ava.BackgroundTransparency = 1
            Ava.Image = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            Instance.new("UICorner", Ava).CornerRadius = UDim.new(1, 0)

            local NameLb = Instance.new("TextLabel", Item)
            NameLb.Size = UDim2.new(0.5, 0, 1, 0); NameLb.Position = UDim2.new(0, 35, 0, 0)
            NameLb.BackgroundTransparency = 1; NameLb.Text = plr.Name; NameLb.TextColor3 = Color3.fromRGB(200,200,200)
            NameLb.Font = Enum.Font.GothamSemibold; NameLb.TextSize = 11; NameLb.TextXAlignment = Enum.TextXAlignment.Left

            local GoBtn = Instance.new("TextButton", Item)
            GoBtn.Size = UDim2.new(0, 45, 0, 20); GoBtn.Position = UDim2.new(1, -50, 0.5, -10)
            GoBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50); GoBtn.Text = "Goto"
            GoBtn.Font = Enum.Font.GothamBold; GoBtn.TextColor3 = Color3.new(1,1,1); GoBtn.TextSize = 11
            Instance.new("UICorner", GoBtn).CornerRadius = UDim.new(0, 4)

            GoBtn.Activated:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
end
Players.PlayerAdded:Connect(UpdatePlayerList); Players.PlayerRemoving:Connect(UpdatePlayerList); UpdatePlayerList()

--==============================================================
-- KHỞI TẠO CÁC NÚT VÀO MENU
--==============================================================
CreateToggle("Teleport Tool (Cầm & Click)", function(state)
    Settings.TeleportTool = state
    if state then
        local Tool = Instance.new("Tool", Player.Backpack)
        Tool.Name = "Click TP 🚀"; Tool.RequiresHandle = false
        Tool.Activated:Connect(function()
            if Settings.TeleportTool and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end)
    else
        if Player.Backpack:FindFirstChild("Click TP 🚀") then Player.Backpack["Click TP 🚀"]:Destroy() end
        if Player.Character and Player.Character:FindFirstChild("Click TP 🚀") then Player.Character["Click TP 🚀"]:Destroy() end
    end
end)

CreateToggle("ESP Player (Tên | Máu | Met)", function(state) Settings.ESP_Player = state end)
CreateToggle("ESP Mobs / NPC", function(state) Settings.ESP_Mob = state end)
CreateToggle("Fullbright (Nhìn xuyên đêm)", function(state)
    Settings.Fullbright = state
    if state then
        Lighting.Ambient = Color3.new(1, 1, 1); Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.GlobalShadows = false
    else
        Lighting.Ambient = OrigLighting.Ambient; Lighting.Brightness = OrigLighting.Brightness; Lighting.ClockTime = OrigLighting.ClockTime; Lighting.GlobalShadows = OrigLighting.GlobalShadows
    end
end)
CreateToggle("Show Static FOV Circle", function(state) Settings.FOV = state end)
CreateSlider("FOV Radius", 50, 1000, 150, function(val) Settings.FOVRadius = val end)
CreateToggle("Aimbot (Lock vô tâm FOV)", function(state) Settings.Aimbot = state end)

CreateToggle("Toggle WalkSpeed", function(state) Settings.SpeedToggle = state end)
CreateSlider("Walk Speed Value", 16, 1000, 16, function(val) Settings.SpeedVal = val end)
CreateToggle("Toggle JumpPower", function(state) Settings.JumpToggle = state end)
CreateSlider("Jump Power Value", 50, 1000, 50, function(val) Settings.JumpVal = val end)

CreateToggle("Infinite Jump", function(state) Settings.InfJump = state end)
CreateToggle("Noclip (Xuyên tường)", function(state) Settings.Noclip = state end)
CreateToggle("Enable Hitbox (Màu Xám)", function(state) Settings.Hitbox = state end)
CreateSlider("Hitbox Size", 2, 50, 5, function(val) Settings.HitboxSize = val end)

--==============================================================
-- DRAG & CLOSE LÔ GIC
--==============================================================
CloseButton.Activated:Connect(function()
    FOVCircle:Remove(); if ESPFolder then ESPFolder:Destroy() end
    for _, v in pairs(Players:GetPlayers()) do RemoveESP(v) end
    TweenService:Create(MainFrame, TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.3); ScreenGui:Destroy()
end)

local NormalSize = UDim2.fromOffset(280, 350)
local MinimizedSize = UDim2.fromOffset(280, 30)
local MenuOpen = true

MinimizeButton.Activated:Connect(function()
    MenuOpen = not MenuOpen
    MinimizeButton.Text = MenuOpen and "−" or "+"
    ContentFrame.Visible = MenuOpen
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = MenuOpen and NormalSize or MinimizedSize}):Play()
end)

local Dragging, DragStart, StartPosition = false, nil, nil
TopBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true; DragStart = Input.Position; StartPosition = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(Input)
    if Dragging and (Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseMovement) then
        local Delta = Input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end
end)
