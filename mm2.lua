local Config = {
    WindowName = "noobsploit",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightControl
}

repeat wait() until game:IsLoaded() wait()
game:GetService("Players").LocalPlayer.Idled:connect(function()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local Name = "SoulWar.json"

Des = {}
if makefolder then
    makefolder("noobsploit")
end

local Settings

if
    not pcall(
        function()
            readfile("noobsploit"//" .. Name)
        end
    )
 then
    writefile("noobsploit//" .. Name, game:GetService("HttpService"):JSONEncode(Des))
end

Settings = game:GetService("HttpService"):JSONDecode(readfile("noobsploit//" .. Name))

local function Save()
    writefile("noobsploit//" .. Name, game:GetService("HttpService"):JSONEncode(Settings))
end

repeat
    wait()
until game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

for i, v in pairs(Workspace:GetChildren()) do
    if v:IsA("BasePart") and v.Name ~= "Part" then
        v.CanCollide = false
    end
end

game:GetService("RunService").Stepped:connect(
    function()
        for i, v in pairs(game:GetService("ReplicatedStorage").Remotes.Extras.GetPlayerData:InvokeServer()) do
            if v.Role == "Murderer" then
                Settings.Murderer = i
            end
        end

        for i, v in pairs(game:GetService("ReplicatedStorage").Remotes.Extras.GetPlayerData:InvokeServer()) do
            if v.Role == "Sheriff" then
                Settings.Sheriff = i
            end
        end
    end
)

local L = {}
function GodModeFunc()
    if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            for _, accessory in pairs(game.Players.LocalPlayer.Character.Humanoid:GetAccessories()) do
                table.insert(L, accessory:Clone())
            end
            game.Players.LocalPlayer.Character.Humanoid.Name = "1"
        end
        local l = game.Players.LocalPlayer.Character["1"]:Clone()
        l.Parent = game.Players.LocalPlayer.Character
        l.Name = "Humanoid"
        wait(0.1)
        game.Players.LocalPlayer.Character["1"]:Destroy()
        workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        for _, accessory in pairs(L) do
            game.Players.LocalPlayer.Character.Humanoid:AddAccessory(accessory)
        end
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        wait(0.1)
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        --Tag:
        local Tag = Instance.new("BoolValue", game.Players.LocalPlayer.Character)
        Tag.Name = "GodMode"
        Tag.Value = true
        spawn(
            function()
                local Jumping = false
                local Died = false
                game.Players.LocalPlayer.Character.Humanoid.Died:connect(
                    function()
                        Died = true
                    end
                )
                game:GetService("UserInputService").InputBegan:connect(
                    function(i, v)
                        if not v and not Died then
                            Jumping = false
                            spawn(
                                function()
                                    repeat
                                        game:GetService("RunService").RenderStepped:Wait()
                                    until not Jumping or Died
                                end
                            )
                        else
                            repeat
                                game:GetService("RunService").RenderStepped:Wait()
                            until not Jumping
                        end
                    end
                )
                game:GetService("UserInputService").InputEnded:connect(
                    function(i, v)
                        if not v and not Died then
                            Jumping = false
                        end
                    end
                )
            end
        )
    end
end

function GetClosestCoin()
    local TargetDistance = 100
    local Target
    for i, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("CoinContainer") then
            for i, v in pairs(v.CoinContainer:GetChildren()) do
                if v.Name == "Coin_Server" and v.Name ~= "CollectedCoin" then
                    local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude
                    if mag < TargetDistance then
                        TargetDistance = mag
                        CoinTarget = v
                    end
                end
            end
        end
    end
end

spawn(
    function()
        while wait() do
            pcall(
                function()
                    if
                        Settings.Coin and game.Players.LocalPlayer.PlayerGui.MainGUI.Game.CashBag.Visible and
                            not game.Players.LocalPlayer.PlayerGui.MainGUI.Game.CashBag.Full.Visible and
                            game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                     then
                        AutoFarming = true
                        if Settings.GodMode and not game.Players.LocalPlayer.Character:FindFirstChild("GodMode") then
                            GodModeFunc()
                        end
                        GetClosestCoin()
                        if CoinTarget ~= nil then
                            spawn(
                                function()
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                        CFrame.new(
                                        CoinTarget.Position.X,
                                        CoinTarget.Position.Y + 1.5,
                                        CoinTarget.Position.Z
                                    )
                                    wait()
                                    firetouchinterest(
                                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                                        CoinTarget,
                                        0
                                    )
                                    firetouchinterest(
                                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                                        CoinTarget,
                                        1
                                    )
                                end
                            )
                        end
                        wait(2)
                        CoinTarget = nil
                        AutoFarming = false
                    end
                end
            )
        end
    end
)

game:GetService("RunService").Stepped:connect(
    function()
        if Settings.Coin then
            pcall(
                function()
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                end
            )
        end
    end
)


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/crosszay1/noobsploit/main/test.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Mm2")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("")
local Section2 = Tab1:CreateSection("")
local Section3 = Tab2:CreateSection("Menu")
local Section4 = Tab2:CreateSection("Background")
local Toggle1 = Section1:CreateToggle("Murder Silent Aim", Settings.SilentAim, function(State)

Settings.SilentAim = State

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayerToCurser()
    local MaxDistance, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v ~= LocalPlayer and v.Character then
            local H = v.Character.FindFirstChild(v.Character, "Head")
            if H then 
                local Pos, Vis = workspace.CurrentCamera.WorldToScreenPoint(workspace.CurrentCamera, H.Position)
                if Vis then
                    local A1, A2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                    local Dist = (A2 - A1).Magnitude
                    if Dist < MaxDistance and Dist <= math.huge then
                        MaxDistance = Dist
                        Closest = v
                    end
                end
            end
        end
    end
    return Closest
end
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self,...)
    local Args = {...}
    if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() and  Settings.SilentAim then
        local GivemeHead = ClosestPlayerToCurser()
        if GivemeHead and GivemeHead.Character and GivemeHead.Character.FindFirstChild(GivemeHead.Character, "UpperTorso") then
            Args[1] = Ray.new(workspace.CurrentCamera.CFrame.Position, (GivemeHead.Character.UpperTorso.Position - workspace.CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNameCall(self, unpack(Args))
        end
    end
    return OldNameCall(self, ...)
end)
end)
local Toggle1 = Section1:CreateToggle("Sheriff Silent Aim", Settings.SilentAim1, function(State)
Settings.SilentAim1 = State
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayerToCurser()
    local MaxDistance, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v ~= LocalPlayer and v.Name == getgenv().Murder and v.Character then
            local H = v.Character.FindFirstChild(v.Character, "Head")
            if H then 
                local Pos, Vis = workspace.CurrentCamera.WorldToScreenPoint(workspace.CurrentCamera, H.Position)
                if Vis then
                    local A1, A2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                    local Dist = (A2 - A1).Magnitude
                    if Dist < MaxDistance and Dist <= math.huge then
                        MaxDistance = Dist
                        Closest = v
                    end
                end
            end
        end
    end
    return Closest
end
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self,...)
    local Args = {...}
    if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() and  Settings.SilentAim1  then
        local GivemeHead = ClosestPlayerToCurser()
        if GivemeHead and GivemeHead.Character and GivemeHead.Character.FindFirstChild(GivemeHead.Character, "UpperTorso") then
            Args[1] = Ray.new(workspace.CurrentCamera.CFrame.Position, (GivemeHead.Character.UpperTorso.Position - workspace.CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNameCall(self, unpack(Args))
        end
    end
    return OldNameCall(self, ...)
end)
end)
local Toggle1 = Section1:CreateToggle("AutoFarm", Settings.Coin, function(State)
Settings.Coin = State

end)
local Toggle1 = Section1:CreateToggle("GodMode AutoFarm", Settings.GodMode, function(State)

Settings.GodMode = State
Settings.Coin = Settings.GodMode
end)
local Toggle1 = Section1:CreateToggle("Auto Invis", Settings.Hentai, function(State)
Settings.Hentai = State
local savepos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-85.1800766, 137.657455, -58.091156)
wait(0.5)
local Clone = game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Clone()
game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Destroy()
Clone.Parent = game:GetService("Players").LocalPlayer.Character.LowerTorso
wait(0.5)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savepos
game.Players.LocalPlayer.CharacterAdded:Connect(
    function()
        wait(3)
        local savepos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        
        if Settings.Hentai then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-85.1800766, 137.657455, -58.091156)
            wait(0.5)
            local Clone = game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Clone()
            game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Destroy()
            Clone.Parent = game:GetService("Players").LocalPlayer.Character.LowerTorso
            wait(0.5)

            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savepos
        end
    end
)

end)

