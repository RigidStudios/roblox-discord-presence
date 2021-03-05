local activityCreator = {};

local DRPC = script:FindFirstAncestor("DRPC");
local Activity = require(DRPC.src.activity).new();
local FormatString = require(DRPC.src.generators.formatString);
local Data = require(DRPC.src.dataHandler);

function activityCreator:Get()
	local construct = Activity
		:clear()
		:setDescription(FormatString:process(Data:Get("Description") or "Editing $SCRIPT_NAME ($SCRIPT_LINES lines)"))
		:setState(FormatString:process(Data:Get("State") or "Workspace: $WORKSPACE"))
		:setImage("studio");
	
	for _, button in pairs(Data:Get("Buttons") or {}) do
		-- Semi-Blank labels aren't allowed.
		if button.label == "" or button.url == "" then continue end;
		Activity:addButton(button.label, button.url);
	end;
	
	return Activity
end;

return activityCreator;
