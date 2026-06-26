-- Chờ game tải xong hoàn toàn
if not game:IsLoaded() then
game.Loaded:Wait()
end

-- Các dịch vụ cần thiết
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local CORRECT_KEY = "DH-GRB-VIP-KEY"

-- ==========================================
-- CLEANUP OLD CONNECTIONS (Memory leak fix)
-- ==========================================
if _G.DUCZ_RenderConnection then
_G.DUCZ_RenderConnection:Disconnect()
_G.DUCZ_RenderConnection = nil
end

-- ==========================================
-- GIAO DIỆN KEY SYSTEM (DARK THEME)
-- ==========================================
local AuthGui = Instance.new("ScreenGui")
local parentGui = nil
if getgui then
parentGui = getgui()
elseif cloneref then
parentGui = CoreGui
else
parentGui = LocalPlayer:WaitForChild("PlayerGui")
end
AuthGui.Parent = parentGui
AuthGui.Name = "DUCZ_Auth"
AuthGui.ResetOnSpawn = false

-- BACKGROUND BLUR
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 24
blurEffect.Parent = Lighting
blurEffect.Enabled = false

-- Logo ASCII
local LogoLabel = Instance.new("TextLabel", AuthGui)
LogoLabel.Size = UDim2.new(0, 300, 0, 120)
LogoLabel.Position = UDim2.new(0.5, -150, 0.25, -60)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Font = Enum.Font.Code
LogoLabel.Text = [[
██████╗ ██╗  ██╗
██╔══██╗██║  ██║
██║  ██║███████║
██║  ██║██╔══██║
██████╔╝██║  ██║
╚═════╝ ╚═╝  ╚═╝
]]
LogoLabel.TextColor3 = Color3.fromRGB(220, 220, 220) -- Màu Trắng xám
LogoLabel.TextSize = 14
LogoLabel.TextTransparency = 1
LogoLabel.Visible = false

-- Thanh tiến trình (loading bar)
local ProgressFrame = Instance.new("Frame", AuthGui)
ProgressFrame.Size = UDim2.new(0, 250, 0, 8)
ProgressFrame.Position = UDim2.new(0.5, -125, 0.5, -4)
ProgressFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Đen nhám
ProgressFrame.BorderSizePixel = 0
ProgressFrame.Visible = false
Instance.new("UICorner", ProgressFrame).CornerRadius = UDim.new(0, 4)

local ProgressFill = Instance.new("Frame", ProgressFrame)
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- Trắng xám
ProgressFill.BorderSizePixel = 0
Instance.new("UICorner", ProgressFill).CornerRadius = UDim.new(0, 4)

local ProgressText = Instance.new("TextLabel", AuthGui)
ProgressText.Size = UDim2.new(0, 200, 0, 20)
ProgressText.Position = UDim2.new(0.5, -100, 0.5, 20)
ProgressText.BackgroundTransparency = 1
ProgressText.Font = Enum.Font.GothamBold
ProgressText.Text = "Loading DH Menu... 0%"
ProgressText.TextColor3 = Color3.fromRGB(200, 200, 200)
ProgressText.TextSize = 14
ProgressText.Visible = false

-- Khung Nhập Key
local KeyFrame = Instance.new("Frame", AuthGui)
KeyFrame.Size = UDim2.new(0, 360, 0, 240)
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Đen rất đậm
KeyFrame.BorderSizePixel = 0
KeyFrame.Visible = false
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)

-- Các lớp viền mờ tỏa ra (Glow Effect - Đen/Xám đậm)
for i = 1, 3 do
local Glow = Instance.new("UIStroke", KeyFrame)
Glow.Color = Color3.fromRGB(60, 60, 60)
Glow.Thickness = 2 + (i * 2)
Glow.Transparency = 0.5 + (i * 0.15)
end

-- Tiêu đề
local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "DUCZ HUB - KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(230, 230, 230)
Title.TextSize = 18

-- Textbox
local TextBox = Instance.new("TextBox", KeyFrame)
TextBox.Size = UDim2.new(0.8, 0, 0, 40)
TextBox.Position = UDim2.new(0.1, 0, 0.45, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Đen nhám
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Nhập Key..."
TextBox.Font = Enum.Font.Gotham
TextBox.Text = ""
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)
local TextBoxStroke = Instance.new("UIStroke", TextBox)
TextBoxStroke.Color = Color3.fromRGB(100, 100, 100) -- Viền xám
TextBoxStroke.Thickness = 1
TextBoxStroke.Transparency = 1 -- ẩn viền

