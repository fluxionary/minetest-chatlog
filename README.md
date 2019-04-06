make sure the mod is installed at ~/.minetest/clientmods/chatlog

make sure ~/.minetest/clientmods/mods.conf exists and contains:

load_mod_chatlog = true

logs will show up in ~/.minetest/debug.txt

if you use another CSM that handles chat messages e.g. friendly_chat, you may have to put an entry like

chatlog?

into that mod's depends.txt file.
