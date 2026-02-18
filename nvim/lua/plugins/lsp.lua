-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  -- Tiny improvements on top of the official Angular extra
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          -- Turn off semantic tokens (treesitter is better + faster)
          on_attach = function(client, _)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
        vtsls = {
          -- vtsls is what the Angular extra uses under the hood
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true, -- always use project's TypeScript version
            },
          },
        },
      },
    },
  },
}
