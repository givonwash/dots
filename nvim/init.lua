--[[=============================== globals =================================]]
local g = vim.g

-- set leader keys
g.mapleader = ' '
g.maplocalleader = ','

-- pin python host to system python
g.python3_host_prog = '/usr/bin/python3'

--[[=============================== modules =================================]]
require 'plugins'
require 'keymaps'
require 'options'
require 'autocmds'
