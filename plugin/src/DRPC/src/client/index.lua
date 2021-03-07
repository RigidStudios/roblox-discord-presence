local client = {};
local DRPC = script:FindFirstAncestor("DRPC");

local ActivityCreator = require(DRPC.src.generators.activityCreator);
local Data = require(DRPC.src.dataHandler);

function client:ProvidePlugin(plugin)
	client.plugin = plugin;
end;

function client.new(Http, _debug)
	local self = setmetatable({ Http = Http, _debug = _debug }, { __index = client });
	
	return self;
end;

function client:Close()
	self.Http:Post({
		updateType = "CLOSE";
	});
end;

function client:SetActivity()
	return self.Http:Post({
		updateType = "SET_ACTIVITY";
		activity   = ActivityCreator:Get();
	});
end;

function client:Open()
	return self:SetActivity();
end;

-- Initiate with cb -> callback(success<bool>, response<string>);
function client:login(cb)
	self.Enabled = true;

	local success, reply;
	if Data:Get("Enabled") then
		success, reply = self:Open();
	else
		success = false;
	end;

	spawn(function()
		while 1 do
			wait(2.6); -- Accuracy un-necessary.
			
			if Data:Get("Enabled") then
				print(ActivityCreator:Get());
				self:SetActivity();
			end;
		end;
	end);

	if cb then
		cb(success, reply);
	end;

	client.plugin.Unloading:Connect(function()
		self:Close();
	end);
end;

return client;
