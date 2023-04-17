
local API_KEY = "CHAT GPT API KEY"
-- You can get your API in the next Link
-- https://platform.openai.com/account/api-keys
local MODEL_ID = "gpt-3.5-turbo"
local API_URL = "https://api.openai.com/v1/chat/completions"

function chatGPT(msg)

	local data = {
		model = MODEL_ID,
		messages = {{role = "user", content = msg}},
		max_tokens = 35,
		n = 1,
		stop = "\n",
		temperature = 0.5
	}

	local jsonData = toJSON(data)
	local jsonData = string.sub(jsonData, 3, #jsonData - 2)

	local sendOptions = {
		headers = {
			["Content-Type"] = "application/json",
			["Authorization"] = "Bearer "..API_KEY
		},
		postData = jsonData,
	}

	fetchRemote ( API_URL, sendOptions, respuestaChatGTP )
end

function respuestaChatGTP(responseData) 
	local jsonData = fromJSON(responseData)
	msg = jsonData['choices'][1]['message']['content']
	--outputDebugString("(ChatGPT callback) responseData: "..msg)
	outputChatBox("ChatGTP: "..msg, getRootElement(), 255, 0, 0, true)
end

function Command( _, _, msg)
	local msg = table.concat ( { msg }, " " )
	chatGPT(msg)
end
addCommandHandler("chatgpt",Command)