local Toggle1 = Section1:CreateToggle("Lag Server", Settings.Hi, function(State)
Settings.Hi = State
spawn(
    function()
        while wait() and Settings.Hi do
            game:GetService("ReplicatedStorage").Remotes.Inventory.Equip:FireServer("DefaultKnife", "Weapons")
            game:GetService("ReplicatedStorage").Remotes.Inventory.Equip:FireServer("Xbox", "Weapons")
        end
    end
)
end)
local Button1 = Section1:CreateButton("GodMode", function()
GodModeFunc()
end)

local Button1 = Section2:CreateButton("Floss", function()
game:GetService("ReplicatedStorage").Remotes.Misc.PlayEmote:Fire("floss")
end)

local Button1 = Section2:CreateButton("Zen", function()
game:GetService("ReplicatedStorage").Remotes.Misc.PlayEmote:Fire("zen")
end)

local Button1 = Section2:CreateButton("Sit", function()
game:GetService("ReplicatedStorage").Remotes.Misc.PlayEmote:Fire("sit")
end)

local Button1 = Section2:CreateButton("Dab", function()
game:GetService("ReplicatedStorage").Remotes.Misc.PlayEmote:Fire("dab")
end)

local Toggle1 = Section2:CreateToggle("Enable WalkSpeed/JumpPower", Settings.Go, function(State)
Settings.Go = State
game:GetService("RunService").Stepped:connect(
    function()
        if Settings.Go then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = Settings.WalkSpeed
       	    if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').UseJumpPower then
			game.Players.LocalPlayer.Character:WaitForChild('Humanoid').JumpPower = Settings.JumpPower
		    else
			game.Players.LocalPlayer.Character:WaitForChild('Humanoid').JumpHeight  = Settings.JumpPower
			end 
            if not game:GetService("UserInputService").WindowFocusReleased then
                setfpscap(Settings.Fps)
            end
        end
    end
)

end)

