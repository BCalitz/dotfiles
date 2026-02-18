-- ~/.config/nvim/lua/config/keymaps.lua
local cmp = require("cmp")

-- Make Ctrl-n / Ctrl-p always use nvim-cmp (the pretty one)
vim.keymap.set("i", "<C-n>", function()
  if cmp.visible() then
    cmp.select_next_item()
  else
    cmp.complete()
  end
end, { desc = "Next item or open completion" })

vim.keymap.set("i", "<C-p>", function()
  if cmp.visible() then
    cmp.select_prev_item()
  else
    cmp.complete()
  end
end, { desc = "Previous item or open completion" })

-- Bonus: Ctrl+Space always forces the good menu
vim.keymap.set("i", "<C-Space>", cmp.complete, { desc = "Force completion menu" })

-- Separate quickfix and trouble navigation (LazyVim combines them by default)
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Prev Quickfix Item" })
vim.keymap.set("n", "]t", function()
  require("trouble").next({ mode = "diagnostics", jump = true })
end, { desc = "Next Trouble Item" })
vim.keymap.set("n", "[t", function()
  require("trouble").prev({ mode = "diagnostics", jump = true })
end, { desc = "Prev Trouble Item" })

