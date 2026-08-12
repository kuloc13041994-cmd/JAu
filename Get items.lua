-- Khai báo service
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- ================= DỌN RÁC CŨ =================
if CoreGui:FindFirstChild("ThebaMeowHub") then
    CoreGui.ThebaMeowHub:Destroy()
end
if CoreGui:FindFirstChild("ThebaKeySystem") then
    CoreGui.ThebaKeySystem:Destroy()
end

-- ================= TẠO ÂM THANH CLICK =================
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://6895079853" -- ID tiếng click chill
clickSound.Volume = 2
clickSound.Parent = game:GetService("SoundService")

-- ================= TẠO UI MAIN MENU (GIỮ NGUYÊN 100%, CHỈ ẨN ĐI) =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ThebaMeowHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.Enabled = false -- Ẩn đi chờ nhập đúng Key mới mở lên

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Active = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

task.spawn(function()
    local hue = 0
    while task.wait(0.02) do
        hue = hue + 0.005
        if hue >= 1 then hue = 0 end
        UIStroke.Color = Color3.fromHSV(hue, 1, 1)
    end
end)

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
RunService.Heartbeat:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
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
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "DELTA HUB VIP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
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

local GetItemsBtn = createButton("Get all items (OFF)")
local EspItemsBtn = createButton("Esp items (OFF)")

CloseBtn.MouseButton1Click:Connect(function() 
    clickSound:Play() 
    ScreenGui:Destroy() 
end)

local menuOpen = true
ToggleMenuBtn.MouseButton1Click:Connect(function()
    clickSound:Play() 
    menuOpen = not menuOpen
    if menuOpen then
        ToggleMenuBtn.Text = "-"
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 150), "Out", "Quad", 0.3, true)
        ContentFrame.Visible = true
    else
        ToggleMenuBtn.Text = "+"
        ContentFrame.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 30), "Out", "Quad", 0.3, true)
    end
end)

local validPromptKeywords = {"pick", "take", "grab", "collect", "claim", "lấy", "nhặt", "lụm"}

local function getValidItemInfo(obj)
    local success, result = pcall(function()
        if obj.Parent and obj.Parent:FindFirstChild("Humanoid") then return nil end
        if obj.Parent and obj.Parent:IsA("Backpack") then return nil end

        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
            return {type = "Tool", part = obj.Handle, name = tostring(obj.Name), realTool = obj}
        end

        if obj:IsA("ProximityPrompt") then
            local actionText = tostring(obj.ActionText or "")
            local objText = tostring(obj.ObjectText or "")
            local text = string.lower(actionText .. " " .. objText)
            
            local isPickup = false
            for _, keyword in ipairs(validPromptKeywords) do
                if string.find(text, keyword) then
                    isPickup = true
                    break
                end
            end
            
            if text == "interact" or text == "" or string.find(text, "e") then
                local parentName = string.lower(tostring(obj.Parent and obj.Parent.Name or ""))
                if not (string.find(parentName, "door") or string.find(parentName, "shop") or string.find(parentName, "buy")) then
                    isPickup = true
                end
            end
            
            if isPickup then
                local targetPart = obj.Parent
                if targetPart and targetPart:IsA("BasePart") then
                    local itemName = tostring(targetPart.Name)
                    if targetPart.Parent and targetPart.Parent:IsA("Model") then
                        itemName = tostring(targetPart.Parent.Name)
                    end
                    return {type = "Prompt", part = targetPart, prompt = obj, name = itemName}
                end
            end
        end
        return nil
    end)
    return success and result or nil
end

local getItemsToggle = false

