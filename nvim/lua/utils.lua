local api = vim.api
local cmd = vim.cmd

local M = {}

M.create_mapper = function(mode, defaults, buf_local)
    local defaults = defaults or { noremap = true, silent = true }
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
    no_silent = { silent = false },
    remap = { noremap = false },
    expr = { expr = true },
}

M.str_to_term_code = function(str)
    return api.nvim_replace_termcodes(str, true, true, true)
end

M.echo = function(any) return function() return any end end

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

M.highlight = function(hls)
    for _, hl in pairs(hls) do cmd('highlight ' .. table.concat(hl, ' ')) end
end

M.LUA_PATH = (function()
    local path = vim.split(package.path, ';')
    table.insert(path, 'lua/?.lua')
    table.insert(path, 'lua/?/init.lua')
    return path
end)()

M.LUA_LIBRARIES = (function()
    local libraries = {}

    local function add_library(path)
        for _, p in pairs(vim.fn.expand(path, false, true)) do
            local real_path = vim.loop.fs_realpath(p)
            libraries[real_path] = true
        end
    end

    add_library('$VIMRUNTIME')
    add_library('~/.config/nvim')
    add_library("~/.local/share/nvim/site/pack/packer/opt/*")
    add_library("~/.local/share/nvim/site/pack/packer/start/*")
    return libraries
end)()

return M
