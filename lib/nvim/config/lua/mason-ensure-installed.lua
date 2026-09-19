return {
  ["bashls"] = {
    filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
  },
  ["gopls"] = {}, -- go (programming) language server (the p is probably a pun ..) (includes gofmt formatter)
  ["golangci-lint"] = {}, -- go linter (which runs multiple linters)
  ["delve"] = {}, -- go debugger
  ["goimports"] = {}, -- go formatter, import manager
  -- ["gofumpt"] = {}, -- stricter (probably opioniated) go formatter
  ["tsc"] = {
    -- on_attach = function(client, bufnr)
    -- end,
  },
  -- ["tsgo"] = {},
  -- ["ts_ls"] = {
  --   -- NOTE: was kinda nice, but I did notice the start up being slower and the benefits werent that great. so disabled for now again
  --   -- on_attach = function(client, bufnr)
  --   --   -- some clients support workspace diagnostics natively
  --   --   if client:supports_method("workspace/diagnostic", bufnr) then
  --   --     vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
  --   --   else
  --   --     require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
  --   --   end
  --   -- end,
  -- }, -- https://github.com/pmizio/typescript-tools.nvim can be considered when more speed is required
  ["clangd"] = {}, -- ls for cpp c++ cpluscplus
  ["clang-format"] = {}, -- formatter for cpp c++ cpluscplus
  ["codelldb"] = {}, -- DAP for c/c++/rust/zig	(its installed via dap.lua)
  ["netcoredbg"] = {}, -- dotnet
  ["eslint"] = {},
  ["shellcheck"] = {},
  ["shellharden"] = {},
  ["angularls"] = {},
  ["cssls"] = {},
  ["html"] = {
    -- NOTE: in testing. comment out again, if not good.
    filetypes = { "html", "htmlangular" },
  },
  ["pyright"] = {},
  ["qmlls"] = {},
  ["rust_analyzer"] = {},
  -- ["roslyn_ls"] = {},
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
  ["csharpier"] = {},
  ["shfmt"] = {},
  ["yaml-language-server"] = {},
  ["yamlfmt"] = {},
  ["yamllint"] = {},
  ["eslint_d"] = {},
  ["stylua"] = {},
  ["markdownlint"] = {},
  ["vale"] = {},

  -- godot
  -- ["gdtoolkit"] = {},
  -- ["gdscript-formatter"] = {},
  -- ["gdscript"] = {
  --   name = "godot_editor",
  --   cmd = cmd,
  --   filetypes = { "gd", "gdscript", "gdshader", "gdscript3" },
  --   root_markers = { "project.godot", ".git" },
  --   capabilities = capabilities,
  --   on_attach = function(client, bufnr)
  --     utils.suppress_client_messages(client, { "Method not found: godot/reloadScript" })
  --     inline_hints.enable_for_buffer(client, bufnr)
  --   end,
  -- },
}
