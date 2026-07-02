-- Очищаем старые GUI
pcall(function()
    game.Players.LocalPlayer.PlayerGui:FindFirstChild("TP_GUI"):Destroy()
    game.Players.LocalPlayer.PlayerGui:FindFirstChild("TPToggle"):Destroy()
    game.Players.LocalPlayer.PlayerGui:FindFirstChild("ConfirmGUI"):Destroy()
end)

-- ===== КРУГЛАЯ КНОПКА TP =====
local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "TPToggle"
toggleGui.Parent = game.Players.LocalPlayer.PlayerGui
toggleGui.ResetOnSpawn = false

local toggleBtn = Instance.new("ImageButton")
toggleBtn.Parent = toggleGui
toggleBtn.Size = UDim2.new(0, 55, 0, 55)
toggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
toggleBtn.BackgroundTransparency = 0
toggleBtn.BorderSizePixel = 0
toggleBtn.Draggable = true
toggleBtn.Active = true

local corner = Instance.new("UICorner")
corner.Parent = toggleBtn
corner.CornerRadius = UDim.new(1, 0)

local label = Instance.new("TextLabel")
label.Parent = toggleBtn
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "TP"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.GothamBold

toggleBtn.MouseEnter:Connect(function()
    toggleBtn.BackgroundColor3 = Color3.fromRGB(65, 65, 95)
end)
toggleBtn.MouseLeave:Connect(function()
    toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
end)

-- ===== ГЛАВНОЕ ОКНО =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TP_GUI"
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 600, 0, 450)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
mainCorner.CornerRadius = UDim.new(0, 12)

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1, 0, 0, 42)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.Parent = titleBar
titleCorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Parent = titleBar
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "📍 МОИ ТОЧКИ"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка минус
local minBtn = Instance.new("TextButton")
minBtn.Parent = titleBar
minBtn.Size = UDim2.new(0, 35, 0, 35)
minBtn.Position = UDim2.new(1, -45, 0, 3)
minBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 80)
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0

local minCorner = Instance.new("UICorner")
minCorner.Parent = minBtn
minCorner.CornerRadius = UDim.new(1, 0)

minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    toggleBtn.Visible = true
end)

-- ===== ВКЛАДКИ =====
local tabButtons = {}
local tabContents = {}

local contentFrame = Instance.new("Frame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, -10, 1, -50)
contentFrame.Position = UDim2.new(0, 5, 0, 47)
contentFrame.BackgroundTransparency = 1

local function createTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Parent = mainFrame
    btn.Size = UDim2.new(0.3, -5, 0, 35)
    btn.Position = UDim2.new((#tabButtons) * 0.33 + 0.005, 0, 0, 47)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 6)
    
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Parent = contentFrame
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.ScrollBarThickness = 4
    tabContent.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = tabContent
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
    table.insert(tabButtons, btn)
    tabContents[btn] = tabContent
    
    btn.MouseButton1Click:Connect(function()
        for _, tb in pairs(tabButtons) do
            tb.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
            tb.TextColor3 = Color3.fromRGB(180, 180, 200)
            tabContents[tb].Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 140)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabContent.Visible = true
    end)
    
    return tabContent
end

local function createButton(parent, text, color, callback, width, height)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(width or 1, -10, height or 0, 35)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = color or Color3.fromRGB(55, 55, 75)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 6)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = color and color + Color3.fromRGB(20, 20, 20) or Color3.fromRGB(75, 75, 95)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = color or Color3.fromRGB(55, 55, 75)
    end)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createLabel(parent, text, color, size)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = parent
    lbl.Size = UDim2.new(1, -10, size or 0, 30)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(200, 200, 220)
    lbl.TextScaled = true
    lbl.Font = Enum.Font.GothamBold
    return lbl
end

