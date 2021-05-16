local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

local galaxy = require 'galaxyline'
local condition = require 'galaxyline.condition'
local fileinfo = require 'galaxyline.provider_fileinfo'

local section = galaxy.section
local not_empty = condition.buffer_not_empty
local is_wide = condition.hide_in_width
local is_git = condition.check_git_workspace

--[[=============================== Helpers =================================]]

local utils = require 'utils'
local colors = utils.colors
local echo = utils.echo

local left_rounded = echo('')
local right_rounded = echo('')

local function git_and_wide() return is_git() and is_wide() end

local function filename() return fn.expand('%:t') end

local function line_col()
    local ln = fn.line('.')
    local col = fn.col('.')
    return string.format('%4d:%-3d', ln, col)
end

local function line_percent()
    local cur_ln = fn.line('.')
    local max_ln = fn.line('$')
    local percent = math.floor(100 * (cur_ln / max_ln))
    return string.format('%3d%%', percent)
end

local function modified()
    if api.nvim_buf_get_option(0, 'modified') then
        return '[+]'
    else
        return '[=]'
    end
end

--[[============================= Left Section ==============================]]

section.left[1] = {
    FileNameLeftRounded = {
        provider = left_rounded,
        highlight = {colors.light_gray, colors.bg},
    },
}

section.left[2] = {
    FileIcon = {
        provider = 'FileIcon',
        condition = not_empty,
        highlight = {fileinfo.get_file_icon_color, colors.light_gray},
    },
}

section.left[3] = {
    FileName = {
        provider = filename,
        condition = not_empty,
        highlight = {colors.bg, colors.light_gray, 'bold'},
        separator = ' ',
        separator_highlight = {colors.light_gray, colors.light_gray},
    },
}

section.left[4] = {
    FileModified = {
        provider = modified,
        highlight = {colors.bg, colors.light_gray, 'bold'},
    },
}

section.left[5] = {
    FileNameRightRounded = {
        provider = right_rounded,
        highlight = {colors.light_gray, colors.bg},
        separator = ' ',
    },
}

local modes = {
    c = {str = ':: Command ::', color = colors.yellow},
    n = {str = ':: Normal ::', color = colors.blue},
    i = {str = ':: Insert ::', color = colors.green},
    v = {str = ':: Visual ::', color = colors.magenta},
    V = {str = ':: Visual-Line ::', color = colors.pink},
    R = {str = ':: Replace ::', color = colors.red},
    s = {str = ':: Select ::', color = colors.orange},
    S = {str = ':: Select-Line ::', color = colors.dark_gray},
    [''] = {str = ':: Visual-Block ::', color = colors.gutter},
    [''] = {str = ':: Select-Block ::', color = colors.gutter},
    ic = {str = ':: Insert ::', color = colors.green},
    Rv = {str = ':: Virtual Replace ::', color = colors.red},
    cv = {str = ':: Vim Ex ::', color = colors.yellow},
    ce = {str = ':: Normal Ex ::', color = colors.yellow},
    r = {str = ':: Hit Enter ::', color = colors.gutter},
    rm = {str = ':: More ::', color = colors.gutter},
    ['r?'] = {str = ':: Confirm ::', color = colors.yellow},
    ['!'] = {str = ':: Shell ::', color = colors.red},
    t = {str = ':: Terminal ::', color = colors.blue},
}

section.left[6] = {
    ViModeLeftRounded = {
        provider = function()
            local fg = modes[api.nvim_get_mode()['mode']]['color']
            fg = fg or colors.blue
            cmd('hi GalaxyViModeLeftRounded guifg=' .. fg)
            return ''
        end,
        highlight = function()
            local fg = modes[api.nvim_get_mode()['mode']]['color']
            fg = fg or colors.blue
            return {fg, colors.bg}
        end,
    },
}

section.left[7] = {
    ViMode = {
        provider = function()
            local mode = modes[api.nvim_get_mode()['mode']]
            local bg = mode['color'] or colors.blue
            cmd('hi GalaxyViMode guibg=' .. bg)
            local mode_str = mode['str'] or ':: Unknown ::'
            return mode_str
        end,
        highlight = {
            colors.bg, function()
                local bg = modes[api.nvim_get_mode()['mode']]['color']
                bg = bg or colors.blue
                return bg
            end, 'bold',
        },
    },
}

section.left[8] = {
    ViModeRightRounded = {
        provider = function()
            local fg = modes[api.nvim_get_mode()['mode']]['color']
            fg = fg or colors.blue
            cmd('hi GalaxyViModeRightRounded guifg=' .. fg)
            return ''
        end,
        highlight = {
            function()
                local fg = modes[api.nvim_get_mode()['mode']]['color']
                fg = fg or colors.blue
                return fg
            end, colors.bg,
        },
        separator = ' ',
    },
}

