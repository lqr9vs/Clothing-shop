fx_version 'cerulean'
game 'gta5'

author 'lqr9vs'
description 'Advanced Clothing Shop for FiveM'
version '1.1.0'

shared_script 'config.lua'

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'client/functions.lua',
    'client/main.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'server/main.lua'
}

dependencies {
    'es_extended',
    'skinchanger'
}