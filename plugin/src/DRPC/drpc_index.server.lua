local DRPC = script:FindFirstAncestor("DRPC");

local Data = require(DRPC.src.dataHandler);
Data:ProvidePlugin(plugin);

local UI = require(DRPC.src.UIManager.index);
UI:ProvidePlugin(plugin);

local Client = require(DRPC.src.client.index);
Client:ProvidePlugin(plugin);

local Http   = require(DRPC.src.httpClient).new("http://localhost:4455/");
local ClientObj = Client.new(Http, false);

Data:AttachChange("Enabled", function(isEnabled)
	warn("Activation set to:", isEnabled);
	if not isEnabled then ClientObj:Close() else ClientObj:Open() end;
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
