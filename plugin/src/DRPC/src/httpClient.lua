local httpClient = {};
local HTTP = game:GetService("HttpService");

function httpClient.new(url)
	local self = setmetatable({ URL = url }, { __index = httpClient });
	return self;
end;

function httpClient:Post(requestBody)
	print("I am cheating death after all");
	print(debug.traceback());
	print(requestBody);

	local success, reply = pcall(function()
		return HTTP:PostAsync(self.URL, HTTP:JSONEncode(requestBody));
	end);
	
	if not success then
		return warn("[Discord-RPC] HTTP Post failed.");
	end;
	
	return success, reply;
end;

return httpClient;
