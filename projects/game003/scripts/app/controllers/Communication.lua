local Communication = class("Communication")
local url = "http://168.168.8.105:8765"

function Communication:ctor()
end

function Communication:onRequestFinished( event )
	local request = event.request
	if event.name == "complete" then
		local code = request:getResponseStatusCode()
		if code ~= 200 then
			printf("Response not complete, Code : %d",code)
			return
		end
		local response = request:getResponseString()
		printf("Server Return Success : %s",response)
	else
		printf("Request failed, Code:%d, Message:%s", request:getErrorCode(), request:getErrorMessage())	
	end
end

function Communication:doRequest(params)
	local request = network.createHTTPRequest(self.onRequestFinished, url, "POST")
	request:addPOSTValue("param",params)
	request:start()
end

return Communication