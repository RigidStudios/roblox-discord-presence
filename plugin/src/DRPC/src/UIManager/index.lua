local DRPC = script:FindFirstAncestor("DRPC");
local Assets = DRPC.assets;
local Text = game:GetService("TextService");

local Data = require(DRPC.src.dataHandler);

return function(plugin)
	if not plugin then return end;
	
	local settingsGui = plugin:CreateDockWidgetPluginGui("settingsGui", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false));
	
	Assets.ScreenGui.Frame:Clone().Parent = settingsGui;
	settingsGui.Title   = "DRPC Settings";
	settingsGui.Enabled = true;
	
	local resizeController = require(DRPC.src.UIManager.resizeController):Init(settingsGui);
	
	local enabledButton = settingsGui.Frame.EnabledButton;
	enabledButton.ClickListener.Text = Data:Get("Enabled") and "Yes" or "No";
	print("Starting listener.")
	enabledButton.ClickListener.MouseButton1Click:Connect(function()
		print("Click detected.");
		local enabled = Data:Set("Enabled", not Data:Get("Enabled"));
		print(Data:Get("Enabled"));
		enabledButton.ClickListener.Text = enabled and "Yes" or "No";
	end);
	
	local descriptionEditor = settingsGui.Frame.DescriptionEditor;
	descriptionEditor.InputBox.Text = Data:Get("Description") or "Editing $SCRIPT_NAME ($SCRIPT_LINES Lines)";
	descriptionEditor.InputBox.FocusLost:Connect(function()
		Data:Set("Description", descriptionEditor.InputBox.Text);
	end);
	
	local statusEditor = settingsGui.Frame.StatusEditor;
	statusEditor.InputBox.Text = Data:Get("State") or "Workspace: $WORKSPACE";
	statusEditor.InputBox.FocusLost:Connect(function()
		Data:Set("State", statusEditor.InputBox.Text);
	end);
	
	local savedButtons = Data:Get("Buttons") or {};
	local button1 = settingsGui.Frame.Button1;
	local button2 = settingsGui.Frame.Button2;
	button1.InputBoxLabel.Text = savedButtons[1] and savedButtons[1].label or "";
	button2.InputBoxLabel.Text = savedButtons[2] and savedButtons[2].label or "";
	button1.InputBoxURL.Text = savedButtons[1] and savedButtons[1].url or "";
	button2.InputBoxURL.Text = savedButtons[2] and savedButtons[2].url or "";

	local function setLabel(i, prop, value)
		if not savedButtons[i] then
			savedButtons[i] = {};
		end;
		savedButtons[i][prop] = value;
		Data:Set("Buttons", savedButtons);
	end;
	
	button1.InputBoxLabel.FocusLost:Connect(function() setLabel(1, "label", button1.InputBoxLabel.Text) end);
	button2.InputBoxLabel.FocusLost:Connect(function() setLabel(2, "label", button1.InputBoxLabel.Text) end);
	button1.InputBoxURL.FocusLost:Connect(function() setLabel(1, "url", button1.InputBoxURL.Text) end);
	button2.InputBoxURL.FocusLost:Connect(function() setLabel(2, "url", button1.InputBoxURL.Text) end);
end;