GetItemsBtn.MouseButton1Click:Connect(function()
    clickSound:Play() 
    getItemsToggle = not getItemsToggle
    if getItemsToggle then
        GetItemsBtn.Text = "Get all items (ON)"
        GetItemsBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
    else
        GetItemsBtn.Text = "Get all items (OFF)"
        GetItemsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if getItemsToggle then
            local char = Player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local foundItem = false
                pcall(function()
                    for _, v in pairs(workspace:GetDescendants()) do
                        if not getItemsToggle then break end 
                        
                        local itemInfo = getValidItemInfo(v)
                        if itemInfo then
                            foundItem = true
                            
                            hrp.CFrame = itemInfo.part.CFrame
                            task.wait(0.2) 
                            
                            if itemInfo.type == "Prompt" then
                                pcall(function() 
                                    for i=1,3 do
                                        fireproximityprompt(itemInfo.prompt, 1, true)
                                        task.wait(0.1)
                                    end
                                end)
                            elseif itemInfo.type == "Tool" then
                                pcall(function()
                                    if itemInfo.realTool then
                                        local dist = (hrp.Position - itemInfo.part.Position).Magnitude
                                        if dist < 10 then
                                           hrp.CFrame = itemInfo.part.CFrame * CFrame.new(0, 1, 0)
                                           task.wait(0.1)
                                           hrp.CFrame = itemInfo.part.CFrame * CFrame.new(0, -1, 0)
                                        end
                                    end
                                end)
                            end
                            task.wait(0.3)
                        end
                    end
                end)
                
                if not foundItem and getItemsToggle then
                    getItemsToggle = false
                    GetItemsBtn.Text = "LỖI: HẾT ĐỒ RỒI BA!"
                    GetItemsBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
                    task.wait(2)
                    if not getItemsToggle then
                        GetItemsBtn.Text = "Get all items (OFF)"
                        GetItemsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end
    end
end)

local espToggle = false
local espFolder = Instance.new("Folder")
espFolder.Name = "ThebaEspFolder"
espFolder.Parent = CoreGui
local espCache = {}

EspItemsBtn.MouseButton1Click:Connect(function()
    clickSound:Play() 
    espToggle = not espToggle
    if espToggle then
        EspItemsBtn.Text = "Esp items (ON)"
        EspItemsBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
    else
        EspItemsBtn.Text = "Esp items (OFF)"
        EspItemsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        espFolder:ClearAllChildren()
        espCache = {}
    end
end)

task.spawn(function()
    local scanTimer = 0
    while task.wait(0.5) do
        if espToggle then
            local char = Player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if hrp then
                scanTimer = scanTimer + 0.5
                if scanTimer >= 2 then
                    scanTimer = 0
                    pcall(function()
                        for _, v in pairs(workspace:GetDescendants()) do
                            if not espCache[v] then
                                local itemInfo = getValidItemInfo(v)
                                if itemInfo then
                                    local bill = Instance.new("BillboardGui")
                                    bill.Adornee = itemInfo.part
                                    bill.Size = UDim2.new(0, 150, 0, 40)
                                    bill.AlwaysOnTop = true
                                    bill.MaxDistance = 5000 
                                    
                                    local txt = Instance.new("TextLabel", bill)
                                    txt.Size = UDim2.new(1, 0, 1, 0)
                                    txt.BackgroundTransparency = 1
                                    txt.TextColor3 = itemInfo.type == "Prompt" and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(0, 255, 255)
                                    txt.TextStrokeTransparency = 0
                                    txt.Font = Enum.Font.GothamBold
                                    txt.TextSize = 12
                                    
                                    bill.Parent = espFolder
                                    espCache[v] = {gui = bill, txt = txt, part = itemInfo.part, name = itemInfo.name}
                                end
                            end
                        end
                    end)
                end
                
                for v, data in pairs(espCache) do
                    if v and v.Parent and data.part and data.part.Parent then
                        local dist = math.floor((hrp.Position - data.part.Position).Magnitude)
                        data.txt.Text = string.format("%s [%dm]", data.name, dist)
                    else
                        data.gui:Destroy()
                        espCache[v] = nil
                    end
                end
            end
        end
    end
end)

-- ================= TẠO UI KEY SYSTEM SIÊU CẤP ĐỘC QUYỀN =================
local KeyScreen = Instance.new("ScreenGui")
KeyScreen.Name = "ThebaKeySystem"
KeyScreen.Parent = CoreGui
KeyScreen.ResetOnSpawn = false

-- Khung chính của Key System
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Parent = KeyScreen
KeyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Nền đen thui
KeyFrame.BorderSizePixel = 0
-- AnchorPoint để căn giữa hoàn hảo, Position 0.5 0.5 là nằm cứng ngắc không nhúc nhích
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyFrame.Size = UDim2.new(0, 300, 0, 160)
KeyFrame.Active = true -- Có Active nhưng đéo có script Drag nên KHÔNG THỂ KÉO ĐƯỢC

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 8)

-- Viền Rainbow
local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyFrame

task.spawn(function()
    local hue = 0
    while KeyScreen and KeyScreen.Parent do
        task.wait(0.02)
        hue = hue + 0.005
        if hue >= 1 then hue = 0 end
        KeyStroke.Color = Color3.fromHSV(hue, 1, 1)
    end
end)

