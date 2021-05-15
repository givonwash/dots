local fn = vim.fn

local path = vim.split(package.path, ';')

table.insert(path, 'lua/?.lua')
table.insert(path, 'lua/?/init.lua')

local cmd = {
    '/usr/bin/lua-language-server',
    '-E',
    '/usr/share/lua-language-server/main.lua'
}

local lib = {}

local function add_lib(lib_path)
    for _, path in pairs(fn.expand(lib_path, false, true)) do
        local real_path = vim.loop.fs_realpath(path)
        lib[real_path] = true
    end
end

add_lib('$VIMRUNTIME')
add_lib('~/.config/nvim')
add_lib("~/.local/share/nvim/site/pack/packer/opt/*")
add_lib("~/.local/share/nvim/site/pack/packer/start/*")

return {
    on_new_config = function(config, root)
        local libs = vim.tbl_deep_extend("force", {}, lib)
        libs[root] = nil
        config.settings.Lua.workspace.library = libs
        return config
    end,
    cmd = cmd,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = lib,
                maxPreload = 2000,
                preloadFileSize = 50000
            },
            telemetry = {
                enable = false,
            }
        }
    }
}
