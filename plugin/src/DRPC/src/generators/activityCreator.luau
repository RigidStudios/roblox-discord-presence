local activityCreator = {};

local DRPC = script:FindFirstAncestor("DRPC");

local Activity = require(DRPC.src.activity).new();
local FormatString = require(DRPC.src.generators.formatString);
local Data = require(DRPC.src.dataHandler);

function eval(item)
	if item == "" then return false end;
	if item == nil then return false end;
	if item == false then return false end;
	if item == 0 then return false end;
	if pcall(function() return #item end) and #item == 0 then return false end;
	return true;
end;

function activityCreator:Get()
	local savedDescription = Data:Get("Description");
	local savedState = Data:Get("State");

	Activity
		:clear()
		:setDescription(FormatString:process(eval(savedDescription) and savedDescription or "$ACTIVITY:Editing $SCRIPT_NAME ($SCRIPT_LINES lines)"))
		:setState(FormatString:process(eval(savedState) and savedState or "Workspace: $WORKSPACE"))
		:setImage("studio");

	if eval(Data:Get("EnabledTS")) then
		Activity:setTimer();
	end;

	for _, button in pairs(Data:Get("Buttons") or {}) do
		-- Semi-Blank labels aren't allowed.
		if not (eval(button.label) and eval(button.url)) then continue end;

		Activity:addButton(FormatString:process(button.label), FormatString:process(button.url));
	end;
	
	return Activity;
end;

return activityCreator;
