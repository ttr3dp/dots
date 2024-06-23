require("neodev").setup({})

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- ruby
lspconfig.solargraph.setup({
  capabilities = capabilities,
  settings = {
    solargraph = {
      formatting = true,
      diagnostics = true,
      autoformat = true
    }
  }
})

-- C
lspconfig.clangd.setup({
  capabilities = capabilities,
})

-- PHP
lspconfig.intelephense.setup({
  capabilities = capabilities,
})

-- lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    }
  },
})

-- jsonls
lspconfig.jsonls.setup {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

-- yamlls
lspconfig.yamlls.setup {
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  pattern = '*',
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>sh', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>cn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
  end
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local bufnr = args.buf
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
--
--     vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
--     vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
--     vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
--     vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
--     vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
--
--     vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
--     vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
--     vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
--   end,
-- })
