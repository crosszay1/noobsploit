local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("YouTube Example Hub", "Ocean")
    -- MAIN
    local Main = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")


    MainSection:NewButton("animation hub", function()
        loadstring(game:HttpGet('https://pastebin.com/raw/5uWN0CYj'))()
    end)

    MainSection:NewToggle("Super-Human", "go fast and jump high", function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 120
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end)

    MainSection:NewButton("Infinite Yield", "FE Admin Commands", function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
    end)


    --LOCAL PLAYER
    local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")

    PlayerSection:NewSlider("Walkspeed", "SPEED!!", 500, 16, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)

    PlayerSection:NewSlider("Jumppower", "JUMP HIGH!!", 350, 50, function(s)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
    end)

    PlayerSection:NewButton("Reset WS/JP", "Resets to all defaults", function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)


    --Other
    local Other = Window:NewTab("Other")
    local OtherSection = Other:NewSection("Other")

    OtherSection:NewButton("boombox gui", "make up to 9 diffrent stuff with boombox", function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/kzRMKgDU'),true))()
    end)

    OtherSection:NewButton("pro border script", "exactly what it sounds like", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/crosszay1/noobsploit/main/pro%20border.lua"))() 

        Fly(true)
    end)
