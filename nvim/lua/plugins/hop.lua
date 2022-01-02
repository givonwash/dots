return function()
    local keymap = require 'keymaps'
    local nmap = keymap.nmap
    local omap = keymap.mapper('o', nil, false)

    require('hop').setup {}

    nmap(
        'f',
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, inclusive_jump = true })<cr>'
    )
    nmap(
        'F',
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, inclusive_jump = true })<cr>'
    )
    nmap(
        't',
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })<cr>'
    )
    nmap(
        'T',
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })<cr>'
    )
    omap(
        'f',
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, inclusive_jump = true })<cr>'
    )
    omap(
        'F',
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, inclusive_jump = true })<cr>'
    )
    omap(
        't',
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })<cr>'
    )
    omap(
        'T',
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })<cr>'
    )
end
