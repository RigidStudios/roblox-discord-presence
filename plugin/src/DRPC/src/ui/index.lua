local DRPC = script:FindFirstAncestor("DRPC");
local Assets = DRPC.assets;
local Text = game:GetService("TextService");

local Data = require(DRPC.src.dataHandler);
local UI = {};

function UI:ProvidePlugin(plugin)
	self.plugin = plugin;
end;

function UI:CreateControllers(settingsGui)
	-- Window Controller Init.
	require(DRPC.src.ui.windowController):Init(settingsGui);

	-- Resize Controller Init.
	require(DRPC.src.ui.resizeController):Init(settingsGui);

	-- Toggles Init.
	local toggleController = require(DRPC.src.ui.toggleController);
	toggleController.new("Enabled"):Init(settingsGui.UI.Container.Enable.Container.Switch);
	toggleController.new("EnabledTS"):Init(settingsGui.UI.Container.EnableTS.Container.Switch);
end;

function UI:CreateInputField(field, dataName, default)
	field.Text = Data:Get(dataName) or default;
	field.FocusLost:Connect(function()
		Data:Set(dataName, field.Text);
	end);
end;

function UI:CreateUI()
	if not self.plugin then return error("[Discord-RPC] UI Launched before plugin apparition.") end;

	local settingsGui: DockWidgetPluginGui = self.plugin:CreateDockWidgetPluginGui(
		"settingsGui",
		DockWidgetPluginGuiInfo.new(
			Enum.InitialDockState.Float,
			false,
			false
		)
	);

	Assets.UI:Clone().Parent = settingsGui;

	settingsGui.Title = "DRPC Settings";
	settingsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

	settingsGui:BindToClose(function()
		settingsGui.Enabled = false;
		Data:Set("GUI_Open", false);
	end);

	return settingsGui;
end;

function UI:CreateButtonInputController(dataButtons, buttonInput, index, subIndex)
	buttonInput.Text = dataButtons[index] and dataButtons[index][subIndex] or "";

	buttonInput.FocusLost:Connect(function()
		if not dataButtons[index] then
			dataButtons[index] = {};
		end;

		dataButtons[index][subIndex] = buttonInput.Text;

		Data:Set("Buttons", dataButtons);
	end);
end;

function UI:Start()
	self.settingsGui = self:CreateUI();

	-- Window Scroll/Field Resize/Toggle Handler
	self:CreateControllers(self.settingsGui);

	-- Input Fields
	self:CreateInputField(self.settingsGui.UI.Container.DescriptionInput.Input, "Description", "$ACTIVITY:Editing $SCRIPT_NAME ($SCRIPT_LINES lines)");
	self:CreateInputField(self.settingsGui.UI.Container.StateInput.Input, "State", "Workspace: $WORKSPACE");

	-- Buttons
	local savedButtons = Data:Get("Buttons") or {};
	local button1 = self.settingsGui.UI.Container.Button1;
	local button2 = self.settingsGui.UI.Container.Button2;

	self:CreateButtonInputController(savedButtons, button1.First.Input, 1, "url");
	self:CreateButtonInputController(savedButtons, button2.First.Input, 2, "url");
	self:CreateButtonInputController(savedButtons, button1.Second.Input, 1, "label");
	self:CreateButtonInputController(savedButtons, button2.Second.Input, 2, "label");

	-- Version Indicator
	local infoVersion = self.settingsGui.UI.Container.Info.Version;
	infoVersion.Text = "v0.2.1-alpha";
end;

return UI;