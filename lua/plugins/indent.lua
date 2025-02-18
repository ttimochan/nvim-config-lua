return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    init = function()
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })

      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          style = {
            { fg = "#91bef0" },
          },
          exclude_filetype = require("util.ft").exclude_ft_table,
        },
        indent = {
          chars = { "│" },
          use_treesitter = false,
          style = {
            "#4F709C",
          },

          exclude_filetype = require("util.ft").exclude_ft_table,
        },
        blank = {
          enable = false,
        },
        line_num = {
          exclude_filetype = require("util.ft").exclude_ft_table,
          use_treesitter = true,
          style = "#91bef0",
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "echasnovski/mini.indentscope",
    enabled = false,
  },
}