-- Label thông báo (dùng cho key đúng/sai)
local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Size = UDim2.new(0.8, 0, 0, 20)
StatusLabel.Position = UDim2.new(0.1, 0, 0.6, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- Màu báo lỗi
StatusLabel.TextSize = 14

-- Nút Verify
local VerifyBtn = Instance.new("TextButton", KeyFrame)
VerifyBtn.Size = UDim2.new(0.5, 0, 0, 35)
VerifyBtn.Position = UDim2.new(0.25, 0, 0.78, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Xám đậm
VerifyBtn.Text = "Unlock Menu"
VerifyBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
VerifyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 6)

-- Hiệu ứng hover cho nút Verify (Dark mode)
VerifyBtn.MouseEnter:Connect(function()
TweenService:Create(VerifyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
end)
VerifyBtn.MouseLeave:Connect(function()
TweenService:Create(VerifyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
end)

-- Hiệu ứng focus cho TextBox
TextBox.Focused:Connect(function()
TweenService:Create(TextBox, TweenInfo.new(0.15), {Size = UDim2.new(0.82, 0, 0, 42)}):Play()
TweenService:Create(TextBoxStroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
StatusLabel.Text = ""
end)
TextBox.FocusLost:Connect(function()
TweenService:Create(TextBox, TweenInfo.new(0.15), {Size = UDim2.new(0.8, 0, 0, 40)}):Play()
TweenService:Create(TextBoxStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
end)

-- ==========================================
-- HIỆU ỨNG LOADING MỚI
-- ==========================================
blurEffect.Enabled = true
LogoLabel.Visible = false
ProgressFrame.Visible = true
ProgressText.Visible = true

-- Animation tăng thanh tiến trình từ 0% đến 100%
local progressTween = TweenService:Create(ProgressFill, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
progressTween:Play()

-- Cập nhật text phần trăm
local startTime = tick()
local function updateProgress()
while ProgressFrame.Visible do
local elapsed = tick() - startTime
local percent = math.min(100, math.floor(elapsed / 2.5 * 100))
ProgressText.Text = "Loading DH Menu... " .. percent .. "%"
task.wait(0.05)
end
end
coroutine.wrap(updateProgress)()

task.wait(2.5) -- đợi thanh đầy
ProgressFrame.Visible = false
ProgressText.Visible = false
-- Hiện logo và khung key
LogoLabel.Visible = true
TweenService:Create(LogoLabel, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
task.wait(0.6)
KeyFrame.Visible = true
KeyFrame.BackgroundTransparency = 1
TweenService:Create(KeyFrame, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()

-- ==========================================
-- HÀM LOAD MENU CHÍNH
-- ==========================================
local function LoadMainHub()
-- Khởi tạo thư viện Fluent UI an toàn
local Fluent = nil
local success, err = pcall(function()
local url = "https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"
Fluent = loadstring(game:HttpGet(url))()
end)

if not success or not Fluent then  
    warn("Không thể tải thư viện Fluent UI: ", err)  
    return  
end  

-- Khởi tạo Window  
local Window = Fluent:CreateWindow({  
    Title = "DUCZ HUB",  
    SubTitle = "by Gerbox",  
    TabWidth = 160,  
    Size = UDim2.fromOffset(580, 460),  
    Acrylic = false,  
    Theme = "Dark",  
    MinimizeKey = Enum.KeyCode.LeftControl  
})  

-- ==========================================  
-- NÚT BẬT/TẮT MENU BO GÓC (Drag thủ công)  
-- ==========================================  
local ScreenGui = Instance.new("ScreenGui")  
ScreenGui.Name = "DUCZ_HUD_Screen"  
ScreenGui.Parent = parentGui  

local ToggleButton = Instance.new("TextButton")  
local UICorner = Instance.new("UICorner")  
local UIStroke = Instance.new("UIStroke")  

ToggleButton.Name = "DUCZ_ToggleBtn"  
ToggleButton.Parent = ScreenGui  
ToggleButton.Size = UDim2.fromOffset(50, 50)  
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)  
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)  
ToggleButton.Text = "DH"  
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)  
ToggleButton.TextSize = 16  
ToggleButton.Font = Enum.Font.SourceSansBold  
ToggleButton.BorderSizePixel = 0  
ToggleButton.Active = true  

UICorner.CornerRadius = UDim.new(0, 12)  
UICorner.Parent = ToggleButton  

UIStroke.Thickness = 1.5  
UIStroke.Color = Color3.fromRGB(0, 120, 215)  
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border  
UIStroke.Parent = ToggleButton  

ToggleButton.MouseEnter:Connect(function()  
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 50)}):Play()  
end)  
ToggleButton.MouseLeave:Connect(function()  
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()  
end)  

ToggleButton.MouseButton1Click:Connect(function()  
    Window:Minimize()  
end)  

-- Hệ thống kéo nút mở menu thủ công  
local dragging = false  
local dragStartPos = nil  
local startOffset = nil  
ToggleButton.MouseButton1Down:Connect(function()  
    dragging = true  
    dragStartPos = UserInputService:GetMouseLocation()  
    startOffset = Vector2.new(ToggleButton.Position.X.Offset, ToggleButton.Position.Y.Offset)  
end)  
UserInputService.InputChanged:Connect(function(input)  
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then  
        local currentPos = UserInputService:GetMouseLocation()  
        local delta = currentPos - dragStartPos  
        ToggleButton.Position = UDim2.new(  
            ToggleButton.Position.X.Scale,  
            startOffset.X + delta.X,  
            ToggleButton.Position.Y.Scale,  
            startOffset.Y + delta.Y  
        )  
    end  
end)  
UserInputService.InputEnded:Connect(function(input)  
    if input.UserInputType == Enum.UserInputType.MouseButton1 then  
        dragging = false  
    end  
end)  

-- GUI Hiển thị FPS & Ping (Gắn trên màn hình)  
local StatsLabel = Instance.new("TextLabel", ScreenGui)  
StatsLabel.Size = UDim2.new(0, 150, 0, 20)  
StatsLabel.Position = UDim2.new(0.5, -75, 0, 10)  
StatsLabel.BackgroundTransparency = 1  
StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 100)  
StatsLabel.TextStrokeTransparency = 0.2  
StatsLabel.Font = Enum.Font.GothamBold  
StatsLabel.TextSize = 14  
StatsLabel.Visible = false  

-- ==========================================  
-- BIẾN LƯU TRỮ CÀI ĐẶT TOÀN CỤC  
-- ==========================================  
local Options = {  
    -- ESP  
    EspName = false,  
    EspHealth = false,  
    EspDistance = false,  
    EspWall = false,  
    TeamCheck = false,  
    -- Aim  
    Aimlock = false,  
    ShowFov = false,  
    FovSize = 150,  
    AimSmoothness = 0.15,  
    -- Player  
    EnableSpeed = false,  
    SpeedValue = 16,  
    EnableJump = false,  
    JumpValue = 50,  
    InfJump = false,  
    AntiAFK = false,  
    -- Visual  
    FullBright = false,  
    NoFog = false,  
    CamFOV = 70,  
    ShowStats = false  
}  

local ESPData = {}  
local SavedPosition = nil  
local UpdateESPWall  
local UpdateESPVisibility  

-- Anti-AFK Logic  
LocalPlayer.Idled:Connect(function()  
    if Options.AntiAFK then  
        VirtualUser:CaptureController()  
        VirtualUser:ClickButton2(Vector2.new())  
    end  
end)  

-- Infinite Jump Logic  
UserInputService.JumpRequest:Connect(function()  
    if Options.InfJump then  
        local char = LocalPlayer.Character  
        if char and char:FindFirstChildOfClass("Humanoid") then  
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)  
        end  
    end  
end)  

