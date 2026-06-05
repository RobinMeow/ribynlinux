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
  -- For additional information with loading, sourcing and examples see:
  -- `<space>sh` search for `lazy.nvim-plugin`

  -- imports lua files from lua/plugins/*
  { import = "plugins" },

  -- LSP Plugins
  -- INFO: temporarly disabled in favor of easy-dotnet.
  -- becuase it crashes on startup for some optional razor feature
  -- { -- dotnet .NET
  -- 	"seblyng/roslyn.nvim",
  -- 	---@module 'roslyn.config'
  -- 	---@type RoslynNvimConfig
  -- 	opts = {},
  -- },
  {
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
          -- dotnet required registries
          registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry",
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
          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

          map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          --  To jump back, press <C-t>.
          map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- INFO: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          --  Symbols are things like variables, functions, types, etc.
          map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

          --  Similar to document symbols, except searches over your entire project.
          map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
          then
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

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
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

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        ["bashls"] = {
          filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
        },
        ["ts_ls"] = {}, -- https://github.com/pmizio/typescript-tools.nvim can be considered when more speed is required
        ["eslint"] = {},
        ["shellcheck"] = {},
        ["shellharden"] = {},
        ["angularls"] = {},
        ["cssls"] = {},
        ["html"] = {},
        ["pyright"] = {},
        ["rust_analyzer"] = {},
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

      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
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
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true, cs = true, cs = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
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

  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        -- these parsers must always be installed according to treestitter
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "yaml",

        -- my chosen parsers or from kickstart
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
      },
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
    },
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
