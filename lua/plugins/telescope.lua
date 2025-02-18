return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
      { "folke/which-key.nvim" },
      { "debugloop/telescope-undo.nvim" },
      { "nvim-lua/plenary.nvim" },
      {
        "tomasky/bookmarks.nvim",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")

      wk.register({
        ["<leader>t"] = {
          name = "telescope",
          a = {
            function()
              require("telescope.builtin").find_files({
                no_ignore = true,
                hidden = true,
                prompt_title = "All Files",
              })
            end,
            "All files",
          },
          f = { "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>", "find files" },
          b = { "<cmd>Telescope buffers<cr>", "buffers" },
          h = { "<cmd>Telescope help_tags<cr>", "help tags" },
          m = { "<cmd>Telescope marks<cr>", "marks" },
          r = { "<cmd>Telescope registers<cr>", "registers" },
          t = { "<cmd>Telescope treesitter<cr>", "treesitter" },
          w = { "<cmd>Telescope grep_string<cr>", "grep string" },
          o = { "<cmd>Telescope oldfiles<cr>", "oldfiles" },
          g = {
            name = "git",
            b = { "<cmd>Telescope git_branches<cr>", "branches" },
            c = { "<cmd>Telescope git_commits<cr>", "commits" },
            s = { "<cmd>Telescope git_status<cr>", "status" },
            h = { "<cmd>Telescope git_stash<cr>", "stash" },
            p = { "<cmd>Telescope git_files<cr>", "git files" },
          },
        },

        ["<leader>fw"] = {
          "<cmd>Telescope grep_string<cr>",
          "grep string",
        },
        ["<c-f>"] = {
          "<cmd>Telescope live_grep<cr>",
          "live grep",
        },
        ["<c-p>"] = {
          "<cmd>Telescope fd find_command=rg,--ignore,--hidden,--files<cr>",
          "find file",
        },
      })

      local actions = require("telescope.actions")
      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          file_browser = {
            -- theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
          undo = {
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },

        defaults = {
          git_worktrees = vim.g.git_worktrees,
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<esc>"] = actions.close,
            },
            n = { q = actions.close },
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("undo")
      require("telescope").load_extension("bookmarks")
    end,
  },
}
