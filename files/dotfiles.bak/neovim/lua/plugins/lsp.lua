return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "lukas-reineke/lsp-format.nvim",
    lazy = true,
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    opts = {
      floating_window = true,
      hint_prefix = " ",
      handler_opts = {
        border = "rounded",
      },
    },
  },
  {
    -- Keep lspconfig installed for filetype detection / cmd defaults,
    -- but we use vim.lsp.config() for actual server setup.
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local lsp_format = require("lsp-format")

      -- Rounded borders
      vim.diagnostic.config({ float = { border = "rounded" } })

      -- on_attach via LspAttach autocmd
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            lsp_format.on_attach(client, args.buf)
          end
        end,
      })

      -- Nix environment for nixd
      local nix_env = require("nix-env")

      -- Server configs using vim.lsp.config
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            telemetry = { enabled = false },
          },
        },
      })

      vim.lsp.config("nixd", {
        capabilities = capabilities,
        settings = {
          nixpkgs = { expr = "import <nixpkgs> {}" },
          formatting = { command = { "nixfmt" } },
          options = {
            nixos = {
              expr = string.format(
                'let configs = (builtins.getFlake "%s").nixosConfigurations; in (builtins.head (builtins.attrValues configs)).options',
                nix_env.flake_root
              ),
            },
            home_manager = {
              expr = string.format(
                '(builtins.getFlake "%s").nixosConfigurations.%s.options.home-manager.users.value.%s',
                nix_env.flake_root,
                nix_env.hostname,
                nix_env.username
              ),
            },
          },
        },
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
        filetypes = { "go" },
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
            },
            hints = {
              parameterNames = true,
              assignVariableTypes = true,
              constantValues = true,
            },
          },
        },
      })

      vim.lsp.config("jsonnet_ls", {
        capabilities = capabilities,
        filetypes = { "jsonnet", "libsonnet" },
      })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        filetypes = { "yaml", "yml" },
      })

      vim.lsp.config("jsonls", {
        capabilities = capabilities,
        filetypes = { "json" },
      })

      vim.lsp.config("typos_lsp", {
        capabilities = capabilities,
        init_options = {
          diagnosticSeverity = "Warning",
        },
      })

      -- Enable all configured servers
      vim.lsp.enable({ "lua_ls", "nixd", "gopls", "jsonnet_ls", "yamlls", "jsonls", "typos_lsp" })

      -- LSP keymaps
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
      vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { desc = "Type Definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      vim.keymap.set("n", "<leader>cw", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbol" })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
      vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
    end,
  },
}
