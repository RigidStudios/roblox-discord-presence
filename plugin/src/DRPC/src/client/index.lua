local client = {};

local DRPC = script:FindFirstAncestor("DRPC");
local ActivityCreator = require(DRPC.src.generators.activityCreator);

function client.new(Http, _debug)
	local self = setmetatable({ Http = Http, _debug = _debug }, { __index = client });
	return self;
end;

function client:Close()
	self.Http:Post({
		updateType = "CLOSE";
	});
	
	self.Enabled = false;
end;

function client:SetActivity()
	return self.Http:Post({
		updateType = "SET_ACTIVITY";
		activity   = ActivityCreator:Get();
	});
end;

function client:Open()
	self.Enabled = true;
	
	return self:SetActivity();
end;

-- Initiate with cb -> callback(success<bool>, response<string>);
function client:login(cb)
	self.Enabled = true;
	
	local success, reply = self:Open();

	spawn(function()
		while 1 do
			wait(2.6); -- Accuracy un-necessary.
			
			if self.Enabled then
				self:SetActivity();
			end
		end
	end)
	
	if cb then
		cb(success, reply);
	end;
end;

return client;
