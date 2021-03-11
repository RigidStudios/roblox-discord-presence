local module = {};
local DRPC = script:FindFirstAncestor("DRPC");

local Text = game:GetService("TextService");
local Data = require(DRPC.src.dataHandler);

local rs = game:GetService("RunService").RenderStepped;

function module:onClick(element)
    return function()
        Data:Set("Enabled", module:Move(element, not Data:Get("Enabled")));
    end;
end;

function module:Init(element)
    local enabled = Data:Get("Enabled");
    self:Move(element.Value, enabled or enabled == nil);

	element.MouseButton1Click:Connect(self:onClick(element.Value));
    element.Value.MouseButton1Click:Connect(self:onClick(element.Value));
end;

function module:Move(element, enabled)
    if enabled then
        for i = 0, 1, .1 do
            element.Position = UDim2.fromScale(i, 0);
            element.Parent.BackgroundColor3 = Color3.fromRGB(13, 114, 232):Lerp(Color3.fromRGB(163, 162, 165), 1 - i);
            rs:Wait();
        end;
    else
        for i = 1, 0, -.1 do
            element.Position = UDim2.fromScale(i, 0);
            element.Parent.BackgroundColor3 = Color3.fromRGB(13, 114, 232):Lerp(Color3.fromRGB(163, 162, 165), 1 - i);
            rs:Wait();
        end;
    end;
    return enabled;
end;

return module;
