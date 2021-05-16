local api = vim.api
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local M = {}

M.create_mapper = function(mode, defaults, buf_local)
    local defaults = defaults or {noremap = true, silent = true}
    if not buf_local then
        return function(lhs, rhs, opts)
            local opts = opts or {}
            local options = vim.tbl_extend('force', defaults, opts)
            api.nvim_set_keymap(mode, lhs, rhs, options)
        end
    else
        return function(lhs, rhs, opts)
            local opts = opts or {}
            local options = vim.tbl_extend('force', defaults, opts)
            api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
        end
    end
end

M.map_opts = {
    no_silent = {silent = false},
    remap = {noremap = false},
    expr = {expr = true},
}

M.create_setter = function(scope)
    local opt_table = scopes[scope]
    if scope == 'o' then
        return function(opt, val) opt_table[opt] = val end
    else
        return function(opt, val)
            opt_table[opt] = val
            vim.o[opt] = val
        end
    end
end

M.str_to_term_code = function(str)
    return api.nvim_replace_termcodes(str, true, true, true)
end

M.echo = function(any) return function() return any end end

--[[
colors pulled from:
    - https://github.com/Th3Whit3Wolf/onebuddy/blob/main/lua/onebuddy.lua

see the colors here:
    - https://coolors.co/abb2bf-828997-5c6370-4b5263-3e4552-636d83-282c34
    - https://coolors.co/55d1b4-61afef-c678dd-98c379-e06c75-be5046-d19a66-e5c07b
]]
M.colors = {
    light_gray = '#abb2bf',
    lighter_gray = '#828997',
    gray = '#5c6370',
    darker_gray = '#4b5263',
    dark_gray = '#3e4552',
    turquoise = '#55D1B4',
    blue = '#61afef',
    magenta = '#c678dd',
    green = '#98c379',
    pink = '#e06c75',
    red = '#be5046',
    orange = '#d19a66',
    yellow = '#e5c07b',
    bg = '#282c34',
    gutter = '#636d83',
}

return M