-- ==========================================  
-- TẠO CÁC TABS PHÂN LOẠI CHUYÊN NGHIỆP  
-- ==========================================  
local InfoTab = Window:AddTab({ Title = "Thông Tin", Icon = "info" })  
local PlayerTab = Window:AddTab({ Title = "Player", Icon = "user" })  
local CombatTab = Window:AddTab({ Title = "Combat", Icon = "swords" })  
local TeleportTab = Window:AddTab({ Title = "Teleport", Icon = "map-pin" })  
local VisualTab = Window:AddTab({ Title = "Visual", Icon = "eye" })  
local ServerTab = Window:AddTab({ Title = "Server", Icon = "server" })  

-- ==========================================  
-- TAB 1: THÔNG TIN  
-- ==========================================  
InfoTab:AddParagraph({ Title = "Thông tin tác giả", Content = "by: Gerbox" })  
InfoTab:AddParagraph({ Title = "Phiên bản", Content = "DUCZ HUB - v2.0 (Tối ưu giao diện)" })  
InfoTab:AddParagraph({ Title = "Cộng đồng Discord", Content = "https://discord.gg/YDymXSuWf" })  

local PlayerCountPara = InfoTab:AddParagraph({ Title = "Trạng thái Server", Content = "Đang tải số lượng người chơi..." })  
task.spawn(function()  
    while task.wait(3) do  
        if PlayerCountPara and Players then  
            pcall(function()  
                PlayerCountPara:SetDesc("Số người chơi trong server: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers)  
            end)  
        end  
    end  
end)  

-- ==========================================  
-- TAB 2: PLAYER  
-- ==========================================  
PlayerTab:AddSection("Chỉ Số Cơ Bản")  
  
PlayerTab:AddToggle("SpeedTog", { Title = "Bật Tốc Độ (WalkSpeed)", Default = false, Callback = function(s) Options.EnableSpeed = s end })  
local SpeedSlider = PlayerTab:AddSlider("SpeedSlider", { Title = "Chỉnh Tốc Độ", Default = 16, Min = 16, Max = 500, Rounding = 0, Callback = function(v) Options.SpeedValue = v end })  

PlayerTab:AddToggle("JumpTog", { Title = "Bật Nhảy Cao (JumpPower)", Default = false, Callback = function(s) Options.EnableJump = s end })  
local JumpSlider = PlayerTab:AddSlider("JumpSlider", { Title = "Chỉnh Sức Nhảy", Default = 50, Min = 50, Max = 250, Rounding = 0, Callback = function(v) Options.JumpValue = v end })  

PlayerTab:AddButton({  
    Title = "Reset Tốc Độ & Nhảy",  
    Callback = function()  
        SpeedSlider:SetValue(16)  
        JumpSlider:SetValue(50)  
        Options.EnableSpeed = false  
        Options.EnableJump = false  
        Fluent:Notify({ Title = "DUCZ HUB", Content = "Đã reset thông số về mặc định", Duration = 2 })  
    end  
})  

PlayerTab:AddSection("Script Tiện Ích")  

PlayerTab:AddButton({  
    Title = "Script Fly (Bay)",  
    Description = "Chạy script bay (FlyGuiV3)",  
    Callback = function()  
        local runSuccess, runErr = pcall(function()  
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()  
        end)  
        if runSuccess then  
            Fluent:Notify({ Title = "DUCZ HUB", Content = "Đã kích hoạt Script Fly thành công!", Duration = 3 })  
        else  
            Fluent:Notify({ Title = "DUCZ HUB", Content = "Lỗi khi chạy Script Fly: " .. tostring(runErr), Duration = 3 })  
        end  
    end  
})  

PlayerTab:AddButton({  
    Title = "Script Invisible (Tàng hình)",  
    Description = "Chạy script tàng hình hoàn toàn",  
    Callback = function()  
        local runSuccess, runErr = pcall(function()  
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Awesome-Invisible-man-21074"))()  
        end)  
        if runSuccess then  
            Fluent:Notify({ Title = "DUCZ HUB", Content = "Đã kích hoạt Script Invisible thành công!", Duration = 3 })  
        else  
            Fluent:Notify({ Title = "DUCZ HUB", Content = "Lỗi khi chạy Script Invisible: " .. tostring(runErr), Duration = 3 })  
        end  
    end  
})  

PlayerTab:AddSection("Tính Năng Mở Rộng")  
PlayerTab:AddToggle("InfJumpTog", { Title = "Infinite Jump (Nhảy liên tục)", Default = false, Callback = function(s) Options.InfJump = s end })  
PlayerTab:AddToggle("AntiAfkTog", { Title = "Anti AFK (Chống treo máy)", Default = false, Callback = function(s) Options.AntiAFK = s end })  
  
PlayerTab:AddButton({  
    Title = "Reset Character (Tự Tử)",  
    Callback = function()  
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then  
            LocalPlayer.Character.Humanoid.Health = 0  
        end  
    end  
})  

-- ==========================================  
-- TAB 3: COMBAT (ESP & AIM)  
-- ==========================================  
CombatTab:AddSection("Cài đặt ESP")  
CombatTab:AddToggle("EspNameTog", { Title = "Name ESP (Tên)", Default = false, Callback = function(s) Options.EspName = s UpdateESPVisibility() end })  
CombatTab:AddToggle("EspHealthTog", { Title = "Health ESP (Máu)", Default = false, Callback = function(s) Options.EspHealth = s UpdateESPVisibility() end })  
CombatTab:AddToggle("EspDistTog", { Title = "Distance ESP (Khoảng cách)", Default = false, Callback = function(s) Options.EspDistance = s UpdateESPVisibility() end })  
CombatTab:AddToggle("EspWallTog", { Title = "Chams ESP (Xuyên Tường)", Default = false, Callback = function(s) Options.EspWall = s UpdateESPWall() end })  
CombatTab:AddToggle("TeamCheckTog", { Title = "Team Check (Bỏ qua đồng đội)", Default = false, Callback = function(s) Options.TeamCheck = s UpdateESPVisibility() UpdateESPWall() end })  

CombatTab:AddButton({  
    Title = "Nút hủy toàn bộ ESP",  
    Callback = function()  
        Options.EspName = false   
        Options.EspHealth = false   
        Options.EspDistance = false   
        Options.EspWall = false  
        UpdateESPVisibility()  
        UpdateESPWall()  
        Fluent:Notify({ Title = "DUCZ HUB", Content = "Đã tắt tất cả ESP", Duration = 2 })  
    end  
})  

CombatTab:AddSection("Cài đặt Aim")  
CombatTab:AddToggle("AimlockTog", { Title = "Bật Aimlock", Default = false, Callback = function(s) Options.Aimlock = s end })  
CombatTab:AddToggle("ShowFovTog", { Title = "Show FOV", Default = false, Callback = function(s) Options.ShowFov = s end })  
CombatTab:AddSlider("FovSizeSlider", { Title = "FOV Size", Default = 150, Min = 10, Max = 500, Rounding = 0, Callback = function(v) Options.FovSize = v end })  
CombatTab:AddSlider("AimSmoothSlider", { Title = "Aim Smoothness (Độ mượt)", Default = 15, Min = 1, Max = 100, Rounding = 0, Callback = function(v) Options.AimSmoothness = v / 100 end })  

-- Vòng tròn FOV vẽ bằng Drawing API  
local FOVCircle = nil  
pcall(function()  
    if Drawing and Drawing.new then  
        FOVCircle = Drawing.new("Circle")  
        FOVCircle.Color = Color3.fromRGB(255, 255, 255)  
        FOVCircle.Thickness = 1  
        FOVCircle.Filled = false  
        FOVCircle.Transparency = 1  
    end  
end)  

local function GetClosestPlayer()  
    local closestTarget = nil  
    local shortestDistance = Options.FovSize  
    local mousePos = UserInputService:GetMouseLocation()  

    for _, player in pairs(Players:GetPlayers()) do  
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then  
            -- Bỏ qua nếu kích hoạt Team Check và người đó là đồng đội  
            if Options.TeamCheck and player.Team == LocalPlayer.Team then continue end  

            local humanoid = player.Character:FindFirstChild("Humanoid")  
            if humanoid and humanoid.Health > 0 then  
                local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)  
                if onScreen then  
                    local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude  
                    if distance <= shortestDistance then  
                        closestTarget = player.Character.HumanoidRootPart  
                        shortestDistance = distance  
                    end  
                end  
            end  
        end  
    end  
    return closestTarget  
