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

-- ���������� � ������
local tweenInfo = TweenInfo.new(1)

-- �������� ������� ��� ��������� ����� CFrame
local function createGoal(hinge, angle)
	return {CFrame = hinge.CFrame * CFrame.Angles(0, math.rad(angle), 0)}
end

-- ���� ��� �������� � �������� ������
local goals = {
	open = {createGoal(hinge, 90), createGoal(hinge2, -90)},
	close = {createGoal(hinge, 0), createGoal(hinge2, 0)}
}

-- �������� ������ ��� ������
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

-- �������, ������� ����������� ��� ������� �������
local function onSensorTouched(hit)
	local model = hit.Parent

	if model and model:IsA("Model") and model.Name == Ticket then
		print("����� ������� " .. Ticket .. " ��������� �������.")
		
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
		-- ������ �������� ��� �������� ������
		playTweens(tweens.open)
		opens1:Play()
		opens2:Play()

		wait(3)  -- �������� ����� ��������� ������

		-- ������ �������� ��� �������� ������
		playTweens(tweens.close)
		close1:Play()
		close2:Play()
		Scaner.CanTouch = true
		
	else
		print("������������ ������ ��� ������ ��������� �������: " .. model.Name)
	end
end

Scaner.Touched:Connect(onSensorTouched)  -- �������� ������� � ������� ������� �������
