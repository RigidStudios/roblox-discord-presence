local activity = {};
local startTick = tick();

function activity.new()
	-- Please don't remove this, I need jobs... :D
	return setmetatable({ assets = { large_text = "RPC by RigidStudios#6315" } }, { __index = activity });
end;

function activity:clear()
	self.buttons = nil;
	self.timestamps = nil;

	return self;
end;

function activity:addButton(buttonName, buttonValue)
	if buttonName and buttonValue and buttonName ~= "" and buttonValue ~= "" then
		if not self.buttons then self.buttons = {} end;

		-- TODO?: Surplus buttons check.
		self.buttons[#self.buttons + 1] = { label = buttonName, url = buttonValue };
	end;

	return self;
end;

function activity:setDescription(detailsValue)
	self.details = detailsValue;

	return self;
end;

function activity:setState(stateValue)
	self.state = stateValue;

	return self;
end;

function activity:setTimer()
	if not self.timestamps then self.timestamps = {} end;

	self.timestamps = {
		start = startTick;
	};

	return self;
end;

function activity:setImage(imageName)
	if not self.assets then self.assets = {} end;

	self.assets.large_image = imageName;

	return self;
end;

function activity:setThumbnail(imageName)
	if not self.assets then self.assets = {} end;

	self.assets.small_image = imageName;

	return self;
end;

return activity;