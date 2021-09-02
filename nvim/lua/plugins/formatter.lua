return function()
    local buf_name = vim.api.nvim_buf_get_name

    local prettier = {
        function()
            return {
                exe = 'prettier',
                args = { '--stdin-filepath', buf_name(0) },
                stdin = true,
            }
        end,
    }

    local rustfmt = {
        function()
            return { exe = 'rustfmt', args = { '--emit=stdout' }, stdin = true }
        end,
    }

    local luafmt = {
        function()
            return { exe = 'lua-format', args = { buf_name(0) }, stdin = true }
        end,
    }

    local pyfmt = {
        function()
            return { exe = 'isort', args = { buf_name(0) }, stdin = false }
        end, function()
            return { exe = 'black', args = { buf_name(0) }, stdin = false }
        end,
    }

    local filetypes = {
        css = prettier,
        html = prettier,
        javascript = prettier,
        javascriptreact = prettier,
        json = prettier,
        lua = luafmt,
        markdown = prettier,
        python = pyfmt,
        typescript = prettier,
        typescriptreact = prettier,
        yaml = prettier,
        rust = rustfmt,
    }

    require('formatter').setup { logging = false, filetype = filetypes }

    local autocmds = {}

    local i = 1
    for ft, _ in pairs(filetypes) do
        autocmds[i] = {
            'FileType', ft, 'autocmd', 'BufWritePost', '<buffer>',
            'FormatWrite',
        }
        i = i + 1
    end

    local au = require 'autocmds'
    au.augroup(autocmds, 'formatter')
end
