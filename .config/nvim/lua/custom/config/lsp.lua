-- Main table for all lsp opts
local servers = {
  lua_ls = {
    setting = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  ruff = {},
  basedpyright = {
    setting = {
      basedpyright = {
        analysis = { typeCheckingMode = "off" },
      },
    },
  },
}