end  

-- Khởi tạo chức năng tạo ESP tránh lỗi rò rỉ bộ nhớ (Memory Leak Fix)  
local function CreateESP(player)  
    local charConn = nil  
      
    local function cleanOldESP()  
        if ESPData[player] then  
            pcall(function()  
                if ESPData[player].Highlight then ESPData[player].Highlight:Destroy() end  
                if ESPData[player].Billboard then ESPData[player].Billboard:Destroy() end  
            end)  
            ESPData[player] = nil  
        end  
    end  

    local function setupCharacter(character)  
        cleanOldESP()  
          
        local head = character:WaitForChild("Head", 5)  
        if not head then return end  
          
        local highlight = Instance.new("Highlight")  
        highlight.Name = "DUCZ_Highlight"  
        highlight.FillColor = Color3.fromRGB(255, 0, 0)  
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)  
        highlight.FillTransparency = 0.5  
        highlight.Enabled = false  
        highlight.Parent = character  
          
        local billboard = Instance.new("BillboardGui")  
        billboard.Name = "DUCZ_EspGui"  
        billboard.Size = UDim2.new(0, 200, 0, 50)  
        billboard.StudsOffset = Vector3.new(0, 2, 0)  
        billboard.AlwaysOnTop = true  
        billboard.Enabled = false  
          
        local textLabel = Instance.new("TextLabel")  
        textLabel.Size = UDim2.new(1, 0, 1, 0)  
        textLabel.BackgroundTransparency = 1  
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  
        textLabel.TextStrokeTransparency = 0  
        textLabel.Font = Enum.Font.SourceSansBold  
        textLabel.TextSize = 14  
        textLabel.Parent = billboard  
        billboard.Parent = head  
          
        ESPData[player] = {   
            Highlight = highlight,   
            Billboard = billboard,   
            TextLabel = textLabel,   
            Character = character,  
            CharConn = charConn  
        }  
          
        -- Đồng bộ ngay trạng thái bật/tắt hiện tại  
        local showBillboard = Options.EspName or Options.EspHealth or Options.EspDistance  
        if Options.TeamCheck and player.Team == LocalPlayer.Team then  
            highlight.Enabled = false  
            billboard.Enabled = false  
        else  
            highlight.Enabled = Options.EspWall  
            billboard.Enabled = showBillboard  
        end  
    end  

    charConn = player.CharacterAdded:Connect(function(character)  
        setupCharacter(character)  
    end)  

    if player.Character then   
        setupCharacter(player.Character)   
    end  
