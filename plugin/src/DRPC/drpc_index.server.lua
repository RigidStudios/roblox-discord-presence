local DRPC = script:FindFirstAncestor("DRPC");

local Data = require(DRPC.src.dataHandler);
Data:ProvidePlugin(plugin);

local UI = require(DRPC.src.UIManager.index)(plugin);

local Http   = require(DRPC.src.httpClient).new("http://localhost:4455/");
local Client = require(DRPC.src.client.index).new(Http, false);

Data:AttachChange("Enabled", function(isEnabled)
	Client.Enabled = isEnabled;
	if not isEnabled then Client:Close() else Client:Open() end;
end);

Client:login(function(success)
	if success then
		warn("DRPC v1 by RigidStudios#6315 - Launched.");
	else
		warn("DRPC v1 by RigidStudios#6315 - Launch failed, try toggling enabled after starting up your local server.");
		Client.Enabled = false;
	end;
end);
