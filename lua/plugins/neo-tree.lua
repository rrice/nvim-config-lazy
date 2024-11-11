return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
        },
        never_show = {
          ".git",
        },
        always_show = {
          ".gitignore",
          ".dockerignore",
          ".env.local",
        },
      },
      hijack_netrw_behavior = "open_default",
    },
    buffers = {
      follow_current_file = {
        enabled = true,
      },
    },
  },
}
