minetest.log('action', '[chatlog] CSM loading...')

local register_on_message = core.register_on_sending_chat_message
if core.register_on_sending_chat_messages then
	register_on_message = core.register_on_sending_chat_messages
end

if register_on_message ~= nil then
    register_on_message(function(message)
        local msg = minetest.strip_colors(message)
        minetest.log('action', '[chatlog:sent] ' .. msg)
    end)
end

if minetest.register_on_receiving_chat_messages ~= nil then
    minetest.register_on_receiving_chat_messages(function(message)
        local msg = minetest.strip_colors(message)
        minetest.log('action', '[chatlog] ' .. msg)
    end)
end
