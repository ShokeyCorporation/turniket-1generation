local TweenService = game:GetService("TweenService")
local Ticket = "Pass"
local hinge = script.Parent.Doorframe.Hinge
local hinge2 = script.Parent.Doorframe.h2
local Scaner = script.Parent.Scanner.Part
local screen = script.Parent.Parent.Parent.Screen.Union.SurfaceGui
local framee = screen.Framee
local done = screen.Done
local load = screen.Loading
local sound = script.NewOkno
local close1 = script.Parent.B2.Sound
local close2 = script.Parent.Base.Sound

-- Информация о твинах
local tweenInfo = TweenInfo.new(1)

-- Создание функции для генерации целей CFrame
local function createGoal(hinge, angle)
	return {CFrame = hinge.CFrame * CFrame.Angles(0, math.rad(angle), 0)}
end

-- Цели для открытия и закрытия дверей
local goals = {
	open = {createGoal(hinge, 90), createGoal(hinge2, -90)},
	close = {createGoal(hinge, 0), createGoal(hinge2, 0)}
}

-- Создание твинов для дверей
local tweens = {
	open = {
		TweenService:Create(hinge, tweenInfo, goals.open[1]),
		TweenService:Create(hinge2, tweenInfo, goals.open[2])
	},
	close = {
		TweenService:Create(hinge, tweenInfo, goals.close[1]),
		TweenService:Create(hinge2, tweenInfo, goals.close[2])
	}
}

local opens1 = script.Parent.Base.Open
local opens2 = script.Parent.B2.Open

local function playTweens(tweenGroup)
	for _, tween in ipairs(tweenGroup) do
		tween:Play()
	end
end

-- Функция, которая срабатывает при касании сенсора
local function onSensorTouched(hit)
	local model = hit.Parent

	if model and model:IsA("Model") and model.Name == Ticket then
		print("Карта доступа " .. Ticket .. " коснулась сенсора.")
		
	    Scaner.CanTouch = false
		framee.One.Visible = false
		framee.Two.Visible = false
		framee.Three.Visible = false
		framee.Script.Enabled = false
		load.C.Visible = true
		load.Script.Enabled = true
		wait(2)
		sound:Play()
		load.C.Visible = false
		load.Script.Enabled = false
		done.C.Visible = true
		
		wait (2)
		done.C.Visible = false
		framee.One.Visible = true
		framee.Script.Enabled = true
		-- Запуск анимаций для открытия дверей
		playTweens(tweens.open)
		opens1:Play()
		opens2:Play()

		wait(3)  -- Ожидание перед закрытием дверей

		-- Запуск анимаций для закрытия дверей
		playTweens(tweens.close)
		close1:Play()
		close2:Play()
		Scaner.CanTouch = true
		
	else
		print("Недопустимый объект или модель коснулась сенсора: " .. model.Name)
	end
end

Scaner.Touched:Connect(onSensorTouched)  -- Привязка функции к событию касания сенсора