local function createTextBox(parent, placeholder, width, height)
    local box = Instance.new("TextBox")
    box.Parent = parent
    box.Size = UDim2.new(width or 1, -10, height or 0, 35)
    box.Position = UDim2.new(0, 5, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextScaled = true
    box.Font = Enum.Font.GothamBold
    box.PlaceholderText = placeholder or "Введите..."
    box.PlaceholderColor3 = Color3.fromRGB(150, 150, 180)
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    
    local corner = Instance.new("UICorner")
    corner.Parent = box
    corner.CornerRadius = UDim.new(0, 6)
    
    return box
end

-- ===== ФУНКЦИЯ ПОДТВЕРЖДЕНИЯ С ТАЙМЕРОМ =====
local function ShowConfirm(title, message, callback)
    pcall(function()
        game.Players.LocalPlayer.PlayerGui:FindFirstChild("ConfirmGUI"):Destroy()
    end)
    
    local confirmGui = Instance.new("ScreenGui")
    confirmGui.Name = "ConfirmGUI"
    confirmGui.Parent = game.Players.LocalPlayer.PlayerGui
    confirmGui.ResetOnSpawn = false
    
    local overlay = Instance.new("Frame")
    overlay.Parent = confirmGui
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0
    
    local frame = Instance.new("Frame")
    frame.Parent = confirmGui
    frame.Size = UDim2.new(0, 350, 0, 160)
    frame.Position = UDim2.new(0.5, -175, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BorderSizePixel = 0
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.Parent = frame
    frameCorner.CornerRadius = UDim.new(0, 10)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = frame
    titleLabel.Size = UDim2.new(1, 0, 0, 35)
    titleLabel.Position = UDim2.new(0, 0, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "⚠️ ПОДТВЕРЖДЕНИЕ"
    titleLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Parent = frame
    msgLabel.Size = UDim2.new(1, -20, 0, 40)
    msgLabel.Position = UDim2.new(0, 10, 0, 45)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = message or "Вы уверены?"
    msgLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
    msgLabel.TextScaled = true
    msgLabel.Font = Enum.Font.GothamBold
    msgLabel.TextWrapped = true
    
    local timerLabel = Instance.new("TextLabel")
    timerLabel.Parent = frame
    timerLabel.Size = UDim2.new(0, 60, 0, 40)
    timerLabel.Position = UDim2.new(0.5, -30, 0, 90)
    timerLabel.BackgroundTransparency = 1
    timerLabel.Text = "3"
    timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timerLabel.TextScaled = true
    timerLabel.Font = Enum.Font.GothamBold
    
    local okBtn = Instance.new("TextButton")
    okBtn.Parent = frame
    okBtn.Size = UDim2.new(0, 120, 0, 40)
    okBtn.Position = UDim2.new(0.5, -130, 0, 135)
    okBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    okBtn.Text = "⏳ 3"
    okBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
    okBtn.TextScaled = true
    okBtn.Font = Enum.Font.GothamBold
    okBtn.BorderSizePixel = 0
    okBtn.AutoButtonColor = false
    okBtn.Selectable = false
    
    local okCorner = Instance.new("UICorner")
    okCorner.Parent = okBtn
    okCorner.CornerRadius = UDim.new(0, 6)
    
    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Parent = frame
    cancelBtn.Size = UDim2.new(0, 120, 0, 40)
    cancelBtn.Position = UDim2.new(0.5, 10, 0, 135)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
    cancelBtn.Text = "❌ ОТМЕНА"
    cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelBtn.TextScaled = true
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.BorderSizePixel = 0
    
    local cancelCorner = Instance.new("UICorner")
    cancelCorner.Parent = cancelBtn
    cancelCorner.CornerRadius = UDim.new(0, 6)
    
    cancelBtn.MouseButton1Click:Connect(function()
        confirmGui:Destroy()
    end)
    
    local timeLeft = 3
    local timerRunning = true
    
    local function UpdateTimer()
        if timeLeft > 0 then
            timerLabel.Text = tostring(timeLeft)
            okBtn.Text = "⏳ " .. tostring(timeLeft)
            timeLeft = timeLeft - 1
            task.wait(1)
            UpdateTimer()
        else
            timerLabel.Text = "✅"
            okBtn.Text = "✅ ОК"
            okBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
            okBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            okBtn.Selectable = true
            okBtn.AutoButtonColor = true
            timerRunning = false
            
            okBtn.MouseButton1Click:Connect(function()
                confirmGui:Destroy()
                if callback then
                    callback()
                end
            end)
        end
    end
    
    task.spawn(UpdateTimer)
end

-- ===== ХРАНИЛИЩЕ =====
local savedPoints = {}
local pointButtons = {}
local configs = {}
local autoLoad = false
local currentConfig = ""

-- ===== ФУНКЦИИ РАБОТЫ С КОНФИГАМИ =====
local function SaveConfig(name)
    local data = {}
    for pointName, pos in pairs(savedPoints) do
        data[pointName] = {X = pos.X, Y = pos.Y, Z = pos.Z}
    end
    local json = game:GetService("HttpService"):JSONEncode(data)
    writefile("TP_Config_" .. name .. ".json", json)
    configs[name] = data
    RefreshConfigList()
end

local function LoadConfig(name)
    local success, json = pcall(function()
        return readfile("TP_Config_" .. name .. ".json")
    end)
    if success and json then
        local data = game:GetService("HttpService"):JSONDecode(json)
        savedPoints = {}
        for pointName, pos in pairs(data) do
            savedPoints[pointName] = Vector3.new(pos.X, pos.Y, pos.Z)
        end
        currentConfig = name
        RefreshPoints()
        RefreshConfigList()
        return true
    end
    return false
end

local function DeleteConfig(name)
    pcall(function()
        os.remove("TP_Config_" .. name .. ".json")
    end)
    configs[name] = nil
    if currentConfig == name then
        currentConfig = ""
        savedPoints = {}
        RefreshPoints()
    end
    RefreshConfigList()
end

local function LoadConfigList()
    configs = {}
    local files = {}
    pcall(function()
        files = listfiles()
    end)
    for _, file in pairs(files) do
        local match = string.match(file, "TP_Config_(.+)%.json")
        if match then
            configs[match] = true
        end
    end
end

-- ===== СОЗДАНИЕ ВКЛАДОК =====
local tab1 = createTab("Создать", "📌")
local tab2 = createTab("Точки", "📍")
local tab3 = createTab("Настройки", "⚙️")

-- ===== ВКЛАДКА 1: СОЗДАТЬ ТОЧКУ =====
local createFrame = Instance.new("Frame")
createFrame.Parent = tab1
createFrame.Size = UDim2.new(1, -10, 0, 80)
createFrame.Position = UDim2.new(0, 5, 0, 0)
createFrame.BackgroundTransparency = 1

local nameBox = createTextBox(createFrame, "Название точки...", 0.6, 0)
nameBox.Position = UDim2.new(0, 5, 0, 0)

local confirmBtn = createButton(
    createFrame,
    "✅ Подтвердить",
    Color3.fromRGB(40, 180, 80),
    function()
        local player = game.Players.LocalPlayer
        if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local pos = player.Character.HumanoidRootPart.Position
        local name = nameBox.Text
        
        if name == "" then
            name = "Точка #" .. (#savedPoints + 1)
        end
        
        if savedPoints[name] then
            return
        end
        
        savedPoints[name] = pos
        nameBox.Text = ""
        RefreshPoints()
    end,
    0.35
)
confirmBtn.Position = UDim2.new(0.63, 0, 0, 0)

createLabel(tab1, "─────────────────────", Color3.fromRGB(100, 100, 120), 0)

-- ===== ВКЛАДКА 2: ТОЧКИ =====
local pointsList = Instance.new("ScrollingFrame")
pointsList.Parent = tab2
pointsList.Size = UDim2.new(1, 0, 1, 0)
pointsList.BackgroundTransparency = 1
pointsList.CanvasSize = UDim2.new(0, 0, 0, 0)
pointsList.ScrollBarThickness = 4

local pointsLayout = Instance.new("UIListLayout")
pointsLayout.Parent = pointsList
pointsLayout.SortOrder = Enum.SortOrder.LayoutOrder
pointsLayout.Padding = UDim.new(0, 4)

function RefreshPoints()
    for _, btn in pairs(pointButtons) do
        btn:Destroy()
    end
    pointButtons = {}
    
    if next(savedPoints) == nil then
        local empty = Instance.new("TextLabel")
        empty.Parent = pointsList
        empty.Size = UDim2.new(1, 0, 0, 40)
        empty.BackgroundTransparency = 1
        empty.Text = "❌ НЕТ ТОЧЕК"
        empty.TextColor3 = Color3.fromRGB(200, 200, 220)
        empty.TextScaled = true
        empty.Font = Enum.Font.GothamBold
        table.insert(pointButtons, empty)
        pointsList.CanvasSize = UDim2.new(0, 0, 0, 50)
        return
    end
    
    for name, pos in pairs(savedPoints) do
        local row = Instance.new("Frame")
        row.Parent = pointsList
        row.Size = UDim2.new(1, 0, 0, 35)
        row.BackgroundTransparency = 1
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = row
        nameLabel.Size = UDim2.new(0.35, -5, 1, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = "📍 " .. name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local coordLabel = Instance.new("TextLabel")
        coordLabel.Parent = row
        coordLabel.Size = UDim2.new(0.25, -5, 1, 0)
        coordLabel.Position = UDim2.new(0.36, 0, 0, 0)
        coordLabel.BackgroundTransparency = 1
        coordLabel.Text = "X:" .. math.floor(pos.X) .. " Y:" .. math.floor(pos.Y) .. " Z:" .. math.floor(pos.Z)
        coordLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
        coordLabel.TextScaled = true
        coordLabel.Font = Enum.Font.Gotham
        coordLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local tpBtn = createButton(
            row,
            "ТП",
            Color3.fromRGB(40, 120, 200),
            function()
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
                end
            end,
            0.12
        )
        tpBtn.Position = UDim2.new(0.62, 0, 0, 0)
        tpBtn.Size = UDim2.new(0.1, 0, 1, 0)
        
        local renameBtn = createButton(
            row,
            "✏️",
            Color3.fromRGB(60, 140, 60),
            function()
                local newName = game:GetService("StarterGui"):SetCore("InputBox", {
                    Title = "Новое имя",
                    Text = "Введите новое имя",
                    DefaultText = name
                })
                if newName and newName ~= "" and newName ~= name then
                    if savedPoints[newName] then
                        return
                    end
                    local pos = savedPoints[name]
                    savedPoints[name] = nil
                    savedPoints[newName] = pos
                    RefreshPoints()
                end
            end,
            0.12
        )
        renameBtn.Position = UDim2.new(0.73, 0, 0, 0)
        renameBtn.Size = UDim2.new(0.1, 0, 1, 0)
        
        local deleteBtn = createButton(
            row,
            "🗑️",
            Color3.fromRGB(180, 40, 40),
            function()
                savedPoints[name] = nil
                RefreshPoints()
            end,
            0.12
        )
        deleteBtn.Position = UDim2.new(0.84, 0, 0, 0)
        deleteBtn.Size = UDim2.new(0.1, 0, 1, 0)
        
        table.insert(pointButtons, row)
    end
    
    pointsList.CanvasSize = UDim2.new(0, 0, 0, #pointButtons * 42 + 10)
end

-- ===== ВКЛАДКА 3: НАСТРОЙКИ =====
createLabel(tab3, "💾 Сохранить конфиг", Color3.fromRGB(255, 200, 100), 0)

local saveFrame = Instance.new("Frame")
saveFrame.Parent = tab3
saveFrame.Size = UDim2.new(1, -10, 0, 40)
saveFrame.Position = UDim2.new(0, 5, 0, 0)
saveFrame.BackgroundTransparency = 1

local saveNameBox = createTextBox(saveFrame, "Название конфига...", 0.6, 0)
saveNameBox.Position = UDim2.new(0, 0, 0, 0)

local saveConfigBtn = createButton(
    saveFrame,
    "💾 Сохранить",
    Color3.fromRGB(40, 180, 80),
    function()
        local name = saveNameBox.Text
        if name == "" then return end
        SaveConfig(name)
        saveNameBox.Text = ""
    end,
    0.35
)
saveConfigBtn.Position = UDim2.new(0.63, 0, 0, 0)

createLabel(tab3, "─────────────────────", Color3.fromRGB(100, 100, 120), 0)
createLabel(tab3, "📂 Выбрать конфиг", Color3.fromRGB(255, 200, 100), 0)

local configList = Instance.new("ScrollingFrame")
configList.Parent = tab3
configList.Size = UDim2.new(1, 0, 0, 120)
configList.BackgroundTransparency = 1
configList.CanvasSize = UDim2.new(0, 0, 0, 0)
configList.ScrollBarThickness = 4

local configLayout = Instance.new("UIListLayout")
configLayout.Parent = configList
configLayout.SortOrder = Enum.SortOrder.LayoutOrder
configLayout.PaddconfigLayout.Padding = UDim.new(0, 4)

local configButtons = {}

function RefreshConfigList()
    for _, btn in pairs(configButtons) do
        btn:Destroy()
    end
    configButtons = {}
    
    local hasConfigs = false
    for name, _ in pairs(configs) do
        hasConfigs = true
        local row = Instance.new("Frame")
        row.Parent = configList
        row.Size = UDim2.new(1, 0, 0, 35)
        row.BackgroundTransparency = 1
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = row
        nameLabel.Size = UDim2.new(0.45, -5, 1, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = "📄 " .. name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local loadBtn = createButton(
            row,
            "📂 Загрузить",
            Color3.fromRGB(40, 160, 200),
            function()
                LoadConfig(name)
            end,
            0.22
        )
        loadBtn.Position = UDim2.new(0.47, 0, 0, 0)
        loadBtn.Size = UDim2.new(0.22, 0, 1, 0)
        
        local deleteConfigBtn = createButton(
            row,
            "🗑️ Удалить",
            Color3.fromRGB(180, 40, 40),
            function()
                ShowConfirm("⚠️ УДАЛЕНИЕ КОНФИГА", "Удалить конфиг '" .. name .. "'?", function()
                    DeleteConfig(name)
                end)
            end,
            0.22
        )
        deleteConfigBtn.Position = UDim2.new(0.70, 0, 0, 0)
        deleteConfigBtn.Size = UDim2.new(0.22, 0, 1, 0)
        
        table.insert(configButtons, row)
    end
    
    if not hasConfigs then
        local empty = Instance.new("TextLabel")
        empty.Parent = configList
        empty.Size = UDim2.new(1, 0, 0, 30)
        empty.BackgroundTransparency = 1
        empty.Text = "❌ Нет сохранённых конфигов"
        empty.TextColor3 = Color3.fromRGB(200, 200, 220)
        empty.TextScaled = true
        empty.Font = Enum.Font.GothamBold
        table.insert(configButtons, empty)
    end
    
    configList.CanvasSize = UDim2.new(0, 0, 0, #configButtons * 42 + 10)
end

createLabel(tab3, "─────────────────────", Color3.fromRGB(100, 100, 120), 0)
createLabel(tab3, "🔄 Авто загрузка", Color3.fromRGB(255, 200, 100), 0)

local autoFrame = Instance.new("Frame")
autoFrame.Parent = tab3
autoFrame.Size = UDim2.new(1, -10, 0, 40)
autoFrame.Position = UDim2.new(0, 5, 0, 0)
autoFrame.BackgroundTransparency = 1

local autoToggle = Instance.new("TextButton")
autoToggle.Parent = autoFrame
autoToggle.Size = UDim2.new(0.15, 0, 1, 0)
autoToggle.Position = UDim2.new(0.82, 0, 0, 0)
autoToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
autoToggle.Text = "ВЫКЛ"
autoToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
autoToggle.TextScaled = true
autoToggle.Font = Enum.Font.GothamBold
autoToggle.BorderSizePixel = 0

local autoCorner = Instance.new("UICorner")
autoCorner.Parent = autoToggle
autoCorner.CornerRadius = UDim.new(0, 6)

autoToggle.MouseButton1Click:Connect(function()
    autoLoad = not autoLoad
    if autoLoad then
        autoToggle.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
        autoToggle.Text = "ВКЛ"
        autoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        autoToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        autoToggle.Text = "ВЫКЛ"
        autoToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

createLabel(tab3, "─────────────────────", Color3.fromRGB(100, 100, 120), 0)
createLabel(tab3, "❌ Закрыть скрипт", Color3.fromRGB(255, 200, 100), 0)

local closeFrame = Instance.new("Frame")
closeFrame.Parent = tab3
closeFrame.Size = UDim2.new(1, -10, 0, 40)
closeFrame.Position = UDim2.new(0, 5, 0, 0)
closeFrame.BackgroundTransparency = 1

local closeBtn2 = createButton(
    closeFrame,
    "Закрыть",
    Color3.fromRGB(180, 40, 40),
    function()
        ShowConfirm("⚠️ ЗАКРЫТИЕ СКРИПТА", "Вы уверены, что хотите закрыть скрипт?", function()
            screenGui:Destroy()
            toggleGui:Destroy()
            savedPoints = {}
        end)
    end,
    0.2
)
closeBtn2.Position = UDim2.new(0.77, 0, 0, 0)
closeBtn2.Size = UDim2.new(0.2, 0, 1, 0)

-- ===== ОТКРЫТИЕ =====
toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    toggleBtn.Visible = false
end)

-- ===== ЗАГРУЗКА =====
LoadConfigList()
RefreshPoints()
RefreshConfigList()

if autoLoad then
    local lastConfig = ""
    for name, _ in pairs(configs) do
        lastConfig = name
    end
    if lastConfig ~= "" then
        LoadConfig(lastConfig)
    end
end

if #tabButtons > 0 then
    tabButtons[1].MouseButton1Click:Fire()
end

toggleBtn.Visible = true
mainFrame.Visible = false
