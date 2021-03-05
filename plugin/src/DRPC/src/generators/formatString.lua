local formatString = {};
local DRPC = script:FindFirstAncestor("DRPC");

local Util = require(DRPC.src.util);
local StudioService = game:GetService("StudioService");

local Variables = {
	["%$SCRIPT_NAME"] = {Description = "Name of the current script", Obtain = function(src)
		if not src then return end;
		return src.Name;
	end};
	["%$SCRIPT_LINES"] = {Description = "Line count of the current script", Obtain = function(src)
		if not src then return end;
		return #src.Source:split("\n");
	end};
	["%$SCRIPT_PARENT"] = {Description = "Name of the current script's parent", Obtain = function(src)
		if not src then return end;
		return src.Parent.Name;
	end};
	["%$WORKSPACE"] = {Description = "Name of the current place", Obtain = function(src)
		print(Util.getPlaceName());
		return Util.getPlaceName();
	end};
	["%$ACTIVITY:<>"] = {Decription = "Away (No Script open), Idle (No Changes recently, <follow> (Editing)", Obtain = function(src, following)
		return Util.hasChanges() 
			and formatString:process(following or "Editing $SCRIPT_NAME ($SCRIPT_LINES lines)")
			or  (not StudioService.ActiveScript and "Away" or "Idle...");
	end};
}

function formatString:process(str)
	for identifier, value in pairs(Variables) do
		str = str:gsub(string.gsub(identifier, "<>", "(.+)"), function(...)
			return value.Obtain(StudioService.ActiveScript, ...);
		end);
	end;
	
	return str;
end;

return formatString;
