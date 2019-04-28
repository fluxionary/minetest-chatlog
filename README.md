minetest CSM which records sent and received messages in the minetest log file.

= requirements =

tested with minetest 0.4.17 and 5.0.

only basic CSM need be enabled in 5.0, which is the default.

= installation =

make sure the mod is installed at ~/.minetest/clientmods/chatlog

make sure ~/.minetest/clientmods/mods.conf exists and contains:

load_mod_chatlog = true

logs will show up in ~/.minetest/debug.txt

if you use another CSM that handles the *printing* of chat messages e.g. friendly_chat, you may have to put an entry like

chatlog?

into that other mod's depends.txt file.