end  

function UpdateESPWall()  
    for player, data in pairs(ESPData) do  
        if data.Highlight then  
            if Options.TeamCheck and player.Team == LocalPlayer.Team then  
                data.Highlight.Enabled = false  
            else  
                data.Highlight.Enabled = Options.EspWall  
            end  
        end  
    end  
end  

function UpdateESPVisibility()  
    local showBillboard = Options.EspName or Options.EspHealth or Options.EspDistance  
    for player, data in pairs(ESPData) do  
        if data.Billboard then  
            if Options.TeamCheck and player.Team == LocalPlayer.Team then  
                data.Billboard.Enabled = false  
            else  
                data.Billboard.Enabled = showBillboard  
            end  
        end  
    end  
end  

Players.PlayerAdded:Connect(function(player)   
    if player ~= LocalPlayer then   
        CreateESP(player)   
    end   
end)  

Players.PlayerRemoving:Connect(function(player)  
    if ESPData[player] then  
        pcall(function()  
            if ESPData[player].CharConn then ESPData[player].CharConn:Disconnect() end  
            if ESPData[player].Highlight then ESPData[player].Highlight:Destroy() end  
            if ESPData[player].Billboard then ESPData[player].Billboard:Destroy() end  
        end)  
        ESPData[player] = nil  
    end  
end)  

