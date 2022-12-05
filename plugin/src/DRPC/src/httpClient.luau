local httpClient = {};
local HTTP = game:GetService("HttpService");

function httpClient.new(url)
	local self = setmetatable({ URL = url }, { __index = httpClient });
	return self;
end;

function httpClient:Post(requestBody)
	local success, reply = pcall(
		HTTP.PostAsync,
		HTTP, self.URL,
		HTTP:JSONEncode(requestBody)
	);

	if not success then
		-- warn("[Discord-RPC] HTTP Post failed.");
		warn(string.format("[Discord-RPC] HTTP Post failed: %s", reply));
	end;

	return success, reply;
end;

return httpClient;
