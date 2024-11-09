-- treesitter config

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "javascript", "typescript", "c", "lua", "go", "php", "css", "scss","python" },
	sync_install = true,
	auto_install = true,
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 1000,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}