for _, player in ipairs(Players:GetPlayers()) do   
    if player ~= LocalPlayer then   
        CreateESP(player)   
    end   
end  

-- ==========================================  
-- TAB 4: TELEPORT  
-- ==========================================  
local TeleportToolName = "Click Teleport"  
TeleportTab:AddToggle("TeleportToggle", {  
    Title = "Bật Click Teleport (Dùng Tool)",  
    Default = false,  
    Callback = function(state)  
        if state then  
            if LocalPlayer.Backpack:FindFirstChild(TeleportToolName) then return end  
            local tool = Instance.new("Tool")  
            tool.Name = TeleportToolName  
            tool.RequiresHandle = false  
            tool.Activated:Connect(function()  
                local character = LocalPlayer.Character  
                if character and character:FindFirstChild("HumanoidRootPart") then  
                    local targetPos = Mouse.Hit.Position  
                    character.HumanoidRootPart.CFrame = CFrame.new(targetPos.X, targetPos.Y + 3, targetPos.Z)  
                end  
            end)  
            tool.Parent = LocalPlayer.Backpack  
        else  
            if LocalPlayer.Backpack:FindFirstChild(TeleportToolName) then LocalPlayer.Backpack[TeleportToolName]:Destroy() end  
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(TeleportToolName) then LocalPlayer.Character[TeleportToolName]:Destroy() end  
        end  
    end  
})  

TeleportTab:AddSection("Di Chuyển Nhanh")  
TeleportTab:AddButton({  
    Title = "Teleport về Spawn",  
    Callback = function()  
        local spawnLocation = workspace:FindFirstChildOfClass("SpawnLocation")  
        if spawnLocation and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then  
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(spawnLocation.Position + Vector3.new(0, 5, 0))  
        else  
            Fluent:Notify({ Title = "DUCZ HUB", Content = "Không tìm thấy điểm Spawn!", Duration = 2 })  
        end  
    end  
})  

