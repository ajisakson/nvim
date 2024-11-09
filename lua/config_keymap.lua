-- custom keymap config

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

local nvimtree = require('nvim-tree.api')
vim.keymap.set('n', 'tt', nvimtree.tree.toggle, {})

vim.keymap.set('n', 'lg', "<cmd>LazyGit<cr>", {})

local lsp = vim.lsp.buf
vim.keymap.set('n', 'gd', lsp.definition, {})
vim.keymap.set('n', 'gr', lsp.references, {})
vim.keymap.set('n', 'gi', lsp.implementation, {})
vim.keymap.set('n', 'gh', lsp.hover, {})
vim.keymap.set('n', 'gs', lsp.signature_help, {})
vim.keymap.set('n', 'gD', lsp.declaration, {})
vim.keymap.set('n', 'gR', lsp.rename, {})
vim.keymap.set('n', 'gI', lsp.type_definition, {})
vim.keymap.set('n', 'gH', lsp.document_highlight, {})
vim.keymap.set('n', 'gS', lsp.document_symbol, {})
vim.keymap.set('n', 'gT', lsp.workspace_symbol, {})
vim.keymap.set('n', 'ga', lsp.code_action, {})


