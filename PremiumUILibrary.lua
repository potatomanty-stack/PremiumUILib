--// Premium UI Library v2
local Library = {}

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--// Create Window
function Library:CreateWindow(config)
	local Window = {}
	config = config or {}

	local TitleEnabled = config.TitleBar ~= false
	local ScrollEnabled = config.Scrollable == true

	--// ScreenGui
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = player:WaitForChild("PlayerGui")
	ScreenGui.ResetOnSpawn = false

	--// Main Frame
	local Frame = Instance.new("Frame")
	Frame.Parent = ScreenGui
	Frame.Size = UDim2.fromScale(0.46, 0.55)
	Frame.Position = UDim2.fromScale(0.5, 0.5)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(18,18,22)
	Frame.Active = true
	Frame.ClipsDescendants = true

	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,22)

	local Stroke = Instance.new("UIStroke", Frame)
	Stroke.Color = Color3.fromRGB(170,90,255)
	Stroke.Thickness = 2

	local Gradient = Instance.new("UIGradient", Frame)
	Gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(22,22,30)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(14,14,18))
	}
	Gradient.Rotation = 90

	--// Title Bar
	local TopBarHeight = TitleEnabled and 70 or 0
	local TopBar

	if TitleEnabled then
		TopBar = Instance.new("Frame", Frame)
		TopBar.Size = UDim2.new(1,0,0,70)
		TopBar.BackgroundColor3 = Color3.fromRGB(24,24,32)
		Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0,22)

		local Title = Instance.new("TextLabel", TopBar)
		Title.Size = UDim2.new(1,-80,0,36)
		Title.Position = UDim2.new(0,12,0,10)
		Title.BackgroundTransparency = 1
		Title.Text = config.Title or "Premium UI"
		Title.Font = Enum.Font.GothamBold
		Title.TextSize = 26
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.TextColor3 = Color3.fromRGB(170,90,255)

		local Creator = Instance.new("TextLabel", TopBar)
		Creator.Size = UDim2.new(1,-80,0,20)
		Creator.Position = UDim2.new(0,12,0,42)
		Creator.BackgroundTransparency = 1
		Creator.Text = config.Creator or "by you"
		Creator.Font = Enum.Font.Gotham
		Creator.TextSize = 14
		Creator.TextXAlignment = Enum.TextXAlignment.Left

		-- Rainbow creator
		local hue = 0
		RunService.RenderStepped:Connect(function()
			hue = (hue + 0.004) % 1
			Creator.TextColor3 = Color3.fromHSV(hue,1,1)
		end)

		-- Minimize Button
		local MinBtn = Instance.new("TextButton", TopBar)
		MinBtn.Size = UDim2.new(0,40,0,40)
		MinBtn.Position = UDim2.new(1,-50,0,15)
		MinBtn.Text = "—"
		MinBtn.Font = Enum.Font.GothamBold
		MinBtn.TextSize = 24
		MinBtn.TextColor3 = Color3.new(1,1,1)
		MinBtn.BackgroundColor3 = Color3.fromRGB(170,90,255)
		MinBtn.AutoButtonColor = false
		Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0,12)

		local minimized = false
		local fullSize = Frame.Size

		MinBtn.MouseButton1Click:Connect(function()
			minimized = not minimized
			TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
				Size = minimized and UDim2.fromScale(0.46, 0.12) or fullSize
			}):Play()
		end)
	end

	--// Content Holder (Frame OR ScrollingFrame)
	local Holder

	if ScrollEnabled then
		Holder = Instance.new("ScrollingFrame", Frame)
		Holder.CanvasSize = UDim2.new(0,0,0,0)
		Holder.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Holder.ScrollBarImageTransparency = 0.6
	else
		Holder = Instance.new("Frame", Frame)
	end

	Holder.Size = UDim2.new(1,-36,1,-TopBarHeight-30)
	Holder.Position = UDim2.new(0,18,0,TopBarHeight+18)
	Holder.BackgroundTransparency = 1
	Holder.ClipsDescendants = true

	local Layout = Instance.new("UIListLayout", Holder)
	Layout.Padding = UDim.new(0,14)
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	--// Auto resize (non-scroll mode)
	local function ResizeItems()
		if ScrollEnabled then return end

		local items = 0
		for _,v in ipairs(Holder:GetChildren()) do
			if v:IsA("Frame") then
				items += 1
			end
		end
		if items == 0 then return end

		local totalPadding = Layout.Padding.Offset * (items - 1)
		local available = Holder.AbsoluteSize.Y - totalPadding
		local height = math.clamp(available / items, 55, 80)

		for _,v in ipairs(Holder:GetChildren()) do
			if v:IsA("Frame") then
				v.Size = UDim2.new(1,0,0,height)
			end
		end
	end

	Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ResizeItems)
	Holder:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeItems)

	--// NORMAL BUTTON
	function Window:Button(text, callback)
		local Item = Instance.new("Frame", Holder)
		Item.BackgroundTransparency = 1

		local Btn = Instance.new("TextButton", Item)
		Btn.Size = UDim2.new(1,0,1,0)
		Btn.Text = text
		Btn.Font = Enum.Font.GothamBold
		Btn.TextSize = 18
		Btn.TextColor3 = Color3.new(1,1,1)
		Btn.BackgroundColor3 = Color3.fromRGB(170,90,255)
		Btn.AutoButtonColor = false

		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,14)

		Btn.MouseButton1Click:Connect(function()
			if callback then callback() end
		end)

		ResizeItems()
	end

	--// TOGGLE BUTTON
	function Window:Toggle(text, default, callback)
		local state = default or false

		local Item = Instance.new("Frame", Holder)
		Item.BackgroundTransparency = 1

		local Label = Instance.new("TextLabel", Item)
		Label.Size = UDim2.new(1,0,0.45,0)
		Label.BackgroundTransparency = 1
		Label.Text = text
		Label.Font = Enum.Font.GothamBold
		Label.TextSize = 18
		Label.TextColor3 = Color3.new(1,1,1)

		local Toggle = Instance.new("TextButton", Item)
		Toggle.Size = UDim2.new(1,0,0.4,0)
		Toggle.Position = UDim2.new(0,0,0.55,0)
		Toggle.Font = Enum.Font.GothamBold
		Toggle.TextSize = 16
		Toggle.AutoButtonColor = false
		Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,12)

		local function Update()
			Toggle.Text = state and "ON" or "OFF"
			Toggle.BackgroundColor3 = state
				and Color3.fromRGB(120,255,170)
				or Color3.fromRGB(255,120,120)

			if callback then callback(state) end
		end

		Toggle.MouseButton1Click:Connect(function()
			state = not state
			Update()
		end)

		Update()
		ResizeItems()
	end

	--// Dragging (only if title exists)
	if TitleEnabled and TopBar then
		local dragging, dragStart, startPos

		TopBar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = Frame.Position
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
				local delta = input.Position - dragStart
				Frame.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end)

		UserInputService.InputEnded:Connect(function()
			dragging = false
		end)
	end

	return Window
end

return Library
