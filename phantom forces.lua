local Config = {
    WindowName = "noobsploit",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightControl
}

local Name = "Pf.txt"

Des = {}
if makefolder then
    makefolder("noobsploit")
end

local Settings

if
    not pcall(
        function()
            readfile("noobsploit//" .. Name)
        end
    )
 then
    writefile("noobsploit//" .. Name, game:service "HttpService":JSONEncode(Des))
end

Settings = game:service "HttpService":JSONDecode(readfile("noobsploit//" .. Name))

local function Save()
    writefile("noobsploit//" .. Name, game:service "HttpService":JSONEncode(Settings))
end

local Circle = Drawing.new("Circle")
Circle.Color = Color3.fromRGB(22, 13, 56)
Circle.Thickness = 1
Circle.Radius = 250
Circle.Visible = false 
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1

game:GetService("RunService").RenderStepped:Connect(
    function()
        local Mouse = game:GetService("UserInputService"):GetMouseLocation()
        Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
    end
)

local function GetTeam()
local Null = nil
for i,v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.TeamColor ~= game.Players.LocalPlayer.TeamColor then
Null = v.TeamColor.Name
end end return Null

end 

Settings = {
    FreeForAll = false,
    WallCheck = false,
    Enabled = false,
    FOV = 250,
}
local Shoot = false

function NotObstructing(i, v)
    if Settings.WallCheck then
        c = workspace.CurrentCamera.CFrame.p
        a = Ray.new(c, i - c)
        f = workspace:FindPartOnRayWithIgnoreList(a, v)
        return f == nil
    else
        return true
    end
end
game:GetService("UserInputService").InputBegan:Connect(
    function(v)
        if v.UserInputType == Enum.UserInputType.MouseButton2 then
            Shoot = true
        end
    end
)

game:GetService("UserInputService").InputEnded:Connect(
    function(v)
        if v.UserInputType == Enum.UserInputType.MouseButton2 then
            Shoot = false
        end
    end
)



function GetClosestToCuror()
    Closest = math.huge
    Target = nil
    for i, v in pairs(game:GetService("Workspace").Players[tostring(GetTeam())]:GetChildren()) do
        if v ~= game.Players.LocalPlayer and v and v:FindFirstChild("Torso") then
            Point, OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Torso.Position)
            if OnScreen and NotObstructing(v.Torso.Position, {game.Players.LocalPlayer.Character, v}) then
                Distance =
                    (Vector2.new(Point.X, Point.Y) -
                    Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y)).magnitude
                if Distance <= Settings.FOV then
                    Closest = Distance
                    Target = v
                end
            end
        end
    end
    return Target
end

game:GetService("RunService").RenderStepped:Connect(
    function()
        if Settings.Enabled == false or Shoot == false then
            return
        end
        ClosestPlayer = GetClosestToCuror()
        if ClosestPlayer then
            local Mouse = game:GetService("UserInputService"):GetMouseLocation()
            local TargetPos = game.workspace.Camera:WorldToViewportPoint(ClosestPlayer[Settings.AimPart].Position)
            mousemoverel(
                (TargetPos.X - Mouse.X) * Settings.Smoothness,
                (TargetPos.Y - Mouse.Y) * Settings.Smoothness
            )
        end
    end
)


Settings = {
    Delay = 0.01,
}

local Aim = false
game:GetService("UserInputService").InputBegan:connect(
    function(v)
        if v.UserInputType == Enum.UserInputType.MouseButton2 and Settings.Tigger then
            Aim = true
            while Aim do
                wait()
                if
                    game:GetService("Players").LocalPlayer:GetMouse().Target and
                        game:GetService("Players"):FindFirstChild(
                            game:GetService("Players").LocalPlayer:GetMouse().Target.Parent.Name
                        )
                 then
                    local Person =
                        game:GetService("Workspace").Players[tostring(GetTeam())]:FindFirstChild(
                        game:GetService("Players").LocalPlayer:GetMouse().Target.Parent.Name
                    )
                        if Settings.Delay > 0 then
                            wait(0.01)
                        end
                        mouse1press()
                        wait()
                        mouse1release()
                end
                if not Settings.Tigger then
                    break
                end
            end
        end
    end
)

if Settings.AimPart == nil then
Settings.AimPart = "Torso"
end

if Settings.Smoothness == nil then
Settings.Smoothness = 0.04
end


if Settings.FOV == nil then
Settings.FOV = 250
end


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/test"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("PhantomForces")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("")
local Section2 = Tab1:CreateSection("")
local Section5 = Tab1:CreateSection("")
local Section3 = Tab2:CreateSection("Menu")
local Section4 = Tab2:CreateSection("Background")



local Toggle1 = Section1:CreateToggle("Aimbot", Settings.Enabled, function(State)
    Settings.Enabled = State
end)

local Dropdown1 = Section1:CreateDropdown("HitPart", {"Torso","Head"}, function(String)
	Settings.AimPart = String
end)

local Slider2 = Section1:CreateSlider("Aimbot Smoothness", 0,10,Settings.Smoothness,false, function(Value)
    Settings.Smoothness = Value
end)

local Toggle1 = Section1:CreateToggle("WallCheck",Settings.WallCheck, function(State)
    Settings.WallCheck = State
end)


