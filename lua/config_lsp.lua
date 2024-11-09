-- custom lsp config
local lspconfig = require'lspconfig'

local function custom_on_attach(client)
	print('Attaching to ' .. client.name)
end



-- Specify how the border looks like
local border = {
    { '┌', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '┐', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '┘', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '└', 'FloatBorder' },
    { '│', 'FloatBorder' },
}

-- Add the border on hover and on signature help popup window
local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- Add border to the diagnostic popup window
vim.diagnostic.config({
    virtual_text = {
        prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
    },
    float = { border = border },
})

local default_config = {
	on_attach = custom_on_attach,
	handlers = handlers,
}

lspconfig.ts_ls.setup(default_config)
lspconfig.gopls.setup(default_config)
lspconfig.intelephense.setup(default_config)
lspconfig.lemminx.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.intelephense.setup(default_config)
lspconfig.pyright.setup(default_config)

-- auto-format scss on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.scss,*.css,*.js,*.json,*.html,*.ts,*.tsx,*.jsx",
  callback = function()
	-- call :Prettier
	vim.cmd("Prettier")
	end
})

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

--vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
