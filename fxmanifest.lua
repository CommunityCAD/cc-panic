fx_version 'cerulean'
games { 'gta5' }

author 'mclovinit101 and Mxrcy'
verison '1.1.0'
description 'A simple panic button script for FiveM. Thats connects with the CommunityCAD API.'


shared_script 'config.lua'

server_scripts {
    'server/server.lua',
}

client_scripts {
    'client/client.lua',
}