section.left[9] = {
    GitInfoLeftRounded = {
        provider = left_rounded,
        condition = git_and_wide,
        highlight = {colors.gutter, colors.bg},
    },
}

section.left[10] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = git_and_wide,
        icon = ' ',
        highlight = {colors.magenta, colors.gutter, 'bold'},
        separator = ' ',
        separator_highlight = {colors.gutter, colors.gutter},
    },
}

section.left[11] = {
    GitDiffAdd = {
        provider = 'DiffAdd',
        condition = git_and_wide,
        icon = '+',
        highlight = {colors.green, colors.gutter, 'bold'},
    },
}

section.left[12] = {
    GitDiffModified = {
        provider = 'DiffModified',
        condition = git_and_wide,
        icon = '~',
        highlight = {colors.orange, colors.gutter, 'bold'},
    },
}

section.left[13] = {
    GitDiffRemove = {
        provider = 'DiffRemove',
        condition = git_and_wide,
        icon = '-',
        highlight = {colors.red, colors.gutter, 'bold'},
    },
}

section.left[14] = {
    GitInfoRightRounded = {
        provider = right_rounded,
        condition = git_and_wide,
        highlight = {colors.gutter, colors.bg},
    },
}

--[[============================ Right Section ==============================]]

section.right[1] = {
    LspLeftRounded = {
        provider = left_rounded,
        condition = is_wide,
        highlight = {colors.orange, colors.bg},
    },
}

section.right[2] = {
    Lsp = {
        provider = 'GetLspClient',
        condition = is_wide,
        highlight = {colors.bg, colors.orange, 'bold'},
    },
}

section.right[3] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        condition = is_wide,
        icon = ' ',
        highlight = {colors.bg, colors.orange, 'bold'},
    },
}

section.right[4] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        condition = is_wide,
        icon = ' ',
        highlight = {colors.bg, colors.orange, 'bold'},
        separator = ' ',
        separator_highlight = {colors.orange, colors.orange},
    },
}

section.right[5] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        condition = is_wide,
        icon = ' ',
        highlight = {colors.bg, colors.orange, 'bold'},
    },
}

section.right[6] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        condition = is_wide,
        icon = ' ',
        highlight = {colors.bg, colors.orange, 'bold'},
    },
}

section.right[7] = {
    LspRightRounded = {
        provider = right_rounded,
        condition = is_wide,
        highlight = {colors.orange, colors.bg},
    },
}

section.right[8] = {
    FileMetaLeftRounded = {
        provider = left_rounded,
        condition = is_wide,
        highlight = {colors.pink, colors.bg},
        separator = ' ',
    },
}

section.right[9] = {
    FileMeta = {
        provider = function()
            local ft = api.nvim_buf_get_option(0, 'filetype')
            local fmt = api.nvim_buf_get_option(0, 'fileformat')
            local enc = api.nvim_buf_get_option(0, 'fileencoding')
            return enc .. ' :: ' .. fmt .. ' :: ' .. ft
        end,
        condition = is_wide,
        highlight = {colors.bg, colors.pink, 'bold'},
    },
}

section.right[10] = {
    FileMetaRightRounded = {
        provider = right_rounded,
        condition = is_wide,
        highlight = {colors.pink, colors.bg},
    },
}

section.right[11] = {
    PositionLeftRounded = {
        provider = left_rounded,
        highlight = {colors.light_gray, colors.bg},
        separator = ' ',
    },
}

section.right[12] = {
    LineColumn = {
        provider = line_col,
        highlight = {colors.bg, colors.light_gray, 'bold'},
    },
}

section.right[13] = {
    LinePercent = {
        provider = line_percent,
        highlight = {colors.bg, colors.green, 'bold'},
        separator = ' ',
        separator_highlight = {colors.green, colors.green},
    },
}

section.right[14] = {
    PositionRightRounded = {
        provider = right_rounded,
        highlight = {colors.green, colors.bg},
    },
}

--[[================= Inactive Windows and Special Buffers ==================]]

galaxy.short_line_list = {'dbui', 'packer'}

section.short_line_left[1] = {
    FileNameShort = {
        provider = filename,
        highlight = {colors.light_gray, colors.bg},
        separator = ' ',
    },
}

section.short_line_left[2] = {
    FileModifiedShort = {
        provider = modified,
        highlight = {colors.light_gray, colors.bg},
    },
}

section.short_line_right[1] = {
    LineColumnShort = {
        provider = line_percent,
        highlight = {colors.light_gray, colors.bg},
    },
}
