return {
  -- Mason will auto-install LSPs for Python, Rust, Markdown, JSON, TOML, YAML, Protobuf
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "rust-analyzer",
        "marksman",
        "json-lsp",
        "taplo",
        "yaml-language-server",
        "buf",
      },
      PATH = "append",
    },
    -- Defer mason setup off the LazyFile hot path.
    -- Mason bin is already on PATH via options.lua, so LSP servers start fine.
    -- vim.schedule runs FIFO, so this completes before lspconfig's vim.schedule_wrap'd config.
    config = function(_, opts)
      vim.schedule(function()
        require("mason").setup(opts)
        local mr = require("mason-registry")
        mr:on("package:install:success", function()
          vim.defer_fn(function()
            require("lazy.core.handler.event").trigger({
              event = "FileType",
              buf = vim.api.nvim_get_current_buf(),
            })
          end, 100)
        end)
        mr.refresh(function()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end)
      end)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          on_new_config = function(config, root_dir)
            -- Check for .venv version first
            local venv_ruff = root_dir .. "/.venv/bin/ruff"
            if vim.fn.executable(venv_ruff) == 1 then
              config.cmd = { venv_ruff, "server", "--preview" }
            end
            -- Otherwise use Mason-installed version (default cmd)
          end,
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = {
                command = "clippy",
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        marksman = {},
        jsonls = {
          on_new_config = function(config)
            config.settings = {
              json = {
                schemas = vim.list_extend({}, require("schemastore").json.schemas()),
                validate = { enable = true },
              },
            }
          end,
        },
        taplo = {},
        yamlls = {
          on_new_config = function(config)
            config.settings = {
              yaml = {
                schemaStore = {
                  enable = false,
                  url = "",
                },
                schemas = require("schemastore").yaml.schema(),
              },
            }
          end,
        },
        bufls = {},
      },
    },
  },
  -- Add schemastore for json/yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
}
