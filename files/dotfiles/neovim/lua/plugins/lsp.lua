return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp', lazy = true },
      { 'lukas-reineke/lsp-format.nvim', lazy = true, opts = {}, },
    },

    config = function()
      local cmp_lsp = require('cmp_nvim_lsp')

      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local lsp_format = require('lsp-format')

      -- Rounded borders
      vim.diagnostic.config({ float = { border = "rounded" } })
      local orig_open_floating_preview = vim.lsp.util.open_floating_preview
      vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig_open_floating_preview(contents, syntax, opts, ...)
      end

      -- on_attach via LspAttach autocmd
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            lsp_format.on_attach(client, args.buf)
          end
        end,
      })

      -- Global defaults for all servers
      vim.lsp.config('*', { capabilities = capabilities })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            format = { enable = true },
            completion = { callSnippet = 'Replace' },
            telemetry = { enabled = false },
          }
        }
      })

      vim.lsp.config('gopls', {
        filetypes = { 'go' },
        settings = {
          gopls = {
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            analyses = {
              unusedparams = true,
              unusedvariable = true,
              shadow = true,
              nilness = true,
              unusedwrite = true,
              useany = true,
              ST1000 = false,
            },
            hints = {
              parameterNames = true,
              assignVariableTypes = true,
              constantValues = true,
            },
            codelenses = {
              gc_details = false,
            },
          },
        },
      })

      vim.lsp.config('jsonls', { filetypes = { 'json' } })
      vim.lsp.config('jsonnet_ls', { filetypes = { 'jsonnet', 'libsonnet' } })
      vim.lsp.config('yamlls', { filetypes = { 'yaml', 'yml' } })

      vim.lsp.enable({ 'lua_ls', 'gopls', 'jsonls', 'jsonnet_ls', 'yamlls' })

      -- LSP keymaps
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Goto References' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
      vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
      vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { desc = 'Type Definition' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
      vim.keymap.set('n', '<leader>cw', vim.lsp.buf.workspace_symbol, { desc = 'Workspace Symbol' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
      vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
      vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
    end,
  },
}