TeleportTab:AddSection("Lưu Vị Trí")  
TeleportTab:AddButton({  
    Title = "Lưu vị trí hiện tại",  
    Callback = function()  
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then  
            SavedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame  
            Fluent:Notify({ Title = "DUCZ HUB", Content = "Đã lưu vị trí thành công!", Duration = 2 })  
        end  
    end  
})  
  
TeleportTab:AddButton({  
    Title = "Quay lại vị trí đã lưu",  
    Callback = function()  
        if SavedPosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then  
            LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPosition  
            Fluent:Notify({ Title = "DUCZ HUB", Content = "Đã dịch chuyển về vị trí cũ!", Duration = 2 })  
        elseif not SavedPosition then  
            Fluent:Notify({ Title = "DUCZ HUB", Content = "Bạn chưa lưu vị trí nào!", Duration = 2 })  
        end  
    end  
})  

-- ==========================================  
-- TAB 5: VISUAL  
-- ==========================================  
-- Lưu lại thông số ánh sáng cũ để khôi phục khi tắt  
local OriginalAmbient = Lighting.Ambient  
local OriginalBrightness = Lighting.Brightness  
local OriginalFogEnd = Lighting.FogEnd  

VisualTab:AddToggle("FullBrightTog", {  
    Title = "FullBright (Sáng mọi nơi)",  
    Default = false,  
    Callback = function(state)  
        Options.FullBright = state  
        if state then  
            Lighting.Ambient = Color3.new(1, 1, 1)  
            Lighting.Brightness = 2  
        else  
            Lighting.Ambient = OriginalAmbient  
            Lighting.Brightness = OriginalBrightness  
        end  
    end  
})  

VisualTab:AddToggle("NoFogTog", {  
    Title = "No Fog (Tắt sương mù)",  
    Default = false,  
    Callback = function(state)  
        Options.NoFog = state  
        if state then  
            Lighting.FogEnd = 100000  
        else  
            Lighting.FogEnd = OriginalFogEnd  
        end  
    end  
})  

VisualTab:AddSlider("CamFovSlider", {  
    Title = "Camera FOV",  
    Description = "Góc nhìn toàn cảnh",  
    Default = 70, Min = 10, Max = 120, Rounding = 0,  
    Callback = function(v)  
        Options.CamFOV = v  
        Camera.FieldOfView = v  
    end  
})  

VisualTab:AddToggle("FpsPingTog", {  
    Title = "Hiện FPS & Ping",  
    Default = false,  
    Callback = function(state)  
        Options.ShowStats = state  
        StatsLabel.Visible = state  
    end  
})  

-- ==========================================  
-- TAB 6: SERVER  
-- ==========================================  
ServerTab:AddButton({  
    Title = "Rejoin Server (Vào lại)",  
    Callback = function()  
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)  
    end  
})  

ServerTab:AddButton({  
    Title = "Copy JobId (Mã Server)",  
    Callback = function()  
        setclipboard(game.JobId)  
        Fluent:Notify({ Title = "DUCZ HUB", Content = "Đã copy JobId!", Duration = 2 })  
    end  
})  
  
local TimePara = ServerTab:AddParagraph({ Title = "Thời gian hiện tại", Content = "" })  
task.spawn(function()  
    while task.wait(1) do  
        local timeT = os.date("*t")  
        if TimePara then  
            TimePara:SetDesc(string.format("%02d:%02d:%02d", timeT.hour, timeT.min, timeT.sec))  
        end  
    end  
end)  

