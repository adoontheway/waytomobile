local Communication = class("Communication")
local url = "http://168.168.8.105:8765"

function Communication:ctor()
end

function onRequestFinished( event )
	local request = event.request
	if event.name == "completed" then
		local code = request:getResponseStatusCode()
		if code ~= 200 then
			printf("Response not complete, Code : %d",code)
			return
		end
		local response = request:getResponseString()
		printf("Server Return Success : %s",response)
	else
		printf("Request failed, type:%s Code:%d, Message:%s", event.name, request:getErrorCode(), request:getErrorMessage())	
	end
end

function Communication:doRequest(params)
	local request = network.createHTTPRequest(onRequestFinished, url, "POST")
	local data = json.encode(params)
	--print(#data)
	--crypto.encryptXXTEA(data, "################")
	--print(#data)
	request:setPOSTData(data)
	request:start()
end

return Communication