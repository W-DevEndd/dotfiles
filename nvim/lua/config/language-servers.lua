
--- @type table<string,vim.lsp.Config>
local servers = {
    "pyright",
    "lua_ls",
    "ts_ls",
    "nixd",
    "html",
    "clangd",
    "hyprls",
    "jsonls",
    "cssls",
    qmlls = {
        cmd = {"qmlls6"},
        filetypes = { "qml" }
    }
}

return servers
