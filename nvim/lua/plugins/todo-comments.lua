return {
  "folke/todo-comments.nvim",
  keys = {
    { "]t", false },
    { "[t", false },
    {
      "]T",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next Todo Comment",
    },
    {
      "[T",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Prev Todo Comment",
    },
  },
}
