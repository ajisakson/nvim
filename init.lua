require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use { 'catppuccin/nvim', as = 'catppuccin'}
    use { 'ellisonleao/gruvbox.nvim' }
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua'
	use 'nvim-lua/popup.nvim'	
	use 'windwp/nvim-autopairs'
	use 'prettier/vim-prettier'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		requires = { {'nvim-lua/plenary.nvim'} }

	}
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use { 'nvim-tree/nvim-tree.lua', 
		requires = 'nvim-tree/nvim-web-devicons',
		config = function()
			require('nvim-tree').setup {
				sort_by = 'case_sensitive',
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
			}
		end
	}
	use 'neovim/nvim-lspconfig'
	use 'anott03/nvim-lspinstall'
	use { 'nvim-lualine/lualine.nvim', 
		require = 'kyazdani42/nvim-web-devicons',
	}
	use 'github/copilot.vim'
	use({
		"kdheepak/lazygit.nvim",
	    requires = {
			"nvim-lua/plenary.nvim",
		},
	})

end)

vim.wo.relativenumber = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.fillchars = { eob = ' ' }
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- load custom configs from ./config_*.lua
require('config_telescope')
require('config_treesitter')
require('config_lualine')
require('config_lsp')
require('config_colorscheme')
require('config_keymap')

require('go').setup()


