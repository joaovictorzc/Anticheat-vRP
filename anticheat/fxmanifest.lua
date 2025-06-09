fx_version 'cerulean'
game 'gta5'
author 'João Victor Zanolli Crespo'
description 'Projeto de Anticheat desenvolvido para servidores de Roleplay na framework vRP pelo aluno João Victor Zanolli Crespo do curso de Ciência da Computação da PUC Minas'
version '1.0.0'

server_scripts {
  '@vrp/lib/utils.lua',
  'config/shared.lua',
  'config/server.lua',
  'server/modules/*.lua',
  'server/main.lua'
}

client_scripts {
  '@vrp/lib/utils.lua',
  'config/shared.lua',
  'client/main.lua',
  'client/controller/*.lua',
}