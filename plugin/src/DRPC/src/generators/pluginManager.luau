local pluginManager = {};

local DRPC = script:FindFirstAncestor("DRPC");
local Data = require(DRPC.src.dataHandler);
local UI = require(DRPC.src.ui.index);

function pluginManager:Init(plugin: Plugin)
    local toolbar = plugin:CreateToolbar("DRPC by RigidStudios#6315");

    local showButton = toolbar:CreateButton("Settings", "Set the parameters of your activity and toggle the plugin.", "rbxassetid://6540060106", "DRPC Settings");

    --local pEnabled = Data:Get("GUI_Open");
    -- local enabled = pEnabled == nil or pEnabled;
    local enabled = false;

	UI.settingsGui.Enabled = enabled;

    showButton.Click:Connect(function()
        enabled = not enabled;

        UI.settingsGui.Enabled = enabled;
        Data:Set("GUI_Open", enabled);
    end);
end;

return pluginManager;