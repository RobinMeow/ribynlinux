require("options")
require("keymaps")

--require("idle-numbers").setup()

-- no "press Enter" interrupptions
-- replace pager with normal buffer
-- g< to show the last output
require("vim._core.ui2").enable({})

require("highlight-on-yank")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
  -- For additional information with loading, sourcing and examples see: `<space>sh` search for `lazy.nvim-plugin`

  { import = "plugins" }, -- imports lua files from lua/plugins/*

  -- LSP Plugins
  {
    ft = { "cs", "csproj", "sln", "slnx" },
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("easy-dotnet").setup({
        lsp = {
          auto_refresh_codelens = false,
        },
      })
    end,
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      {
        "mason-org/mason.nvim",
        opts = {
          registries = {
            "github:mason-org/mason-registry",
            -- "github:Crashdummyy/mason-registry", -- dotnet required registries required if using crashdummys more frequantly updated version
          },
        },
      },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp", -- capabilities
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
          map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition") -- To jump back, press <C-t>
          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols") -- Symbols are things like variables, functions, types, etc
          map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols") -- Similar to document symbols, except searches over your entire project

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

          -- highlight word on CursorHold and clear highlight on CursorMoved
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight", event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints
          if client and client:supports_method("textDocument/inlayHint", event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- Diagnostic Config See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = false, -- tiny-inline-diagnostic has its own display
        -- virtual_text = {
        -- 	source = "if_many",
        -- 	spacing = 2,
        -- 	format = function(diagnostic)
        -- 		local diagnostic_message = {
        -- 			[vim.diagnostic.severity.ERROR] = diagnostic.message,
        -- 			[vim.diagnostic.severity.WARN] = diagnostic.message,
        -- 			[vim.diagnostic.severity.INFO] = diagnostic.message,
        -- 			[vim.diagnostic.severity.HINT] = diagnostic.message,
        -- 		}
        -- 		return diagnostic_message[diagnostic.severity]
        -- 	end,
        -- },
      })

      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      local servers = {
        ["bashls"] = {
          filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
        },
        ["ts_ls"] = {
          on_attach = function(client, bufnr)
            -- some clients support workspace diagnostics natively
            if client:supports_method("workspace/diagnostic", bufnr) then
              vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
            else
              require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
            end
          end,
        }, -- https://github.com/pmizio/typescript-tools.nvim can be considered when more speed is required
        ["clangd"] = {}, -- ls for cpp c++ cpluscplus
        ["clang-format"] = {}, -- formatter for cpp c++ cpluscplus
        ["codelldb"] = {}, -- DAP for c/c++/rust/zig	(its installed via dap/debug.lua)
        ["netcoredbg"] = {}, -- dotnet
        ["eslint"] = {},
        ["shellcheck"] = {},
        ["shellharden"] = {},
        ["angularls"] = {},
        ["cssls"] = {},
        ["html"] = {},
        ["pyright"] = {},
        ["rust_analyzer"] = {},
        -- ["roslyn_ls"] = {}, -- still making things slow i think with easy dotnet
        -- Special Lua Config, as recommended by neovim help docs
        ["lua_ls"] = {
          on_init = function(client)
            client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
              then
                return
              end
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
              runtime = {
                version = "LuaJIT",
                path = { "lua/?.lua", "lua/?/init.lua" },
              },
              workspace = {
                checkThirdParty = false,
                -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
                  "${3rd}/luv/library",
                  "${3rd}/busted/library",
                }),
              },
            })
          end,
          ---@type lspconfig.settings.lua_ls
          settings = {
            Lua = {
              format = { enable = false }, -- Disable formatting (formatting is done by stylua)
            },
          },
        },
        ["prettierd"] = {},
        ["prettier"] = {},
        ["shfmt"] = {},
        ["yaml-language-server"] = {},
        ["yamlfmt"] = {},
        ["yamllint"] = {},
        ["eslint_d"] = {},
        ["stylua"] = {},
        ["markdownlint"] = {},
        ["vale"] = {},
      }

      require("mason-tool-installer").setup({ ensure_installed = vim.tbl_keys(servers or {}) })

      for name, config in pairs(servers) do
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      -- NOTE: requires rosyln-language-server to be in path. dotnet tool install -g roslyn-language-server --prerelease
      -- WARN: do not enable manually when using easy-dotnet
      -- vim.lsp.config("roslyn_ls", {
      --   settings = {
      --     -- WARN: dont seem to work at all. leaving defaults to have less issues.
      --     -- available options https://github.com/dotnet/vscode-csharp/blob/main/test/lsptoolshost/unitTests/configurationMiddleware.test.ts
      --     -- ["csharp|background_analysis"] = {
      --     -- 	dotnet_analyzer_diagnostics_scope = false,
      --     -- 	dotnet_compiler_diagnostics_scope = false,
      --     -- },
      --     -- settings = {
      --     -- 	["csharp|inlay_hints"] = {
      --     -- 		dotnet_enable_inlay_hints_for_parameters = false,
      --     -- 		dotnet_enable_inlay_hints_for_literal_parameters = false,
      --     -- 		dotnet_enable_inlay_hints_for_indexer_parameters = false,
      --     -- 		csharp_enable_inlay_hints_for_implicit_variable_types = false,
      --     -- 	},
      --     -- 	["csharp|code_lens"] = {
      --     -- 		dotnet_enable_references_code_lens = true,
      --     -- 	},
      --     -- },
      --   },
      -- })
      -- vim.lsp.enable("roslyn_ls")
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true, cs = true, csproj = true, sln = true, slnx = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback", -- Use external formatters if configured below, otherwise use LSP formatting
          }
        end
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        sh = { "shfmt", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        htmlangular = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        sass = { "prettierd", "prettier", stop_after_first = true },
        cs = { "csharpier", stop_after_first = true },
        csproj = { "csharpier", stop_after_first = true },
      },
    },
  },

  { -- Highlight, edit, and navigate code See `:help nvim-treesitter`
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "main",
    config = function()
      require("nvim-treesitter").setup({
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
      })
      require("nvim-treesitter").install({
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "yaml",
        "bash",
        "diff",
        "html",
        "luadoc",
        "javascript",
        "json",
        "python",
        "regex",
        "tsx",
        "typescript",
        "cpp",
      })
    end,
  },
}, {
  ui = {
    icons = {}, -- if nerd_font is missing consider pasting some emojis in here from kickstart
    border = "rounded",
  },
})
vim.cmd("TransparentEnable")

local function get_kanagawa_variant()
  local hour = tonumber(os.date("%H"))
  local min = tonumber(os.date("%M"))
  local currentTime = hour + (min / 60)

  -- 9:00 AM to 8:00 PM (20.0 in decimal)
  if currentTime >= 9 and currentTime < 19 then
    Snacks.notifier.notify("Colorscheme: Kanagawa-wave (Day)", "info")
    return "kanagawa-wave"
  else
    Snacks.notifier.notify("Colorscheme: Kanagawa-dragon (Day)", "info")
    return "kanagawa-dragon"
  end
end

vim.cmd("colorscheme " .. get_kanagawa_variant())

-- show diagnostic beneath cursor while resting
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil, {
-- 			focusable = false,
-- 			border = "rounded", -- This will use your FloatBorder highlight
-- 			source = "always",
-- 			prefix = " ",
-- 			scope = "cursor",
-- 		})
-- 	end,
-- })
