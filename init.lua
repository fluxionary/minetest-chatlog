local mod_name = minetest.get_current_modname()

local function log(level, message)
    minetest.log(level, ('[%s] %s'):format(mod_name, message))
end

log('action', 'CSM loading...')

local LOG_LEVEL = 'action'

local server_info = minetest.get_server_info()
local server_id = server_info.address .. ':' .. server_info.port
local my_name = ''

local register_on_send = minetest.register_on_sending_chat_message or minetest.register_on_sending_chat_messages
local register_on_receive = minetest.register_on_receiving_chat_message or minetest.register_on_receiving_chat_messages


local function safe(func)
    -- wrap a function w/ logic to avoid crashing the game
    local f = function(...)
        local status, out = pcall(func, ...)
        if status then
            return out
        else
            log('warning', 'Error (func):  ' .. out)
            return nil
        end
    end
    return f
end

local set_my_name_tries = 0
local set_my_name = safe(function()
    if minetest.localplayer then
        my_name = minetest.localplayer:get_name()
    end

    if set_my_name_tries < 20 then
        set_my_name_tries = set_my_name_tries + 1
    else
        my_name = ''
        log('warning', 'could not set name!')
        return
    end

    if my_name == nil or my_name == '' then
        minetest.after(1, set_my_name)
    end
end)


if minetest.register_on_connect then
    minetest.register_on_connect(set_my_name)
elseif minetest.register_on_mods_loaded then
    minetest.register_on_mods_loaded(set_my_name)
else
    minetest.after(1, set_my_name)
end


if register_on_send then
    register_on_send(safe(function(message)
        local msg = minetest.strip_colors(message)
        if msg ~= '' then
            log(LOG_LEVEL, ('%s@%s [sent] %s'):format(my_name, server_id, msg))
        end
    end))
else
    log('warning', 'can\'t find minetest.register_on_sending_chat_message')
end

if register_on_receive then
    register_on_receive(safe(function(message)
        local msg = minetest.strip_colors(message)
        if msg ~= '' then
            log(LOG_LEVEL, ('%s@%s %s'):format(my_name, server_id, msg))
        end
    end))
else
    log('warning', 'can\'t find minetest.register_on_receiving_chat_message')
end
