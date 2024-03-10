require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use { 'catppuccin/nvim', as = 'catppuccin'}
    use { 'ellisonleao/gruvbox.nvim' }
    use 'HiPhish/nvim-ts-rainbow2'
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua'
	use 'nvim-lua/popup.nvim'	
	use 'windwp/nvim-autopairs'
    use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		requires = { {'nvim-lua/plenary.nvim'} }

	}
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
				filters = {
					dotfiles = true,
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
end)

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', '<C-s>', vim.cmd.write, {})
vim.wo.relativenumber = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4


require'nvim-treesitter.configs'.setup {
	ensure_installed = { "javascript", "typescript", "c", "lua", "zig", "go", "php" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
    rainbow = {
        enable = true,
        query = 'rainbow-parens',
        max_file_lines = 2000,
    },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
})

require("gruvbox").setup({
    transparent_mode = true,
})

require('go').setup()

vim.o.background = 'dark'
vim.cmd.colorscheme 'catppuccin'
local lspconfig = require'lspconfig'

local function custom_on_attach(client)
	print('Attaching to ' .. client.name)
end

local default_config = {
	on_attach = custom_on_attach,
}

lspconfig.tsserver.setup(default_config)
lspconfig.gopls.setup(default_config)
lspconfig.zls.setup(default_config)
lspconfig.intelephense.setup(default_config)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