-- ==========================================  
-- RENDER STEPPED (Cập nhật liên tục mỗi khung hình)  
-- ==========================================  
_G.DUCZ_RenderConnection = RunService.RenderStepped:Connect(function(deltaTime)  
    -- Cập nhật FPS/Ping  
    if Options.ShowStats then  
        local fps = math.floor(1 / deltaTime)  
        local ping = "0"  
        pcall(function()  
            ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+") or "0"  
        end)  
        StatsLabel.Text = "FPS: " .. fps .. " | Ping: " .. ping .. "ms"  
    end  

    -- Cập nhật Tốc độ và Sức nhảy an toàn  
    local char = LocalPlayer.Character  
    if char and char:FindFirstChild("Humanoid") then  
        local humanoid = char.Humanoid  
        if Options.EnableSpeed then  
            if humanoid.WalkSpeed ~= Options.SpeedValue then humanoid.WalkSpeed = Options.SpeedValue end  
        else  
            if humanoid.WalkSpeed ~= 16 then humanoid.WalkSpeed = 16 end  
        end  
          
        if Options.EnableJump then  
            humanoid.UseJumpPower = true  
            if humanoid.JumpPower ~= Options.JumpValue then humanoid.JumpPower = Options.JumpValue end  
        else  
            humanoid.UseJumpPower = false  
            if humanoid.JumpPower ~= 50 then humanoid.JumpPower = 50 end  
        end  
    end  

    -- Khóa FOV Camera  
    if Camera.FieldOfView ~= Options.CamFOV then  
        Camera.FieldOfView = Options.CamFOV  
    end  

    -- Vẽ vòng tròn FOV bằng Drawing API  
    if FOVCircle then  
        FOVCircle.Visible = Options.ShowFov  
        FOVCircle.Radius = Options.FovSize  
        FOVCircle.Position = UserInputService:GetMouseLocation()  
    end  

    -- Aimlock  
    if Options.Aimlock then  
        local target = GetClosestPlayer()  
        if target then  
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Options.AimSmoothness)  
        end  
    end  

    -- Cập nhật thông tin text hiển thị trên ESP Billboards  
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")  
    local myPos = myRoot and myRoot.Position  
      
    for player, data in pairs(ESPData) do  
        if data.Billboard and data.Billboard.Enabled and data.TextLabel then  
            local humanoid = data.Character and data.Character:FindFirstChild("Humanoid")  
            local targetRoot = data.Character and data.Character:FindFirstChild("HumanoidRootPart")  
            local targetPos = targetRoot and targetRoot.Position  
            local textStr = ""  
              
            if Options.EspName then textStr = textStr .. player.Name .. "\n" end  
            if Options.EspHealth and humanoid then  
                textStr = textStr .. "HP: " .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth) .. "\n"  
            end  
            if Options.EspDistance and myPos and targetPos then  
                local dist = math.floor((myPos - targetPos).Magnitude)  
                textStr = textStr .. "[" .. dist .. "m]"  
            end  
            data.TextLabel.Text = textStr  
        end  
    end  
end)  

-- Khởi tạo ban đầu  
UpdateESPVisibility()  
UpdateESPWall()  

Window:SelectTab(1)  
Fluent:Notify({ Title = "DUCZ HUB", Content = "Đã tải menu thành công!", Duration = 5 })

end

-- ==========================================
-- XỬ LÝ NHẬP KEY (DARK THEME)
-- ==========================================
VerifyBtn.MouseButton1Click:Connect(function()
if TextBox.Text == CORRECT_KEY then
-- Hiệu ứng key đúng (Đổi sang màu Trắng Bạc)
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "✓ Key Accepted"
-- Vô hiệu hóa tương tác
VerifyBtn.Interactable = false
TextBox.Interactable = false

-- Hiệu ứng glow Trắng Xám  
    for _, stroke in ipairs(KeyFrame:GetChildren()) do  
        if stroke:IsA("UIStroke") then  
            TweenService:Create(stroke, TweenInfo.new(0.5), {Color = Color3.fromRGB(200, 200, 200)}):Play()  
        end  
    end  
      
    task.wait(1)  
    -- Đóng màn hình key  
    blurEffect.Enabled = false  
    AuthGui:Destroy()  
    -- Gọi load menu chính  
    LoadMainHub()  
else  
    -- Hiệu ứng key sai (Giữ màu đỏ để dễ nhận biết lỗi)  
    StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)  
    StatusLabel.Text = "Invalid Key"  
      
    -- Rung khung  
    local originalPos = KeyFrame.Position  
    local shakeAmount = 5  
    local shakeDuration = 0.5  
    local shakeCount = 10  
    for i = 1, shakeCount do  
        KeyFrame.Position = UDim2.new(  
            originalPos.X.Scale,  
            originalPos.X.Offset + (i % 2 == 0 and shakeAmount or -shakeAmount),  
            originalPos.Y.Scale,  
            originalPos.Y.Offset + (i % 3 == 0 and shakeAmount or -shakeAmount)  
        )  
        task.wait(shakeDuration / shakeCount)  
    end  
    KeyFrame.Position = originalPos  
      
    -- Xóa text box (nhưng không hiển thị text sai)  
    TextBox.Text = ""  
    -- Sau 1 giây xóa thông báo lỗi  
    task.wait(1)  
    StatusLabel.Text = ""  
end

end)
