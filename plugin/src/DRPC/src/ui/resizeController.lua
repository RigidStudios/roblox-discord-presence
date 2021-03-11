local module = {}

local Text = game:GetService("TextService");

function module:Init(settingsGui)
	for i, field in pairs(game:GetService("CollectionService"):GetTagged("DRPC_ExpandableVertical")) do
		if not field:IsDescendantOf(settingsGui) then continue end;

		field:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			if field.Name == "InputBoxLabel" then
				local labSize = Text:GetTextSize(field.Text, 23, Enum.Font.Code, Vector2.new(field.AbsoluteSize.X, math.huge));
				local urlSize = Text:GetTextSize(field.Parent.InputBoxURL.Text, 23, Enum.Font.Code, Vector2.new(field.AbsoluteSize.X, math.huge));
				field.Parent.Size = UDim2.new(1, 0, 0, math.max(labSize.Y, urlSize.Y) + 2);
			else
				local size = Text:GetTextSize(field.Text, 23, Enum.Font.Code, Vector2.new(field.AbsoluteSize.X, math.huge));
				field.Parent.Size = UDim2.new(1, 0, 0, size.Y + 2);
			end
		end)
	end;
end

return module