local TextBox1 = Section2:CreateTextBox("Fps Cap", "Only numbers", true, function(Value)
    Settings.Fps = Value
end)

local TextBox1 = Section2:CreateTextBox("WalkSpeed", "Only numbers", true, function(Value)
    Settings.WalkSpeed = Value
end)
local TextBox1 = Section2:CreateTextBox("JumpPower", "Only numbers", true, function(Value)
    Settings.JumpPower = Value
end)



local Toggle1 = Section2:CreateToggle("Infinite Jump", Settings.InfiniteJump, function(State)
Settings.InfiniteJump = State
game:GetService("UserInputService").JumpRequest:connect(
    function()
        if Settings.InfiniteJump then
            game:GetService "Players".LocalPlayer.Character:FindFirstChildOfClass "Humanoid":ChangeState("Jumping")
        end
    end
)
end)

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/crosszay1/noobsploit/main/esp.lua"))()
ESP.Overrides.GetColor = function(v)
    if v == game.Workspace[Settings.Murderer] then return Color3.fromRGB(255,0,0) end 
    if v ==  game.Workspace[Settings.Sheriff] then return Color3.fromRGB(0,0,255) end
    return Color3.fromRGB(0, 255, 0)
end


local Toggle1 = Section1:CreateToggle("Enable Esp", Settings.Esp, function(State)
    Settings.Esp = State
    ESP:Toggle(Settings.Esp)
end)