local Toggle1 = Section1:CreateToggle("TriggerBot", Settings.Tigger, function(State)
    Settings.Tigger = State
end)

local Slider2 = Section1:CreateSlider("Aimbot Radius", 0,1000, Settings.FOV, false, function(Value)
    Settings.FOV = Value
    Circle.Radius = Settings.FOV
end)

local Toggle1 = Section1:CreateToggle("Circle Visible", Settings.Visible, function(State)
   Circle.Visible = State
end)

local Colorpicker3 = Section1:CreateColorpicker("Circle Color", function(Color)
    Circle.Color = Color
end)
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/crosszay1/noobsploit/main/esp.lua"))()

local Toggle1 = Section1:CreateToggle("Enable Esp", Settings.Esp, function(State)
    Settings.Esp = State
    ESP:Toggle(Settings.Esp)
    
end)

local Toggle1 = Section1:CreateToggle("Bright blue Team Esp", Settings.Blue, function(State)
    Settings.Blue = State
    ESP.Blue = Settings.Blue

ESP:AddObjectListener(game:GetService("Workspace").Players["Bright blue"], {
    Color = Color3.new(0,0,255),
    Type = "Model",
    PrimaryPart = function(v)
        local H = v:FindFirstChild("Torso")
        while not H do
            wait()
            H = v:FindFirstChild("Torso")
        end
        return H
    end,
    Validator = function(v)
        return not game.Players:GetPlayerFromCharacter(v)
    end,
    CustomName = function(v)
        return "Bright Blue"
    end,
    IsEnabled = "Blue",
})

end)


local Toggle1 = Section1:CreateToggle("Bright orange Team Esp", Settings.Orange, function(State)
    Settings.Orange = State
    ESP.Orange = Settings.Orange

ESP:AddObjectListener(game:GetService("Workspace").Players["Bright orange"], {
    Color =  Color3.new(255, 154, 0),
    Type = "Model",
    PrimaryPart = function(v)
        local H = v:FindFirstChild("Torso")
        while not H do
            wait()
            H = v:FindFirstChild("Torso")
        end
        return H
    end,
    Validator = function(v)
        return not game.Players:GetPlayerFromCharacter(v)
    end,
    CustomName = function(v)
        return "Bright Orange"
    end,
    IsEnabled = "Orange",
})

end)

local Toggle1 = Section1:CreateToggle("Tracers Esp", Settings.Tracers, function(State)
    Settings.Tracers = State
    ESP.Tracers = Settings.Tracers
end)
local Toggle1 = Section1:CreateToggle("Name Esp", Settings.EspNames, function(State)
    ESP.Names = Settings.EspNames
    Settings.EspNames = State
end)
local Toggle1 = Section1:CreateToggle("Boxes Esp", Settings.Boxes, function(State)
    Settings.Boxes = State
    ESP.Boxes = Settings.Boxes
end)


local Toggle1 = Section2:CreateToggle("RainBow Gun", Settings.RainBow, function(State)
game:GetService("RunService").RenderStepped:Connect(
    function()
        if game:GetService("Workspace").Camera:FindFirstChild("Right Arm") and Settings.RainBow then
            for i, v in pairs(game:GetService("Workspace").Camera:GetChildren()) do
                if v.Name ~= "Right Arm" or v.Name ~= "Left Arm" and v:IsA("Model") then
                    for i, v in pairs(v:GetChildren()) do
                        if v:IsA("BasePart") then
                            v.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1) -- changes Color
                        end
                    end
                end
            end
        end
    end
)
end)


local Button1 = Section2:CreateButton("Anti Lag", function()
for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
        v.Material = Enum.Material.SmoothPlastic
        if v:IsA("Texture") then
            v:Destroy()
        end
    end
end
end)

local Button1 = Section2:CreateButton("Lag Switch F3", function()
local ass = false
local bitch = settings()

game:service "UserInputService".InputEnded:connect(
    function(i)
        if i.KeyCode == Enum.KeyCode.F3 then
            ass = not ass
            bitch.Network.IncomingReplicationLag = ass and 10 or 0
        end
    end
)
 end) 
local Button1 = Section2:CreateButton("ServerHop", function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

-- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.
Teleport() 
end)
local Button1 = Section2:CreateButton("Rejoin", function()
game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer) end)


local Toggle3 = Section3:CreateToggle("UI Toggle", nil, function(State)
	Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
Toggle3:SetState(true)
local Colorpicker3 = Section3:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)

-- credits to jan for patterns
local Dropdown3 = Section4:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name)
	if Name == "Default" then
		Window:SetBackground("2151741365")
	elseif Name == "Hearts" then
		Window:SetBackground("6073763717")
	elseif Name == "Abstract" then
		Window:SetBackground("6073743871")
	elseif Name == "Hexagon" then
		Window:SetBackground("6073628839")
	elseif Name == "Circles" then
		Window:SetBackground("6071579801")
	elseif Name == "Lace With Flowers" then
		Window:SetBackground("6071575925")
	elseif Name == "Floral" then
		Window:SetBackground("5553946656")
	end
end)
Dropdown3:SetOption("Default")

local Colorpicker4 = Section4:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider3 = Section4:CreateSlider("Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section4:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)


spawn(function()
while wait() do
Save()
end end)
