# PremiumUILib ✨
## 👤 Author
Created by **potatomanty-stack**  
GitHub: https://github.com/potatomanty-stack
A modern, premium Roblox UI Library built for developers who want clean visuals, smooth animations, and flexibility.

## ✨ Features
- Normal buttons & toggle buttons (ON / OFF)
- Optional title bar
- Minimize animation into title bar
- Switchable scrollable or fixed layout
- Auto-fit UI (no overflow)
- Mobile & PC compatible
- Smooth animations
- Clean API

## 📦 Installation
1. Download `PremiumUILibrary.lua`
2. Place it in a **ModuleScript**
3. Require it from a **LocalScript**

## 🚀 Usage Example

```lua
local UI = require(path.to.PremiumUILibrary)

local Window = UI:CreateWindow({
    Title = "My Premium UI",
    Creator = "by ravexylon",
    TitleBar = true,
    Scrollable = false
})

Window:Button("Execute", function()
    print("Executed")
end)

Window:Toggle("Auto Farm", false, function(state)
    print("Auto Farm:", state)
end)
