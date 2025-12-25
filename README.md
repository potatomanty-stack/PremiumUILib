# PremiumUILib ✨

## 👤 Author
Created by **potatomanty-stack**  
GitHub: [https://github.com/potatomanty-stack](https://github.com/potatomanty-stack)  

A modern, premium Roblox UI Library built for developers who want **clean visuals**, **smooth animations**, and **easy usage**.

## ✨ Features
- Normal buttons & toggle buttons (ON / OFF)  
- Optional title bar  
- Minimize animation into title bar  
- Switchable scrollable or fixed layout  
- Auto-fit UI (no overflow)  
- Mobile & PC compatible  
- Smooth animations  
- Clean and simple API  

## 📦 Installation (ModuleScript)
1. Download `PremiumUILibrary.lua`  
2. Put it into a **ModuleScript**  
3. Require it from a **LocalScript**

## 🚀 Usage Example (ModuleScript)
```lua
local UI = require(path.to.PremiumUILibrary)

local Window = UI:CreateWindow({
    Title = "My Premium UI",
    Creator = "potatomanty-stack",
    TitleBar = true,
    Scrollable = false
})

Window:Button("Execute", function()
    print("Executed")
end)

Window:Toggle("Auto Farm", false, function(state)
    print("Auto Farm:", state)
end)


local UI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/potatomanty-stack/PremiumUILib/refs/heads/main/PremiumUILibrary.lua"
))()

local Window = UI:CreateWindow({
    Title = "Premium UI Example",
    Creator = "potatomanty-stack",
    TitleBar = true,
    Scrollable = true
})

Window:Button("Hello", function()
    print("Hello from Premium UI")
end)

Window:Toggle("Enable Feature", false, function(state)
    print("Feature:", state)
end)

You can copy **everything between the triple backticks** and paste it directly into your README.md — it will render nicely on GitHub.  

If you want, I can also **add a “Getting Started” section with images and badges** to make it look professional. Do you want me to do that?
