local fn = vim.fn

local npairs = require 'nvim-autopairs'
local str_to_term_code = require('utils').str_to_term_code

_G.my_globals.on_enter = function()
    if fn.pumvisible() ~= 0 then
        if fn.complete_info()["selected"] ~= -1 then
            return fn["compe#confirm"](str_to_term_code "<cr>")
        else
            return str_to_term_code "<cr>"
        end
    else
        return npairs.autopairs_cr()
    end
end

local imap = require('keymaps').imap
local expr = require('utils').map_opts.expr

imap('<cr>', 'v:lua.my_globals.on_enter()', expr)
