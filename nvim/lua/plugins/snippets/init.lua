require('snippets').use_suggested_mappings()

require('snippets').snippets = {
    markdown = { ['inl'] = [[\\\( $1 \\\)$0]], ['blo'] = "\\\\\\[\n$0\\\\\\]" },
}