-- Thanh TopBar của UI Key
local KeyTop = Instance.new("Frame", KeyFrame)
KeyTop.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyTop.Size = UDim2.new(1, 0, 0, 30)
Instance.new("UICorner", KeyTop).CornerRadius = UDim.new(0, 8)

local KeyFix = Instance.new("Frame", KeyTop)
KeyFix.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyFix.BorderSizePixel = 0
KeyFix.Position = UDim2.new(0, 0, 0.5, 0)
KeyFix.Size = UDim2.new(1, 0, 0.5, 0)

local KeyTitle = Instance.new("TextLabel", KeyTop)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 10, 0, 0)
KeyTitle.Size = UDim2.new(0.7, 0, 1, 0)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "KEY SYSTEM 🔑"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Nút Tắt (X)
local BtnX = Instance.new("TextButton", KeyTop)
BtnX.BackgroundTransparency = 1
BtnX.Position = UDim2.new(1, -30, 0, 0)
BtnX.Size = UDim2.new(0, 30, 1, 0)
BtnX.Font = Enum.Font.GothamBold
BtnX.Text = "X"
BtnX.TextColor3 = Color3.fromRGB(255, 50, 50)
BtnX.TextSize = 14

BtnX.MouseButton1Click:Connect(function()
    clickSound:Play()
    KeyScreen:Destroy()
    ScreenGui:Destroy() -- Xóa luôn Main Menu ẩn, dọn dẹp sạch sẽ
end)

-- Ô nhập Key
local TextBoxKey = Instance.new("TextBox", KeyFrame)
TextBoxKey.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TextBoxKey.Position = UDim2.new(0.05, 0, 0.35, 0)
TextBoxKey.Size = UDim2.new(0.9, 0, 0, 35)
TextBoxKey.Font = Enum.Font.Gotham
TextBoxKey.Text = ""
TextBoxKey.PlaceholderText = "Key..."
TextBoxKey.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
TextBoxKey.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBoxKey.TextSize = 13
TextBoxKey.ClearTextOnFocus = false
Instance.new("UICorner", TextBoxKey).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", TextBoxKey).Color = Color3.fromRGB(50, 50, 50)

-- Nút Check Key
local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CheckBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
CheckBtn.Size = UDim2.new(0.9, 0, 0, 35)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.Text = "SUBMIT"
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.TextSize = 13
Instance.new("UICorner", CheckBtn).CornerRadius = UDim.new(0, 6)
local checkStroke = Instance.new("UIStroke", CheckBtn)
checkStroke.Color = Color3.fromRGB(100, 100, 100)

-- ================= LOGIC CHECK KEY THEO YÊU CẦU =================
local isChecking = false
local CorrectKey = "DELTA_PREMIUM"

CheckBtn.MouseButton1Click:Connect(function()
    if isChecking then return end
    clickSound:Play()
    isChecking = true
    
    if TextBoxKey.Text == CorrectKey then
        -- Nhập đúng
        CheckBtn.Text = "Correct key!"
        CheckBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
        checkStroke.Color = Color3.fromRGB(50, 255, 50)
        task.wait(1)
        
        -- Hiệu ứng Load "Wait..." (Lặp lại 2 vòng cho giấu chấm nháy)
        CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 50)
        checkStroke.Color = Color3.fromRGB(255, 255, 50)
        
        for loop = 1, 2 do
            CheckBtn.Text = "Wait"
            task.wait(0.25)
            CheckBtn.Text = "Wait."
            task.wait(0.25)
            CheckBtn.Text = "Wait.."
            task.wait(0.25)
            CheckBtn.Text = "Wait..."
            task.wait(0.25)
        end
        
        -- Mở UI Chính
        KeyScreen:Destroy()
        ScreenGui.Enabled = true
    else
        -- Nhập sai
        CheckBtn.Text = "Incorrect key!"
        CheckBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        checkStroke.Color = Color3.fromRGB(255, 50, 50)
        task.wait(1.5)
        
        -- Reset lại form
        CheckBtn.Text = "SUBMIT"
        CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        checkStroke.Color = Color3.fromRGB(100, 100, 100)
        isChecking = false
    end
end)

print("Key System Đã Load - Bê tông cốt thép không thể nhúc nhích =)))")
