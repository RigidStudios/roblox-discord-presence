local DRPC = script:FindFirstAncestor("DRPC");

local env = {
	["plugin"] = plugin
}

for i,v in ipairs(DRPC:GetDescendants()) do
	if v:IsA("ModuleScript") then
		local m = require(v)
		setmetatable(m,{__index = env})
	end
end

local Data = require(DRPC.src.dataHandler);
local UI = require(DRPC.src.UIManager.index);
local Client = require(DRPC.src.client.index);

local Http   = require(DRPC.src.httpClient).new("http://localhost:4455/");
local ClientObj = Client.new(Http, false);

Data:AttachChange("Enabled", function(isEnabled)
	warn("Activation set to:", isEnabled);
	if isEnabled then ClientObj:Open() else ClientObj:Close() end;
end);

UI:Start();

print("Logging in.");

ClientObj:login(function(success)
	if success then
		warn("DRPC v1 by RigidStudios#6315 - Launched.");
	else
		warn("DRPC v1 by RigidStudios#6315 - Launch failed, try toggling enabled after starting up your local server.");
		ClientObj.Enabled = false;
	end;
end);