local Toggle1 = Section1:CreateToggle("PLayer Esp", Settings.PlayerEsp, function(State)
    Settings.PlayerEsp = State
    ESP.Players = Settings.PlayerEsp
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

local Toggle1 = Section2:CreateToggle("Invisicam", Settings.Sorry, function(State)
Settings.Sorry = State
if Settings.Sorry then
    game:GetService("Players").LocalPlayer.DevCameraOcclusionMode = "Invisicam"
else
    game:GetService("Players").LocalPlayer.DevCameraOcclusionMode = "Zoom"
end
end)

local Toggle1 = Section2:CreateToggle("N Noclip", Settings.Sex1, function(State)
noclips = false
Settings.Sex1 = State
game.Players.LocalPlayer:GetMouse().KeyDown:connect(
    function(v)
        if v == "n" then
            if Settings.Sex1 then
                noclips = not noclips
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        pcall(function()
                        v.CanCollide = false
                        end)
                    end
                end
            end
        end
    end
)
game:GetService("RunService").Stepped:connect(
    function()
        if noclips then
            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    pcall(function()
                    v.CanCollide = false
                    end)
                end
            end
        end
    end
)

end)

local Toggle1 = Section2:CreateToggle("G Noclip", Settings.Sex, function(State)
Settings.Sex = State
noclip = false
game:GetService("RunService").Stepped:connect(
    function()
        if noclip then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end
    end
)
mouse = game.Players.LocalPlayer:GetMouse()
game.Players.LocalPlayer:GetMouse().KeyDown:connect(
    function(v)
        if v == "g" then
            if Settings.Sex then
                noclip = not noclip
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
            end
        end
    end
)
end)
local Toggle1 = Section2:CreateToggle("H Fly", Settings.Sex2, function(State)
Settings.Sex2 = State
local Max = 0
local Players = game.Players
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
Mouse.KeyDown:connect(
    function(k)
        if k:lower() == "h" then
            Max = Max + 1
            getgenv().Fly = false
            if Settings.Sex2 then
                local T = LP.Character.UpperTorso
                local S = {
                    F = 0,
                    B = 0,
                    L = 0,
                    R = 0
                }
                local S2 = {
                    F = 0,
                    B = 0,
                    L = 0,
                    R = 0
                }
                local SPEED = 5
                local function FLY()
                    getgenv().Fly = true
                    local BodyGyro = Instance.new("BodyGyro", T)
                    local BodyVelocity = Instance.new("BodyVelocity", T)
                    BodyGyro.P = 9e4
                    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                    BodyGyro.cframe = T.CFrame
                    BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                    BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
                    spawn(
                        function()
                            repeat
                                wait()
                                LP.Character.Humanoid.PlatformStand = false
                                if S.L + S.R ~= 0 or S.F + S.B ~= 0 then
                                    SPEED = 50
                                elseif not (S.L + S.R ~= 0 or S.F + S.B ~= 0) and SPEED ~= 0 then
                                    SPEED = 0
                                end
                                if (S.L + S.R) ~= 0 or (S.F + S.B) ~= 0 then
                                    BodyVelocity.velocity =
                                        ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (S.F + S.B)) +
                                        ((game.Workspace.CurrentCamera.CoordinateFrame *
                                            CFrame.new(S.L + S.R, (S.F + S.B) * 0.2, 0).p) -
                                            game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                                        SPEED
                                    S2 = {
                                        F = S.F,
                                        B = S.B,
                                        L = S.L,
                                        R = S.R
                                    }
                                elseif (S.L + S.R) == 0 and (S.F + S.B) == 0 and SPEED ~= 0 then
                                    BodyVelocity.velocity =
                                        ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (S2.F + S2.B)) +
                                        ((game.Workspace.CurrentCamera.CoordinateFrame *
                                            CFrame.new(S2.L + S2.R, (S2.F + S2.B) * 0.2, 0).p) -
                                            game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                                        SPEED
                                else
                                    BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                                end
                                BodyGyro.cframe = game.Workspace.CurrentCamera.CoordinateFrame
                            until not getgenv().Fly
                            S = {
                                F = 0,
                                B = 0,
                                L = 0,
                                R = 0
                            }
                            S2 = {
                                F = 0,
                                B = 0,
                                L = 0,
                                R = 0
                            }
                            SPEED = 0
                            BodyGyro:destroy()
                            BodyVelocity:destroy()
                            LP.Character.Humanoid.PlatformStand = false
                        end
                    )
                end
                Mouse.KeyDown:connect(
                    function(k)
                        if k:lower() == "w" then
                            S.F = 1
                        elseif k:lower() == "s" then
                            S.B = -1
                        elseif k:lower() == "a" then
                            S.L = -1
                        elseif k:lower() == "d" then
                            S.R = 1
                        end
                    end
                )
                Mouse.KeyUp:connect(
                    function(k)
                        if k:lower() == "w" then
                            S.F = 0
                        elseif k:lower() == "s" then
                            S.B = 0
                        elseif k:lower() == "a" then
                            S.L = 0
                        elseif k:lower() == "d" then
                            S.R = 0
                        end
                    end
                )
                FLY()
                if Max == 2 then
                    getgenv().Fly = false
                    Max = 0
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

local Button1 = Section2:CreateButton("Teleport to RandomPlayer", function()
local randomPlayer = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
    CFrame.new(
    Vector3.new(
        randomPlayer.Character.Head.Position.X,
        randomPlayer.Character.Head.Position.Y,
        randomPlayer.Character.Head.Position.Z
    )
)
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
