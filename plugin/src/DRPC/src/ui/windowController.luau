local module = {}

function module:Init(settingsGui)
	settingsGui.UI.Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		settingsGui.UI.Container.CanvasSize = UDim2.new(0, 0, 0, math.ceil(settingsGui.UI.Container.UIListLayout.AbsoluteContentSize.Y) + 25)
		settingsGui.UI.Scroller.Visible = settingsGui.UI.Container.UIListLayout.AbsoluteContentSize.Y + 25 > settingsGui.AbsoluteSize.Y
	end)
end

return module
