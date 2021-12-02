local g = vim.g

--[[=============================== globals =================================]]
_G.__config__ = {}

_G.__config__.puts = function(any) print(vim.inspect(any)) end

-- set leader keys
g.mapleader = ' '
g.maplocalleader = ','

-- pin python host to system python
-- g.python3_host_prog = '{{PYTHON3_NVIM_HOST}} '

--[[=============================== modules =================================]]
require 'plugins'
require 'keymaps'
require 'options'
require 'autocmds'
