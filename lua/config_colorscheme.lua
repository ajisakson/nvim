-- custom colorscheme config
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
})

require("gruvbox").setup({
    transparent_mode = true,
})

-- vim.o.background = 'dark'
vim.cmd.colorscheme 'gruvbox'

