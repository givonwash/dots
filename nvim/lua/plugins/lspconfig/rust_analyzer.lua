local rust_analyzer = require('lspconfig').rust_analyzer

rust_analyzer.setup { settings = { checkOnSave = { command = 'clippy' } } }
