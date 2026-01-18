return {
  -- snacks.nvim - dashboard
  {
    "snacks.nvim",
    keys = {
      { "<leader>E", false }, -- Disable snacks explorer
      { "<leader>e", false }, -- Disable snacks explorer
      { "<leader>uz", false }, -- Disable zen mode
      { "<leader>uZ", false }, -- Disable zen zoom
      { "<leader>z", false }, -- Disable zen
      { "<leader>Z", false }, -- Disable zoom
      { "<leader>uf", false }, -- Disable fullscreen if exists
    },
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { section = "recent_files", title = "Recent Files", padding = 1 },
          { section = "projects", title = "Projects", padding = 1 },
          { section = "keys", padding = 1 },
          { section = "startup", icon = "" },
        },
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          -- stylua: ignore
          header = [[
                __
___     ___    ___   __  __ /\_\    ___ ___
 / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
 /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
 \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
  \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
]],
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = "", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      notifier = {
        top_down = false,
      },
      explorer = { enabled = false },
      zen = { enabled = false },
    },
  },
  -- lualine - status lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            Snacks.profiler.status(),
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = Snacks.util.color("Statement") } end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "File Explorer",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "File Explorer (cwd)",
      },
      { "<leader>e", "<leader>fE", desc = "File Explorer (cwd)", remap = true },
      { "<leader>E", "<leader>fe", desc = "File Explorer", remap = true },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      add_blank_line_at_top = false,
      hide_root_node = false,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
        },
      },
      window = {
        position = "right", -- Position on right side
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["H"] = "toggle_hidden",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = true, title = "Preview" } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "󰉋",
          folder_open = "󰝰",
          folder_empty = "󰉖",
          folder_empty_open = "󰷏",
          default = "󰈤", -- Placeholder for default icon
          highlight = "NeoTreeFileIcon",
          provider = function(icon, node, state)
            if node.type == "file" then
              local name = node.name
              local ext = name:match("%.([^%.]+)$")

              if ext then
                -- Scripts
                if
                  ext == "sh"
                  or ext == "bash"
                  or ext == "zsh"
                  or ext == "fish"
                  or ext == "ps1"
                  or ext == "bat"
                  or ext == "cmd"
                then
                  icon.text = "󰑷"
                -- Configs
                elseif
                  ext == "conf"
                  or ext == "yaml"
                  or ext == "yml"
                  or ext == "toml"
                  or ext == "json"
                  or ext == "ini"
                  or ext == "cfg"
                  or ext == "env"
                  or ext == "properties"
                  or ext == "xml"
                then
                  icon.text = "󱁼"
                -- Markdown
                elseif ext == "md" or ext == "markdown" or ext == "mdx" then
                  icon.text = "󰧮"
                -- Images
                elseif
                  ext == "png"
                  or ext == "jpg"
                  or ext == "jpeg"
                  or ext == "gif"
                  or ext == "svg"
                  or ext == "webp"
                  or ext == "bmp"
                  or ext == "ico"
                  or ext == "mp4"
                  or ext == "mov"
                  or ext == "avi"
                  or ext == "mkv"
                  or ext == "webm"
                  or ext == "flv"
                  or ext == "wmv"
                then
                  icon.text = "󰺰"

                -- Programming languages
                elseif
                  ext == "js"
                  or ext == "ts"
                  or ext == "tsx"
                  or ext == "jsx"
                  or ext == "py"
                  or ext == "go"
                  or ext == "rs"
                  or ext == "java"
                  or ext == "c"
                  or ext == "cpp"
                  or ext == "h"
                  or ext == "hpp"
                  or ext == "rb"
                  or ext == "php"
                  or ext == "lua"
                  or ext == "vim"
                  or ext == "cs"
                  or ext == "swift"
                  or ext == "kt"
                  or ext == "scala"
                  or ext == "r"
                  or ext == "m"
                  or ext == "mm"
                then
                  icon.text = "󱀫"
                else
                  icon.text = "󰈤"
                end
              else
                icon.text = ""
              end
            end
          end,
        },
        git_status = {
          symbols = {
            -- Change type
            added = "✚", -- NOTE: you can set any of these to an empty string to not show them
            deleted = "✖",
            modified = "",
            renamed = "󰁕",
            -- Status type
            untracked = "U",
            ignored = "I",
            unstaged = "M",
            staged = "S",
            conflict = "C",
          },
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}
