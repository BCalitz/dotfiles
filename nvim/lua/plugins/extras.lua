-- ~/.config/nvim/lua/plugins/extras.lua   (or C:\Users\Brandon\AppData\Local\nvim\lua\plugins\extras.lua)
return {
  -- ──────────────────────────────────────────────────────────────
  -- 1. Treesitter – proper Angular template highlighting & injection
  -- ──────────────────────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Make sure these parsers are installed
      vim.list_extend(opts.ensure_installed or {}, {
        "angular",
        "html",
        "typescript",
        "tsx",
        "javascript",
      })

      -- Optional but nice: force angular parser on .component.html files
      vim.treesitter.language.register("angular", "angular-html")
    end,
  },

  -- ──────────────────────────────────────────────────────────────
  -- 2. ng.nvim – jump between template ↔ component TS (the famous <leader>lt)
  -- ──────────────────────────────────────────────────────────────
  {
    "joeveiga/ng.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>lt",
        function()
          require("ng").goto_template_for_component()
        end,
        desc = "Angular: Go to template for component under cursor",
      },
      {
        "<leader>lc",
        function()
          require("ng").goto_component_with_template_file()
        end,
        desc = "Angular: Go to component for current template",
      },
      {
        "<leader>aT",
        function()
          require("ng").get_template_tcb()
        end,
        desc = "Angular: Show template typecheck block",
      },
    },
    -- NO 'config' or 'setup' here — ng.nvim doesn't have one!
    -- It auto-loads when you require("ng") in the keymaps above.
  },

  -- ──────────────────────────────────────────────────────────────
  -- 3. (Totally optional but awesome) Better @Input/@Output detection in templates
  -- ──────────────────────────────────────────────────────────────
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact" },
    opts = {
      auto_start_watch_mode = true,
    },
  },
}
