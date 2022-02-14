local wezterm = require 'wezterm'
local theme = {
    fg = '#abb2bf',
    bg = '#282c34',
    sel = {
        fg = '#21252b',
        bg = '#ebd09c',
    },
    thumb = '#5c6370',
    split = '#393f4a',
    term = {
        normal = {
            '#20232a',
            '#e86671',
            '#98c379',
            '#e5c07b',
            '#61afef',
            '#c678dd',
            '#56b6c2',
            '#798294',
        },
        bright = {
            '#798294',
            '#e86671',
            '#98c379',
            '#e0af68',
            '#61afef',
            '#c678dd',
            '#56b6c2',
            '#abb2bf',
        },
        indexed = {
            [16] = '#d19a66',
            [17] = '#f65866',
        },
    },
}

return {
    -- theming
    bold_brightens_ansi_colors = false,
    default_cursor_style = 'SteadyBar',
    font = wezterm.font_with_fallback {
        { family = 'Iosevka SS12', stretch = 'Expanded', weight = 'Regular' },
        { family = 'Symbols Nerd Font' },
    },
    font_size = 14,
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    colors = {
        foreground = theme.fg,
        background = theme.bg,
        cursor_fg = theme.bg,
        cursor_bg = theme.fg,
        cursor_border = theme.fg,
        selection_fg = theme.sel.fg,
        selection_bg = theme.sel.bg,
        scrollbar_thumb = theme.thumb,
        split = theme.split,
        ansi = theme.term.normal,
        brights = theme.term.bright,
        indexed = theme.term.indexed,
        tab_bar = {
            background = theme.sel.fg,
            active_tab = {
                fg_color = theme.term.normal[1],
                bg_color = theme.term.normal[3],
            },
            inactive_tab = {
                fg_color = theme.term.normal[3],
                bg_color = theme.term.normal[1],
            },
            inactive_tab_hover = {
                fg_color = theme.term.normal[4],
                bg_color = theme.term.normal[1],
            },
            new_tab = {
                fg_color = theme.term.normal[2],
                bg_color = theme.term.normal[1],
                intensity = 'Bold',
            },
            new_tab_hover = {
                fg_color = theme.term.normal[1],
                bg_color = theme.term.normal[2],
                intensity = 'Bold',
            },
        },
    },

    -- keybindings
    disable_default_key_bindings = true,
    leader = { key = ' ', mods = 'CTRL' },
    keys = {
        -- system clipboard
        { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action { CopyTo = 'Clipboard' } },
        { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action { PasteFrom = 'Clipboard' } },
        { key = 'v', mods = 'LEADER', action = 'ActivateCopyMode' },
        { key = 'q', mods = 'LEADER', action = 'QuickSelect' },

        -- font re-sizing
        { key = '-', mods = 'CTRL', action = 'DecreaseFontSize' },
        { key = '=', mods = 'CTRL', action = 'IncreaseFontSize' },
        { key = '0', mods = 'CTRL', action = 'ResetFontSize' },

        -- tab management
        {
            key = 'n',
            mods = 'LEADER',
            action = wezterm.action { SpawnTab = 'CurrentPaneDomain' },
        },
        {
            key = 'c',
            mods = 'LEADER|SHIFT',
            action = wezterm.action { CloseCurrentTab = { confirm = true } },
        },
        { key = 'j', mods = 'LEADER|CTRL', action = wezterm.action { MoveTabRelative = -1 } },
        { key = 'k', mods = 'LEADER|CTRL', action = wezterm.action { MoveTabRelative = 1 } },

        -- pane management
        {
            key = 'c',
            mods = 'LEADER',
            action = wezterm.action { CloseCurrentPane = { confirm = true } },
        },
        {
            key = "'",
            mods = 'LEADER',
            action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } },
        },
        {
            key = ';',
            mods = 'LEADER',
            action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } },
        },
        {
            key = 'h',
            mods = 'LEADER',
            action = wezterm.action { ActivatePaneDirection = 'Left' },
        },
        {
            key = 'j',
            mods = 'LEADER',
            action = wezterm.action { ActivatePaneDirection = 'Down' },
        },
        {
            key = 'k',
            mods = 'LEADER',
            action = wezterm.action { ActivatePaneDirection = 'Up' },
        },
        {
            key = 'l',
            mods = 'LEADER',
            action = wezterm.action { ActivatePaneDirection = 'Right' },
        },

        -- tab navigation (absolute forward)
        { key = '1', mods = 'LEADER', action = wezterm.action { ActivateTab = 0 } },
        { key = '2', mods = 'LEADER', action = wezterm.action { ActivateTab = 1 } },
        { key = '3', mods = 'LEADER', action = wezterm.action { ActivateTab = 2 } },
        { key = '4', mods = 'LEADER', action = wezterm.action { ActivateTab = 3 } },
        { key = '5', mods = 'LEADER', action = wezterm.action { ActivateTab = 4 } },
        { key = '6', mods = 'LEADER', action = wezterm.action { ActivateTab = 5 } },
        { key = '7', mods = 'LEADER', action = wezterm.action { ActivateTab = 6 } },
        { key = '8', mods = 'LEADER', action = wezterm.action { ActivateTab = 7 } },
        { key = '9', mods = 'LEADER', action = wezterm.action { ActivateTab = 8 } },
        { key = '0', mods = 'LEADER', action = wezterm.action { ActivateTab = 9 } },

        -- tab navigation (absolute backwards)
        { key = '1', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -1 } },
        { key = '2', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -2 } },
        { key = '3', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -3 } },
        { key = '4', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -4 } },
        { key = '5', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -5 } },
        { key = '6', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -6 } },
        { key = '7', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -7 } },
        { key = '8', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -8 } },
        { key = '9', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -9 } },
        { key = '0', mods = 'LEADER|SHIFT', action = wezterm.action { ActivateTab = -10 } },

        -- tab navigation (relative)
        {
            key = 'j',
            mods = 'LEADER|SHIFT',
            action = wezterm.action { ActivateTabRelative = -1 },
        },
        {
            key = 'k',
            mods = 'LEADER|SHIFT',
            action = wezterm.action { ActivateTabRelative = 1 },
        },

        -- scrollback navigation
        {
            key = '/',
            mods = 'LEADER',
            action = wezterm.action { Search = { Regex = '' } },
        },
        { key = 'f', mods = 'LEADER', action = wezterm.action { ScrollByPage = -1 } },
        { key = 'b', mods = 'LEADER', action = wezterm.action { ScrollByPage = 1 } },

        -- scrollback management
        {
            key = 'l',
            mods = 'LEADER|SHIFT',
            action = wezterm.action { ClearScrollback = 'ScrollbackAndViewport' },
        },

        -- misc
        { key = 'f', mods = 'CTRL|CMD', action = 'ToggleFullScreen' },
    },
    window_frame = {
        font = wezterm.font('Iosevka Etoile', { weight = 'Bold' }),
        font_size = 13.0,
        active_titlebar_bg = theme.sel.fg,
        inactive_titlebar_bg = theme.sel.fg,
    },
}
